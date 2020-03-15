import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';


void main() {
  group("Puffaway App Test", () {
    final emailField = find.byValueKey("email-field");
    final passwordField = find.byValueKey("password-field");
    final signInButton = find.byValueKey("signin-btn");
    final statistics = find.byType("Statistics");
    final dashboard = find.text("Dashboard");

    final error = find.text("Vaping makes you forget, change your habit");
    // final statistics = find.byType("Statistics");
  //   final snackbar = find.byType("SnackBar");

    FlutterDriver driver;
    setUpAll(()async{
      driver = await FlutterDriver.connect();
    });

    tearDownAll(()async{
      if(driver != null) {
        driver.close();
      }
    });
    test("login fails with incorrect email and password, provides text feedback",() async{
      await driver.tap(emailField);
      await driver.enterText("test@testmail.com");
      await driver.tap(passwordField);
      await driver.enterText("test1113");
      await driver.tap(signInButton);
      await driver.waitFor(error);
      assert(error != null);
      await driver.waitUntilNoTransientCallbacks();
      assert(dashboard == null);
      // await new Future.delayed(const Duration(seconds: 10));   
      
       });

    test("logs in with correct email and password",() async {
      await driver.tap(emailField);
      await driver.enterText("test@testmail.com");
      await driver.tap(passwordField);
      await driver.enterText("test123");
      await driver.tap(signInButton);
      await driver.waitFor(statistics);
      assert(statistics != null);
      await new Future.delayed(const Duration(seconds: 10));   
      
    });


  });
}