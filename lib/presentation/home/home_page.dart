// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
// ignore_for_file: must_be_immutable

import 'dart:math';
import 'dart:ui' as ui;
import 'package:energy_panel/_all.dart';

class ScrollWidget extends StatelessWidget {
  const ScrollWidget({super.key, required this.width, required this.child});
  final double width;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    if (width < 1210) {
      print('scroll');
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: child,
      );
    }
    return child;
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    context.read<RealtimeBloc>().add(LoadRealtimeEvent());
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;
    return Scaffold(
      body: ScrollWidget(
        width: width,
        child: SafeArea(
          //-webkit-gradient(linear,right top,left bottom,from(#216e93),color-stop(#21648a),color-stop(#1f5881),color-stop(#172d5b),to(#191c51))
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF216E93),
                  Color(0xFF21648A),
                  Color(0xFF1F5881),
                  Color(0xFF172D5B),
                  Color(0xFF191C51),
                ],
              ),
            ),
            child: Row(
              children: [
                NavBar(
                  height: height,
                  width: width,
                ),
                _DataWidget(
                  width: width,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DataWidget extends StatelessWidget {
  _DataWidget({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      constraints: const BoxConstraints(minWidth: 1200 - 1200 * 0.16666667),
      padding: const EdgeInsets.only(left: 24, right: 24),
      //width: width > 1200 ? width - width * 0.16666667 : 1200 - 1200 * 0.16666667,
      width: width - width * 0.16666667,
      child: SingleChildScrollView(
        //ListView(
        //scrollDirection: Axis.vertical,
        child: //[
            Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pregled potrošnje u realnom vremenu',
                    style: GoogleFonts.nunitoSans(fontSize: 24, color: ColorsPalette.whiteSmoke, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0).toString().replaceAll('00:00:00.000', ''),
                    style: GoogleFonts.nunitoSans(fontSize: 14, color: ColorsPalette.whiteSmoke),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GridView(
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 15,
                            mainAxisExtent: 365.5,
                            mainAxisSpacing: 15,
                          ),
                          children: [
                            SMAWidget(width: width),
                            const RealTimeWidget(),
                            InverterWidget(width: width),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      EnergyFlow(energyFlowType: _EnergyFlowType.solar, width: width),
                      const SizedBox(height: 150),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          EnergyFlow(energyFlowType: _EnergyFlowType.consumer, width: width),
                          SizedBox(width: width * 0.5),
                          EnergyFlow(energyFlowType: _EnergyFlowType.grid, width: width),
                        ],
                      ),
                      const SizedBox(height: 25),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        //    ],
      ),
    ));
  }
}

// zuta #fee287

class LinePainter extends CustomPainter {
  final _EnergyFlowType energyFlowType;
  final Map<int, double> shaders;
  final double width;
  LinePainter({
    required this.energyFlowType,
    required this.shaders,
    required this.width,
  });

  void drawLine(Offset line1X1, Offset line1X2, Offset line1Y1, Offset line1Y2, Offset line2X1, Offset line2X2, Offset line2Y1, Offset line2Y2, Paint paint, Canvas canvas, Shader shader1, Shader shader2) {
    paint.shader = shader1;
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
    paint.shader = shader2;
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

    if (energyFlowType == _EnergyFlowType.solar) {
      line1X1 = Offset(size.width / 2 - 5, size.height + 4);
      line1Y1 = Offset(size.width / 2 - 5, size.height * 3 + 4);
      line1X2 = Offset(size.width / 2 - 5, size.height * 3 + 4);
      line1Y2 = Offset(-(width * 0.25 - size.width / 2), size.height * 3 + 4);

      line2X1 = Offset(size.width / 2 + 5, size.height + 4);
      line2Y1 = Offset(size.width / 2 + 5, size.height * 3 + 4);
      line2X2 = Offset(size.width / 2 + 5, size.height * 3 + 4);
      line2Y2 = Offset(width * 0.25 + size.width / 2, size.height * 3 + 4);

      final shader1 = ui.Gradient.linear(
          line1X1,
          line1Y2,
          shaders[0]! > 0.05
              ? [
                  ColorsPalette.orangeLine.withOpacity(shaders[0]!),
                  ColorsPalette.lightBlue.withOpacity(shaders[0]!),
                ]
              : [
                  ColorsPalette.gray2.withOpacity(0.8),
                  ColorsPalette.gray2.withOpacity(0.3),
                ]);
      final shader2 = ui.Gradient.linear(
          line2X1,
          line2Y2,
          shaders[1]! > 0.05
              ? [
                  ColorsPalette.orangeLine.withOpacity(shaders[1]!),
                  ColorsPalette.purpleLine.withOpacity(shaders[1]!),
                ]
              : [
                  ColorsPalette.gray2.withOpacity(0.8),
                  ColorsPalette.gray2.withOpacity(0.3),
                ]);
      //final shader2 = shaders[1];
      drawLine(line1X1, line1X2, line1Y1, line1Y2, line2X1, line2X2, line2Y1, line2Y2, paint, canvas, shader1, shader2); // canvas.drawLine(
    } else if (energyFlowType == _EnergyFlowType.consumer) {
      print('uso');
      final Offset x1 = Offset(size.width + 2, size.height / 2 + 5);
      final Offset y1 = Offset(width * 0.5 + size.width, size.height / 2 + 5);
      //final Offset y1 = Offset(size.width * 7, size.height / 2 + 5);

      paint.shader = ui.Gradient.linear(
          x1,
          y1,
          shaders[2]! > 0.05
              ? [
                  ColorsPalette.lightBlue.withOpacity(shaders[2]!),
                  ColorsPalette.purpleLine.withOpacity(shaders[2]!),
                ]
              : [
                  ColorsPalette.gray2.withOpacity(0.8),
                  ColorsPalette.gray2.withOpacity(0.3),
                ]);
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

enum _EnergyFlowType {
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
  final _EnergyFlowType energyFlowType;
  late double data;
  late String name;
  late IconData iconData;
  final double width;
  late Color color;
  @override
  Widget build(BuildContext context) {
    if (energyFlowType == _EnergyFlowType.solar) {
      color = ColorsPalette.yellowBorder;
      iconData = Icons.solar_power_outlined;
      name = 'Solari';
    } else if (energyFlowType == _EnergyFlowType.grid) {
      color = ColorsPalette.pinkBorder;
      name = 'Mreža';
      iconData = MdiIcons.transmissionTower;
    } else if (energyFlowType == _EnergyFlowType.consumer) {
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
            if (energyFlowType == _EnergyFlowType.solar) {
              data = state.model!.inverter.power / 1000;
            } else if (energyFlowType == _EnergyFlowType.grid) {
              final double solar = state.model!.inverter.power;
              final double consumption = state.model!.sma.power;
              if (solar > consumption) {
                data = (solar - consumption) / 1000;
              } else {
                data = (consumption - solar) / 1000;
              }
            } else if (energyFlowType == _EnergyFlowType.consumer) {
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
