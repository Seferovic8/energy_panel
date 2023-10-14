// ignore_for_file: must_be_immutable

import 'package:energy_panel/_all.dart';

class InverterWidget extends StatelessWidget {
  final double width;

  const InverterWidget({required this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorsPalette.cardColor, borderRadius: BorderRadius.circular(4)),
      child: Column(children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, .2), style: BorderStyle.solid, width: 2),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          child: Text(
            textAlign: TextAlign.start,
            'Inverter',
            style: GoogleFonts.nunitoSans(
              fontSize: 17,
              color: ColorsPalette.whiteSmoke,
            ),
          ),
        ),
        Expanded(child: Center(child: BlocBuilder<RealtimeBloc, RealtimeState>(
          builder: (context, state) {
            if (state.status == RealtimeStateStatus.submittingSuccess) {
              return GridView(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 139,
                  mainAxisSpacing: 15,
                ),
                children: [
                  _InverterDataItem(itemType: _DataItemType.power, model: state.model!.inverter, width: width),
                  _InverterDataItem(itemType: _DataItemType.energy, model: state.model!.inverter, width: width),
                  _InverterDataItem(itemType: _DataItemType.voltage, model: state.model!.inverter, width: width),
                  _InverterDataItem(itemType: _DataItemType.current, model: state.model!.inverter, width: width),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ))),
      ]),
    );
  }
}

enum _DataItemType {
  voltage,
  current,
  power,
  energy,
}

class _InverterDataItem extends StatelessWidget {
  _InverterDataItem({
    required this.itemType,
    required this.model,
    required this.width,
  });
  final _DataItemType itemType;
  final InverterModel model;
  late double width;
  late String name;
  late String unit;
  late String data;
  late IconData iconData;
  @override
  Widget build(BuildContext context) {
    if (itemType == _DataItemType.voltage) {
      name = 'Napon';
      unit = 'V';
      data = model.voltage.toString();
      iconData = Icons.bolt_outlined;
    } else if (itemType == _DataItemType.current) {
      name = 'Struja';
      unit = 'A';
      data = model.current.toString();
      iconData = Icons.keyboard_double_arrow_right_outlined;
    } else if (itemType == _DataItemType.power) {
      name = 'Proizvodnja';
      unit = 'W';
      iconData = Icons.solar_power_outlined;
      data = (model.power).toStringAsFixed(3);
    } else if (itemType == _DataItemType.energy) {
      iconData = Icons.score_outlined;
      name = 'Ukupna proizvodnja u posljednjih 24h';
      unit = 'kWh';
      data = (model.energy / 1000).toStringAsFixed(3);
    }
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorsPalette.lightgreen),
        boxShadow: [
          BoxShadow(
            color: ColorsPalette.lightgreen.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 7,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
        // color: Color.fromRGBO(56, 67, 107, 0.8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(iconData, color: ColorsPalette.lightgreen, size: 36),
          Text('$data $unit', style: GoogleFonts.nunitoSans(fontSize: itemType == _DataItemType.energy && width <= 1270 ? 15 : 20, color: ColorsPalette.whiteSmoke, fontWeight: FontWeight.w800)),
          Text(
            name,
            style: GoogleFonts.nunitoSans(fontSize: itemType == _DataItemType.energy && width <= 1375 ? 14 : 15, color: ColorsPalette.gray2, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
