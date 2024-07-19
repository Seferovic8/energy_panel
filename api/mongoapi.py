from flask import Flask, jsonify, request, Response
from pymongo import MongoClient
import time
from json import JSONEncoder
import json
import datetime
from flask_cors import CORS 
# Sleep until utilize project
#time.sleep(20)

app = Flask(__name__)
client = MongoClient("mongodb://192.168.3.8:27017/")
db = client["energy_panel"]
collection = db["metrics"]
sma_flspots ={}
inverter_flspots ={}
date_listed =0 
CORS(app) 
# Function to watch for changes in MongoDB
def watch_mongo_changes():
    i = False
    with app.app_context():
        while True:
            if i == True:
                response=collection.find_one({"date":{"$gte":datetime.datetime.now().replace(hour=0,minute=0,second=0,microsecond=0)}}, {"_id": False}, sort=[("date", -1)])
                data = jsonify(response).get_data(as_text=True).replace("\n", "")
                yield f"data: {data}\n\n"
                time.sleep(1)
            else:
                i = True
                response = (
                    collection.find({"date":{"$gte":datetime.datetime.now().replace(hour=0,minute=0,second=0,microsecond=0)}}, {"_id": False})
                )
                consumption=0
                energy=0
                for x in response:
                    consumption+=x["consumption"]
                    energy+=x["inverter"]["energy"]
                response.rewind()
                new_data = response.sort([("date", -1)]).limit(1).next()
                new_data["consumption"]=consumption
                new_data["inverter"]["energy"]=energy
                data = jsonify(new_data).get_data(as_text=True).replace("\n", "")
                yield f"data: {data}\n\n"


@app.route("/get_last", methods=["POST"])
def get_last():
    try:
        query = request.json
        chart_type=query['chartType']
        startDate = datetime.datetime.strptime(query['startDate'], '%Y-%m-%dT%H:%M:%S.%fZ')
        endDate = datetime.datetime.strptime(query['endDate'], '%Y-%m-%dT%H:%M:%S.%fZ')

        # difference_seconds=(endDate- startDate).total_seconds()
        # if(difference_seconds<=86400):
        #     chart_type=0
        # elif(difference_seconds >86400 and difference_seconds <= 2592000):
        #     chart_type=1
        # else:
        #     chart_type=2
        response = collection.find({"date":{"$gte":startDate,"$lt":endDate}}, {"_id": False,"inverter":{"voltage":False, "current":False},"sma":{"voltage":False, "current":False}}).sort([("date", -1)])
        energy = 0
        consumption = 0
        sma_plus = 0
        sma_minus = 0
        global sma_flspots 
        global inverter_flspots
        sma_flspots ={}
        inverter_flspots ={}
        calculate_sma_power=0
        calculate_inverter_power=0
        for i, x in enumerate(response):
            consumption+=x["consumption"]
            energy+=x["inverter"]['energy']
            calculate_sma_power, calculate_inverter_power = get_chart_details(i,x,calculate_sma_power,calculate_inverter_power,chart_type)
            sma_power=x["sma"]["consumption"]
            if sma_power>0:
                sma_plus+=sma_power
            else:
                sma_minus+=abs(sma_power)

        response.rewind()
        new_data = {
            "consumption":consumption,
            "energy":energy,
            "inverter_flspots":inverter_flspots,
            "sma_flspots":sma_flspots,
            "sma_plus":sma_plus,
            "sma_minus":sma_minus,
            "chart_type":chart_type,
            "start_date":startDate,
            "end_date":endDate,
            }
        data = jsonify(new_data), 200
        return data
    except Exception as e:
        print(e)

def get_chart_details(i, x,calculate_sma_power,calculate_inverter_power,chart_type ):
    global sma_flspots
    global inverter_flspots
    global date_listed
    if(chart_type==0):
        if(i%20!=0):
            calculate_sma_power+=x["consumption_power"]
            calculate_inverter_power+=x["inverter"]["power"]
        else:
            sma_flspots[str(x['date'])]=calculate_sma_power/20
            if(x['date']>datetime.datetime(x['date'].year,x['date'].month,x['date'].day,4,30) and x['date']<datetime.datetime(x['date'].year,x['date'].month,x['date'].day,21,20)):
                inverter_flspots[str(x['date'])]=calculate_inverter_power/20
            calculate_sma_power=0
            calculate_inverter_power=0
        return calculate_sma_power,calculate_inverter_power
    elif(chart_type==1):
        last_date = datetime.datetime(x['date'].year,x['date'].month,x['date'].day)
        if(i==0):
            date_listed=last_date
        if(last_date.day!=date_listed.day):
            date_listed=last_date
            calculate_sma_power=0
            calculate_inverter_power=0
        calculate_sma_power+=x["consumption"]
        calculate_inverter_power+=x["inverter"]["energy"]
        sma_flspots[str(date_listed)]=calculate_sma_power
        inverter_flspots[str(date_listed)]=calculate_inverter_power
        return calculate_sma_power,calculate_inverter_power

    elif(chart_type==2):
        last_date = datetime.datetime(x['date'].year,x['date'].month,1)
        if(i==0):
            date_listed=last_date
        if(last_date.month!=date_listed.month):
            date_listed=last_date
            calculate_sma_power=0
            calculate_inverter_power=0
        calculate_sma_power+=x["consumption"]
        calculate_inverter_power+=x["inverter"]["energy"]
        sma_flspots[str(date_listed)]=calculate_sma_power
        inverter_flspots[str(date_listed)]=calculate_inverter_power
        return calculate_sma_power,calculate_inverter_power
@app.route("/events", methods=["GET"])
def sse():
    response = Response(watch_mongo_changes(), content_type="text/event-stream")
    #response.headers["Access-Control-Allow-Origin"] = "*"
    #response.headers["Access-Control-Allow-Credentials"] = "true"
    return response


if __name__ == "__main__":
#    time.sleep(20)
    app.run(threaded=True, host="0.0.0.0")
