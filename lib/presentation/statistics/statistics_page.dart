import 'package:energy_panel/_all.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});
  static const routeName = "/statistika";
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
    context.read<StatisticsBloc>().add(SubmitStatisticsEvent(
            statisticsModel: GetStatisticsModel(
          startDate: nowDate,
          endDate: nowDate.add(const Duration(days: 1)),
        )));
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
            ElevatedButton(
              onPressed: () async {
                // showDialog(
                //     context: context,
                //     builder: (conntext) {
                //       return Dialog(
                //         child: SfDateRangePicker(
                //           view: DateRangePickerView.year,
                //         ),
                //       );
                //     });
                final DateTime? result = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2023),
                  lastDate: DateTime.now(),
                  currentDate: DateTime.now(),
                  initialDate: DateTime.now(),
                );
                if (result != null) {
                  context.read<StatisticsBloc>().add(SubmitStatisticsEvent(
                          statisticsModel: GetStatisticsModel(
                        startDate: result,
                        endDate: result.add(const Duration(days: 1)),
                      )));
                }
              },
              child: Text('Odaberi datum'),
            ),
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
                            _DailyWidget(width: width)
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

class _DailyWidget extends StatelessWidget {
  final double width;

  const _DailyWidget({required this.width});
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
        Expanded(child: Center(child: BlocBuilder<StatisticsBloc, StatisticsState>(
          builder: (context, state) {
            if (state.status == StatisticsStateStatus.submittingSuccess) {
              double consumption = 0;
              for (final element in state.model!) {
                consumption += element.consumption / 1000;
              }
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Ukupna potrosnja je $consumption kWh',
                  style: GoogleFonts.nunitoSans(color: ColorsPalette.whiteSmoke),
                ),
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
