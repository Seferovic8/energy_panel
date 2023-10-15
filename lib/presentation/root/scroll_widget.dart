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