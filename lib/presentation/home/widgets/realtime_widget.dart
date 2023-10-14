import 'package:energy_panel/_all.dart';

class RealTimeWidget extends StatelessWidget {
  const RealTimeWidget();

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
            'Prikaz u realnom vremenu',
            style: GoogleFonts.nunitoSans(
              fontSize: 17,
              color: ColorsPalette.whiteSmoke,
            ),
          ),
        ),
        Expanded(child: Center(child: BlocBuilder<RealtimeBloc, RealtimeState>(
          builder: (context, state) {
            if (state.status == RealtimeStateStatus.submittingSuccess) {
              return SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                      minimum: 0,
                      maximum: 5000,
                      showLabels: false,
                      showTicks: false,
                      axisLineStyle: const AxisLineStyle(
                        thickness: .2,
                        cornerStyle: CornerStyle.bothFlat,
                        color: ColorsPalette.gray3,
                        thicknessUnit: GaugeSizeUnit.factor,
                      ),
                      pointers: [
                        RangePointer(
                          value: state.model!.sma.power,
                          cornerStyle: CornerStyle.bothFlat,
                          width: 0.2,
                          sizeUnit: GaugeSizeUnit.factor,
                          color: ColorsPalette.lightgreen,
                        )
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          positionFactor: 0.1,
                          angle: 90,
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.model!.sma.power.toString(),
                                style: GoogleFonts.nunitoSans(fontSize: 65, color: ColorsPalette.red),
                              ),
                              Text(
                                'W',
                                style: GoogleFonts.nunitoSans(fontSize: 65, color: ColorsPalette.red),
                              ),
                            ],
                          ),
                        )
                      ])
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