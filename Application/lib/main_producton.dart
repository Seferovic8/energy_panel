import 'package:energy_panel/_all.dart';
import 'main.dart' as app;

Future main() async {
  environment = EnvironmentType.production;
  await app.main();
}