// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
// ignore_for_file: must_be_immutable

import 'package:energy_panel/_all.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;
    return Scaffold(
      body: ScrollWidget(
        width: width,
        child: SafeArea(
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
                  height: height,
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
    required this.height,
  }) : super(key: key);
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      constraints: const BoxConstraints(minWidth: 1200 - 1200 * 0.16666667),
      padding: const EdgeInsets.only(left: 24, right: 24),
      width: width - width * 0.16666667,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pregled potrošnje u realnom vremenu',
                  style: GoogleFonts.nunitoSans(fontSize: 24, color: ColorsPalette.whiteSmoke, fontWeight: FontWeight.w400),
                ),
                Text(
                  DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0).toString().replaceAll('00:00:00.000', ''),
                  style: GoogleFonts.nunitoSans(fontSize: 17, color: ColorsPalette.whiteSmoke),
                ),
              ],
            ),
            const SizedBox(height: 25),
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
                      EnergyFlow(energyFlowType: EnergyFlowType.solar, width: width),
                      const SizedBox(height: 150),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          EnergyFlow(energyFlowType: EnergyFlowType.consumer, width: width),
                          SizedBox(width: width * 0.5),
                          EnergyFlow(energyFlowType: EnergyFlowType.grid, width: width),
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
    );
  }
}
