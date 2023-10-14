
// ignore_for_file: must_be_immutable

import 'package:energy_panel/_all.dart';
import 'dart:ui' as ui;
enum EnergyFlowType {
  solar,
  grid,
  consumer,
}
class EnergyFlow extends StatelessWidget {
  EnergyFlow({
    Key? key,
    required this.energyFlowType,
    required this.width,
  }) : super(key: key);
  final EnergyFlowType energyFlowType;
  late double data;
  late String name;
  late IconData iconData;
  final double width;
  late Color color;
  @override
  Widget build(BuildContext context) {
    if (energyFlowType == EnergyFlowType.solar) {
      color = ColorsPalette.yellowBorder;
      iconData = Icons.solar_power_outlined;
      name = 'Solari';
    } else if (energyFlowType == EnergyFlowType.grid) {
      color = ColorsPalette.pinkBorder;
      name = 'Mreža';
      iconData = MdiIcons.transmissionTower;
    } else if (energyFlowType == EnergyFlowType.consumer) {
      color = ColorsPalette.lightBlue;
      name = 'Potrošač';
      iconData = Icons.cottage;
    }
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 6,
            blurStyle: BlurStyle.outer,
            color: color.withOpacity(0.9),
          ),
        ],
      ),
      child: BlocBuilder<RealtimeBloc, RealtimeState>(
        builder: (context, state) {
          if (state.status == RealtimeStateStatus.submittingSuccess) {
            if (energyFlowType == EnergyFlowType.solar) {
              data = state.model!.inverter.power / 1000;
            } else if (energyFlowType == EnergyFlowType.grid) {
              final double solar = state.model!.inverter.power;
              final double consumption = state.model!.sma.power;
              if (solar > consumption) {
                data = (solar - consumption) / 1000;
              } else {
                data = (consumption - solar) / 1000;
              }
            } else if (energyFlowType == EnergyFlowType.consumer) {
              data = state.model!.sma.power / 1000;
            }
            return CustomPaint(
              foregroundPainter: LinePainter(
                width: width,
                energyFlowType: energyFlowType,
                shaders: {
                  0: state.model!.inverter.power / state.model!.consumptionPower,
                  1: state.model!.inverter.power > state.model!.consumptionPower ? 1 - (state.model!.consumptionPower / state.model!.inverter.power) : 0,
                  2: state.model!.inverter.power < state.model!.consumptionPower ? (state.model!.consumptionPower - state.model!.inverter.power) / state.model!.consumptionPower : 0,
                },
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        iconData,
                        color: color,
                        size: 30,
                      ),
                      Text(
                        data.toStringAsFixed(3),
                        style: GoogleFonts.nunitoSans(fontSize: 15, color: ColorsPalette.whiteSmoke),
                      ),
                      Text(
                        'kW',
                        style: GoogleFonts.nunitoSans(fontSize: 15, color: ColorsPalette.whiteSmoke),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
class LinePainter extends CustomPainter {
  final EnergyFlowType energyFlowType;
  final Map<int, double> shaders;
  final double width;
  LinePainter({
    required this.energyFlowType,
    required this.shaders,
    required this.width,
  });

  void drawLine(Offset line1X1, Offset line1X2, Offset line1Y1, Offset line1Y2, Offset line2X1, Offset line2X2, Offset line2Y1, Offset line2Y2, Paint paint, Canvas canvas) {
    if (shaders[0]! > 0.05) {
      paint.shader = ui.Gradient.linear(line1X1, line1Y2, [
        ColorsPalette.orangeLine,
        ColorsPalette.lightBlue,
      ]);
    } else {
      paint.color = ColorsPalette.grayLine;
      paint.shader = null;
    }

    canvas.drawLine(
      line1X1,
      line1Y1,
      paint,
    );
    canvas.drawLine(
      line1X2,
      line1Y2,
      paint,
    );
    if (shaders[1]! > 0.05) {
      paint.shader = ui.Gradient.linear(line2X1, line2Y2, [
        ColorsPalette.orangeLine,
        ColorsPalette.purpleLine,
      ]);
    } else {
      paint.color = ColorsPalette.grayLine;
      paint.shader = null;
    }
    canvas.drawLine(
      line2X1,
      line2Y1,
      paint,
    );
    canvas.drawLine(
      line2X2,
      line2Y2,
      paint,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 3; i++) {
      if (shaders[i]! > 1) {
        shaders[i] = 1;
      }
    }
    final Paint paint = Paint()..strokeWidth = 3;
    paint.strokeCap = StrokeCap.round;
    late Offset line1X1;
    late Offset line1X2;
    late Offset line1Y1;
    late Offset line1Y2;
    late Offset line2X1;
    late Offset line2X2;
    late Offset line2Y1;
    late Offset line2Y2;

    if (energyFlowType == EnergyFlowType.solar) {
      line1X1 = Offset(size.width / 2 - 5, size.height + 4);
      line1Y1 = Offset(size.width / 2 - 5, size.height * 3 + 4);
      line1X2 = Offset(size.width / 2 - 5, size.height * 3 + 4);
      line1Y2 = Offset(-(width * 0.25 - size.width / 2), size.height * 3 + 4);

      line2X1 = Offset(size.width / 2 + 5, size.height + 4);
      line2Y1 = Offset(size.width / 2 + 5, size.height * 3 + 4);
      line2X2 = Offset(size.width / 2 + 5, size.height * 3 + 4);
      line2Y2 = Offset(width * 0.25 + size.width / 2, size.height * 3 + 4);

      //final shader2 = shaders[1];
      drawLine(line1X1, line1X2, line1Y1, line1Y2, line2X1, line2X2, line2Y1, line2Y2, paint, canvas); // canvas.drawLine(
    } else if (energyFlowType == EnergyFlowType.consumer) {
      print('uso');
      final Offset x1 = Offset(size.width + 2, size.height / 2 + 5);
      final Offset y1 = Offset(width * 0.5 + size.width, size.height / 2 + 5);
      //final Offset y1 = Offset(size.width * 7, size.height / 2 + 5);
      paint.color = ColorsPalette.grayLine;
      paint.shader = null;
      if (shaders[2]! > 0.05) {
        paint.shader = ui.Gradient.linear(x1, y1, [
          ColorsPalette.lightBlue,
          ColorsPalette.purpleLine,
        ]);
      }

      canvas.drawLine(x1, y1, paint);
    }

    // Path path = Path();
    // path.moveTo(0, 0); //Ax, Ay
    // path.lineTo(100, 0); //Bx, By, Cx, Cy
    // path.quadraticBezierTo(100, 0, 100, 50); //Bx, By, Cx, Cy
    // path.lineTo(150, 50); //Bx, By, Cx, Cy
    // //path.quadraticBezierTo(0, 3 * size.height / 8, size.width / 2, size.height / 2); //Dx, Dy, Ex, Ey
    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
