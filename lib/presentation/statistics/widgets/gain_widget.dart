import 'package:energy_panel/_all.dart';

class GainWidget extends StatelessWidget {
  final double width;

  const GainWidget({required this.width});
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
            'Predato/Primljeno iz mreže',
            style: GoogleFonts.nunitoSans(
              fontSize: 17,
              color: ColorsPalette.whiteSmoke,
            ),
          ),
        ),
        Expanded(child: Center(child: BlocBuilder<StatisticsBloc, StatisticsState>(
          builder: (context, state) {
            if (state.status == StatisticsStateStatus.submittingSuccess) {
              final total = state.model!.smaPlus - state.model!.smaMinus;
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Preuzeto iz mreže:', style: GoogleFonts.nunitoSans(color: ColorsPalette.whiteSmoke, fontSize: 18)),
                            Text('Predato u mrežu:', style: GoogleFonts.nunitoSans(color: ColorsPalette.whiteSmoke, fontSize: 18)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' ${(state.model!.smaPlus / 1000).toStringAsFixed(3)} kWh',
                              style: GoogleFonts.nunitoSans(color: ColorsPalette.red, fontSize: 20),
                            ),
                            Text(
                              ' ${(state.model!.smaMinus / 1000).toStringAsFixed(3)} kWh',
                              style: GoogleFonts.nunitoSans(color: ColorsPalette.green, fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(color: ColorsPalette.whiteSmoke),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Ukupno:',
                          style: GoogleFonts.nunitoSans(color: ColorsPalette.whiteSmoke, fontSize: 18),
                        ),
                        TextSpan(
                          text: ' ${(total.abs() / 1000).toStringAsFixed(3)} kWh',
                          style: GoogleFonts.nunitoSans(color: total > 0 ? ColorsPalette.red : ColorsPalette.green, fontSize: 20),
                        ),
                      ]),
                    ),
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
