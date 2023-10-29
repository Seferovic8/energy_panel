import 'package:energy_panel/_all.dart';
import 'package:http/http.dart';
//import 'package:color/color.dart' as cl;

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});
  static const routeName = '/statistika';
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
    required this.width,
    required this.height,
  });
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final nowDate = DateTime.now().copyWith(hour: 0, second: 0, minute: 0, microsecond: 0, millisecond: 0);
    if (context.read<StatisticsBloc>().state.model == null) {
      context.read<StatisticsBloc>().add(SubmitStatisticsEvent(
              statisticsModel: GetStatisticsModel(
            startDate: nowDate,
            endDate: nowDate.add(const Duration(days: 1)),
          )));
    }
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
            PeriodSelectionWidget(),
            const SizedBox(height: 15),
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
                            ConsumptionWidget(width: width),
                            BillWidget(width: width),
                            EnergyWidget(width: width),
                            ChartWidget(width: width, chartWidgetType: ChartWidgetType.meter),
                            GainWidget(width: width),
                            ChartWidget(width: width, chartWidgetType: ChartWidgetType.inverter),
                            //  ChartWidget(width: width),
                            //SMAWidget(width: width),
                            //const RealTimeWidget(),
                            //InverterWidget(width: width),
                          ],
                        ),
                      ),
                    ],
                  ),
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
