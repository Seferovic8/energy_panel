// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:energy_panel/_all.dart';

enum RouteNamePage { dashboard, statistics }

RouteNamePage getRouteName(String? route) {
  if (route == '/' || route == HomePage.routeName) {
    return RouteNamePage.dashboard;
  } else if (route == StatisticsPage.routeName) {
    return RouteNamePage.statistics;
  }
  return RouteNamePage.statistics;
}

class NavBar extends StatelessWidget {
  NavBar({super.key, required this.height, required this.width});
  final double height;
  final double width;
  // bool isAnimationFinished = false;

  @override
  Widget build(BuildContext context) {
    final RouteNamePage route = getRouteName(ModalRoute.of(context)!.settings.name);
    return Container(
      decoration: const BoxDecoration(color: ColorsPalette.navBackground),
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(minWidth: 1200 * 0.16666667),
      width: width * 0.16666667,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'ENERGY PANEL',
            style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w100, fontSize: 24, color: ColorsPalette.whiteSmoke),
          ),
          // IconButton(
          //     onPressed: () {
          //       context.navigator.pushReplacementNamed(HomePage.routeName);
          //     },
          //     icon: const Icon(Icons.dashboard_outlined),
          //     color: ColorsPalette.whiteSmoke,
          //     focusColor: Colors.blue,
          //     hoverColor: Colors.pinkAccent),
          Padding(
            padding: EdgeInsets.only(left: width > 1400 ? 20 : 0, top: 65),
            child: Column(
              children: [
                _TextButton(
                  width: width,
                  icon: Icons.dashboard_outlined,
                  text: 'Dashboard',
                  routeName: HomePage.routeName,
                  changeColor: route != RouteNamePage.dashboard,
                ),
                const SizedBox(height: 20),
                _TextButton(
                  width: width,
                  icon: Icons.add_chart_outlined,
                  text: 'Statistika',
                  routeName: StatisticsPage.routeName,
                  changeColor: route != RouteNamePage.statistics,
                )
              ],
            ),
          ),

          // IconButton(
          //     onPressed: () {
          //       context.navigator.pushReplacementNamed(SettingsPage.routeName);
          //     },
          //     icon: const Icon(Icons.settings)),
        ],
      ),
    );
  }
}

class _TextButton extends StatelessWidget {
  final double width;
  final String text;
  final String routeName;
  final IconData icon;
  final bool changeColor;
  const _TextButton({
    Key? key,
    required this.width,
    required this.text,
    required this.routeName,
    required this.icon,
    required this.changeColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          context.navigator.pushReplacementNamed(routeName);
        },
        child: Row(
          children: [
            Icon(
              icon,
              color: changeColor ? ColorsPalette.gray : ColorsPalette.whiteSmoke,
              size: 30,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, right: 0, bottom: 10, left: width > 1200 ? 40 : 10),
              child: Text(
                text,
                style: GoogleFonts.nunitoSans(color: changeColor ? ColorsPalette.gray : ColorsPalette.whiteSmoke, fontSize: 15, fontWeight: FontWeight.w300),
              ),
            )
          ],
        ));
  }
}


// class NavBar extends StatelessWidget {
//   NavBar({super.key, required this.height, required this.callback, required this.isCollapsed});
//   final double height;
//   final Function callback;
//   final bool isCollapsed;
//   bool isAnimationFinished = false;
//   Future<void> addDelay() async {
//     await Future.delayed(const Duration(milliseconds: 300), () {
//       isAnimationFinished = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     addDelay();
//     return MouseRegion(
//       onEnter: (eusovent) {
//         callback.call(true);
//       },
//       onExit: (event) {
//         callback.call(false);
//       },
//       child: AnimatedContainer(
//         decoration: BoxDecoration(color: ColorsPalette.white, borderRadius: BorderRadius.circular(15)),
//         duration: const Duration(milliseconds: 300),
//         padding: const EdgeInsets.only(right: 10, left: 10, top: 13, bottom: 10),
//         height: height,
//         width: isCollapsed ? 200 : 80,
//         child: !isCollapsed
//             ? Column(
//                 children: [
//                   TextButton(onPressed: () {}, child: const Icon(Icons.home, color: Colors.black)),
//                 ],
//               )
//             : FutureBuilder(
//                 future: addDelay(),
//                 builder: (c, s) {
//                   if (isAnimationFinished == true) {
//                     isAnimationFinished = false;
//                     return Column(
//                       children: [
//                         TextButton(
//                           onPressed: () {},
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: const [
//                               Icon(
//                                 Icons.home,
//                                 color: Colors.black,
//                               ),
//                               Text(
//                                 'Home',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     );
//                   } else {
//                     return Column(
//                       children: [
//                         TextButton(onPressed: () {}, child: const Icon(Icons.home, color: Colors.black)),
//                       ],
//                     );
//                   }
//                 }),
//       ),
//     );
//   }
// }
