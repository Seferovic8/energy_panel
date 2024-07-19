import 'package:energy_panel/_all.dart';

extension BuildContextExtension on BuildContext {
  ServiceProvider get serviceProvider => RepositoryProvider.of<ServiceProvider>(this);
  AppSettings get appSettings => serviceProvider.appSettings;
  DateTime get getexpirationDate => DateTime.now().add(const Duration(days: 1));
  NavigatorState get navigator => Navigator.of(this);
  void pop<T>([T? result]) => navigator.pop();
  Future pushPage(Widget page) {
    unfocus();

    return navigator.push(MaterialPageRoute(builder: (_) => page));
  }

  void unfocus() => FocusScope.of(this).unfocus();

  // bool get isLoggedin {
  //   if (FirebaseAuth.instance.currentUser == null) {
  //     return false;
  //   }
  //   if (read<AuthBloc>().state.status != AuthStateStatus.authenticated) {
  //     return false;
  //   }
  //   return true;
  // }

  // User get getCurrenUser => FirebaseAuth.instance.currentUser!;
}
