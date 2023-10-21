import 'package:energy_panel/_all.dart';

class ConsumptionWidget extends StatelessWidget {
  final double width;

  const ConsumptionWidget({required this.width});
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
            'Potrošnja',
            style: GoogleFonts.nunitoSans(
              fontSize: 17,
              color: ColorsPalette.whiteSmoke,
            ),
          ),
        ),
        Expanded(child: Center(child: BlocBuilder<StatisticsBloc, StatisticsState>(
          builder: (context, state) {
            if (state.status == StatisticsStateStatus.submittingSuccess) {
              final difference = state.model!.endDate.difference(state.model!.startDate);
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //const SizedBox(height: 15),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Ukupna potrosnja u datom periodu:',
                          style: GoogleFonts.nunitoSans(color: ColorsPalette.whiteSmoke, fontSize: 18),
                        ),
                        TextSpan(
                          text: ' ${state.model!.consumption.toStringAsFixed(2)} kWh',
                          style: GoogleFonts.nunitoSans(color: ColorsPalette.red, fontSize: 20),
                        ),
                      ]),
                    ),
                    //const SizedBox(height: 15),
                    difference.inDays > 1
                        ? RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Prosječna potrošnja po danu:',
                                style: GoogleFonts.nunitoSans(color: ColorsPalette.whiteSmoke, fontSize: 18),
                              ),
                              TextSpan(
                                text: ' ${(state.model!.consumption / difference.inDays).toStringAsFixed(2)} kWh',
                                style: GoogleFonts.nunitoSans(color: ColorsPalette.red, fontSize: 20),
                              ),
                            ]),
                          )
                        : RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Prosječna potrošnja po satu:',
                                style: GoogleFonts.nunitoSans(color: ColorsPalette.whiteSmoke, fontSize: 18),
                              ),
                              TextSpan(
                                text: ' ${(state.model!.consumption / difference.inHours).toStringAsFixed(2)} kWh',
                                style: GoogleFonts.nunitoSans(color: ColorsPalette.red, fontSize: 20),
                              ),
                            ]),
                          ),
                    //const SizedBox(height: 15),
                    difference.inDays >= 30
                        ? RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Prosječna potrošnja po mjesecu:',
                                style: GoogleFonts.nunitoSans(color: ColorsPalette.whiteSmoke, fontSize: 18),
                              ),
                              TextSpan(
                                text: ' ${(state.model!.consumption / (difference.inDays / 30)).toStringAsFixed(2)} kWh',
                                style: GoogleFonts.nunitoSans(color: ColorsPalette.red, fontSize: 20),
                              ),
                            ]),
                          )
                        : Container()
                  ],
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
