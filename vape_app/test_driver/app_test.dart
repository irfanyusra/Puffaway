import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Puffaway App Test", () {
    final signInPage = find.byType("SignIn");
    final emailField = find.byValueKey("email-field");
    final passwordField = find.byValueKey("password-field");
    final signInButton = find.byValueKey("signin-btn");
    final error = find.text("Vaping makes you forget, change your habit");
    // final dashboardPage = find.byValueKey("dashboard");
    final dashboardPage = find.byType("Statistics");
    final logNav = find.byValueKey("log-nav");
    // final logPage = find.byValueKey("log-page");
    final logPage = find.byType("LoggingTrigger");
    final thoughtField = find.byValueKey("thought-field");
    final saveTriggerBtn = find.byValueKey("save-trigger-btn");
    final diaryNav = find.byValueKey("diary-nav");
    // final triggerLogPage = find.byValueKey("trigger-log-page");
    final triggerLogPage = find.byType("AllLogs");
    final triggerExists = find.text("Trigger: Select one");
    final thoughtExists = find.text("Thought: some thought \n a moment ago");

    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test(
        "login fails with incorrect email and password, provides text feedback",
        () async {
      await driver.waitFor(signInPage);
      await driver.tap(emailField);
      await driver.enterText("test@testmail.com");
      await driver.tap(passwordField);
      await driver.enterText("test1113");
      await driver.tap(signInButton);
      await driver.waitFor(error);
      assert(error != null);
      await driver.waitUntilNoTransientCallbacks();
      assert(dashboardPage == null);
      // await new Future.delayed(const Duration(seconds: 10));
    });

    test("logs in with correct email and password", () async {
      await driver.waitFor(signInPage);
      await driver.tap(emailField);
      await driver.enterText("test@testmail.com");
      await driver.tap(passwordField);
      await driver.enterText("test123");
      await driver.tap(signInButton);
      await driver.waitFor(dashboardPage);
      assert(dashboardPage != null);
      // await new Future.delayed(const Duration(seconds: 10));
    });

    test("Adding Trigger", () async {
      //on the dashboard
      await driver.waitFor(dashboardPage);
      //go to logging trigger page
      await driver.tap(logNav);
      await driver.waitFor(logPage);
      await driver.tap(thoughtField);
      await driver.enterText("some thought");
      await driver.tap(thoughtField);
      //save the trigger
      await driver.tap(saveTriggerBtn);
      //back from the recommendations page
      await driver.tap(find.pageBack());
      await driver.waitFor(logPage);
      //go to the diary to see the new added trigger
      await driver.tap(diaryNav);
      await driver.waitFor(triggerLogPage);
      //checks the content and the timestamp to confirm that the trigger was added
      assert(triggerExists != null);
      assert(thoughtExists != null);

      // await new Future.delayed(const Duration(seconds: 10));
    });
  });
}
