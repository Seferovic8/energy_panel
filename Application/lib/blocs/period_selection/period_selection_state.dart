// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:energy_panel/_all.dart';

enum SelectedPeriodButton {
  today,
  month,
  year,
  custom,
}

class PeriodSelectionState {
  final SelectedPeriodButton selected;
  PeriodSelectionState({
    required this.selected,
  });

  PeriodSelectionState copyWith({
    SelectedPeriodButton? selected,
  }) {
    return PeriodSelectionState(
      selected: selected ?? this.selected,
    );
  }
}
