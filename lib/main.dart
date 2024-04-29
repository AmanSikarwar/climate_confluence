import 'package:climate_confluence/app/view/app.dart';
import 'package:climate_confluence/bootstrap.dart';
import 'package:flutter/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  bootstrap(
    () => const App(),
  );
}
