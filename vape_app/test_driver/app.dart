import 'package:flutter_driver/driver_extension.dart';
import 'package:vape_app/main.dart' as app;

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}

//integration hot reload 
//https://medium.com/flutter-community/hot-reload-for-flutter-integration-tests-e0478b63bd54
//run normally command:  drive --target=test_driver/app.dart