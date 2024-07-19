// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:energy_panel/_all.dart';

@immutable
abstract class PeriodSelectionEvent {}

class ChangeSelctedPeriod extends PeriodSelectionEvent {
  final SelectedPeriodButton selected;
  ChangeSelctedPeriod({
    required this.selected,
  });
}
