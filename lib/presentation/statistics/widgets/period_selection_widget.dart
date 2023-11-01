import 'package:energy_panel/_all.dart';

class PeriodSelectionWidget extends StatelessWidget {
  PeriodSelectionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 490,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: ColorsPalette.whiteBackgroud,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              _PeriodButton(buttonType: SelectedPeriodButton.today),
              _PeriodButton(buttonType: SelectedPeriodButton.month),
              _PeriodButton(buttonType: SelectedPeriodButton.year),
              _PeriodButton(buttonType: SelectedPeriodButton.custom),
            ],
          ),
        ),
      ],
    );
  }
}

class _PeriodButton extends StatelessWidget {
  _PeriodButton({required this.buttonType});
  final SelectedPeriodButton buttonType;
  late String name;
  late Function()? function;
  @override
  Widget build(BuildContext context) {
    if (buttonType == SelectedPeriodButton.today) {
      name = 'DANAS';
      function = () {
        context.read<PeriodSelectionBloc>().add(ChangeSelctedPeriod(selected: buttonType));
        final DateTime startDate = DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
        context.read<StatisticsBloc>().add(SubmitStatisticsEvent(
                statisticsModel: GetStatisticsModel(
              startDate: startDate,
              endDate: startDate.add(const Duration(days: 1)),
            )));
      };
    } else if (buttonType == SelectedPeriodButton.month) {
      name = 'MJESEC';
      function = () {
        context.read<PeriodSelectionBloc>().add(ChangeSelctedPeriod(selected: buttonType));
        final DateTime today = DateTime.now();
        final DateTime startDate = DateTime(today.year, today.month, 1);
        context.read<StatisticsBloc>().add(SubmitStatisticsEvent(
                statisticsModel: GetStatisticsModel(
              startDate: startDate,
              endDate: today,
            )));
      };
    } else if (buttonType == SelectedPeriodButton.year) {
      name = 'GODINA';
      function = () {
        context.read<PeriodSelectionBloc>().add(ChangeSelctedPeriod(selected: buttonType));
        final DateTime today = DateTime.now();
        final DateTime startDate = DateTime(today.year, 1, 1);
        context.read<StatisticsBloc>().add(SubmitStatisticsEvent(
                statisticsModel: GetStatisticsModel(
              startDate: startDate,
              endDate: today,
            )));
      };
    } else if (buttonType == SelectedPeriodButton.custom) {
      name = 'ODABERI PERIOD';
      function = () async {
        context.read<PeriodSelectionBloc>().add(ChangeSelctedPeriod(selected: buttonType));

        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: SizedBox(
                  width: 500,
                  height: 500,
                  child: SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.range,
                    showActionButtons: true,
                    monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                    maxDate: DateTime.now(),
                    minDate: DateTime.now().subtract(const Duration(days: 370)),
                    view: DateRangePickerView.month,
                    onSubmit: (dateRange) {
                      if ((dateRange as PickerDateRange).startDate == null) {
                        Navigator.pop(context);
                        return;
                      }
                      final DateTime startDate = dateRange.startDate!;
                      DateTime? endDate = dateRange.endDate;
                      endDate ??= startDate;
                      context.read<StatisticsBloc>().add(SubmitStatisticsEvent(
                              statisticsModel: GetStatisticsModel(
                            startDate: startDate,
                            endDate: endDate.add(const Duration(days: 1)),
                          )));
                      Navigator.pop(context);
                    },
                    onCancel: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            });
      };
    }
    return Container(
      padding: buttonType == SelectedPeriodButton.today ? null : const EdgeInsets.only(left: 35),
      height: 35,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          child: BlocBuilder<PeriodSelectionBloc, PeriodSelectionState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: state.selected == buttonType
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: ColorsPalette.buttonColor,
                      )
                    : null,
                child: Text(
                  name,
                  style: GoogleFonts.nunitoSans(color: ColorsPalette.whiteSmoke, fontSize: 13),
                ),
              );
            },
          ),
          onTap: function,
        ),
      ),
    );
  }
}
