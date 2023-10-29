import 'package:energy_panel/_all.dart';

class EnergyWidget extends StatelessWidget {
  final double width;

  const EnergyWidget({required this.width});
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
            'Proizvodnja',
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
              final differenceForStatistics = DateTime.now().difference(state.model!.startDate);
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //const SizedBox(height: 15),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Ukupna proizvodnja u datom periodu:',
                          style: GoogleFonts.nunitoSans(color: ColorsPalette.whiteSmoke, fontSize: 18),
                        ),
                        TextSpan(
                          text: ' ${(state.model!.energy / 1000).toStringAsFixed(3)} kWh',
                          style: GoogleFonts.nunitoSans(color: ColorsPalette.green, fontSize: 20),
                        ),
                      ]),
                    ),
                    //const SizedBox(height: 15),
                    difference.inDays > 1
                        ? RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Prosječna proizvodnja po danu:',
                                style: GoogleFonts.nunitoSans(color: ColorsPalette.whiteSmoke, fontSize: 18),
                              ),
                              TextSpan(
                                text: ' ${((state.model!.energy / difference.inDays) / 1000).toStringAsFixed(3)} kWh',
                                style: GoogleFonts.nunitoSans(color: ColorsPalette.green, fontSize: 20),
                              ),
                            ]),
                          )
                        : RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Prosječna proizvodnja po satu:',
                                style: GoogleFonts.nunitoSans(color: ColorsPalette.whiteSmoke, fontSize: 18),
                              ),
                              TextSpan(
                                text: ' ${((state.model!.energy / differenceForStatistics.inHours) / 1000).toStringAsFixed(3)} kWh',
                                style: GoogleFonts.nunitoSans(color: ColorsPalette.green, fontSize: 20),
                              ),
                            ]),
                          ),
                    //const SizedBox(height: 15),
                    difference.inDays >= 30
                        ? RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Prosječna proizvodnja po mjesecu:',
                                style: GoogleFonts.nunitoSans(color: ColorsPalette.whiteSmoke, fontSize: 18),
                              ),
                              TextSpan(
                                text: ' ${((state.model!.energy / (difference.inDays / 30)) / 1000).toStringAsFixed(3)} kWh',
                                style: GoogleFonts.nunitoSans(color: ColorsPalette.green, fontSize: 20),
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
