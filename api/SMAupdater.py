import datetime
import asyncio
import time
import pymongo
import smameter.smameter as smameter
import huaweisolar.inverter as solar
client = pymongo.MongoClient("mongodb://localhost:27017/")
db = client["energy_panel"]
collection = db["metrics"]

async def main():
    try:
        sma = smameter.SmaMeter()
        inverter = solar.Inverter("192.168.3.105")
        login_succes = await sma.login()
        if not login_succes:
            login_succes = await sma.login()
        inverter.connect()
        if not inverter.connected:
            inverter.connect()
        if not login_succes or not inverter.connected:
            urllib.request.urlopen(
                f"https://api.callmebot.com/whatsapp.php?phone=+38763317223&text=Problem.%20Konekcija%20nije%20uspjela.%20SMA%20metar={login_succes},%20Inverter={inverter.connected}&apikey=615807"
            )
            return
        time.sleep(2)
        start = time.time()
        while True:
            sma_power, sma_voltage, sma_current = await sma.getValuesFromSMA()
            inverter_power,inverter_voltage,inverter_current= inverter.getValuesFromInverter()
            time_proceed = (time.time() - start) / 3600
            consumption_power = sma_power + inverter_power
            if(consumption_power<0):
                consumption_power=0
            data = {
                "date": datetime.datetime.now(),
                "consumption_power": consumption_power,
                "consumption": consumption_power * time_proceed,
                "sma": {
                    "power": sma_power,
                    "voltage": sma_voltage,
                    "current": sma_current,
                    "consumption": sma_power * time_proceed,
                },
                "inverter": {
                    "power": inverter_power,
                    "voltage": inverter_voltage,
                    "current": inverter_current*2,
                    "energy": inverter_power * time_proceed,
                },
            }
            collection.insert_one(data)
            start = time.time()
            time.sleep(1)
    except Exception as e:
        print(e)
        urllib.request.urlopen(
            f"https://api.callmebot.com/whatsapp.php?phone=+38763317223&text=Exception.%20{e}&apikey=615807"
        )
        await sma.logout(session)
        await sma.session.close()

if __name__ == "__main__":
    asyncio.run(main())

