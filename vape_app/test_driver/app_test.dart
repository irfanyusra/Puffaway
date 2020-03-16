import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Puffaway App Test", () {
    final signInPage = find.byType("SignIn");
    final emailField = find.byValueKey("email-field");
    final passwordField = find.byValueKey("password-field");
    final signInButton = find.byValueKey("signin-btn");
    final error = find.text("Vaping makes you forget, change your habit");
    // final statsPage = find.byValueKey("dashboard");
    final statsPage = find.byType("Statistics");
    // final statsPage = find.text("Time Since Last Hit");
    final logNav = find.byValueKey("log-nav");
    final logTriggerPage = find.byValueKey("log-trigger-page");
    // final logTriggerPage = find.byType("LoggingTrigger");
    final thoughtField = find.byValueKey("thought-field");
    final saveTriggerBtn = find.byValueKey("save-trigger-btn");
    final diaryNav = find.byValueKey("diary-nav");
    // final triggerLogPage = find.byValueKey("trigger-log-page");
    final allTriggerLogsPage = find.byType("AllLogs");
    final thoughtText = "some thought";
    final triggerText = "";
    final triggerExists = find.text("Trigger: "+triggerText);
    final thoughtExists =
        find.text("Thought: " + thoughtText + "\n a moment ago");
    final statsNav = find.byValueKey("stats-nav");
    final reflectionNav =
        find.byValueKey("reflection-nav"); //reflections nav bar
    final logReflectionPage = find.byType("Reflections"); //add reflections page
    final stressorText = "some stressor";
    final progressText = "some progress";
    final stressorField = find.byValueKey("stressors-field");
    final progressField = find.byValueKey("progress-field");
    final saveReflectionBtn = find.byValueKey("save-reflection-btn");
    final toggleRefLogsBtn = find.byValueKey("toggle-ref-logs-btn");
    final toggleTrigLogsBtn = find.byValueKey("toggle-trig-logs-btn");
    final allReflectionLogsPage = find.byType("AllReflections");
    final stressorExists = find.text("Stressor: " + stressorText);
    final progressExists =
        find.text("Progress: " + progressText + "\n a moment ago");

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
      await driver.enterText("test113");
      await driver.tap(signInButton);
      await driver.waitFor(error);
      await driver.waitUntilNoTransientCallbacks();
      assert(error == null);
      assert(statsPage != null);
      // await new Future.delayed(const Duration(seconds: 3));
    });

    test("logs in with correct email and password", () async {
      // await driver.waitFor(signInPage);
      await driver.tap(emailField);
      await driver.enterText("test@testmail.com");
      await driver.tap(passwordField);
      await driver.enterText("test123");
      await driver.tap(signInButton);

      // await driver.waitFor(statsPage);
      print("wating for stas page");
      await driver.runUnsynchronized(() async {
        await driver.waitFor(statsPage);
        assert(statsPage == null);
      });

      // await new Future.delayed(const Duration(seconds: 3));
      // await new Future.delayed(const Duration(seconds: 10));
    });

    test("Adding Trigger", () async {
      await driver.runUnsynchronized(() async {
        //on the dashboard
        await driver.waitFor(statsPage);
        assert(statsPage == null);
        // go to logging trigger page
        await driver.tap(logNav);
      });
      await driver.runUnsynchronized(() async {
        await driver.waitFor(logTriggerPage);
        await driver.tap(thoughtField);
        await driver.enterText(thoughtText);
        // save the trigger
        await driver.tap(saveTriggerBtn);
        //back from the recommendations page
        await driver.tap(find.pageBack());
      });
      await driver.runUnsynchronized(() async {
        await driver.waitFor(logTriggerPage);
        //go to the statistics to see the new time last hit
        await driver.tap(statsNav);
      });
      await driver.runUnsynchronized(() async {
        await driver.waitFor(statsPage);
        await new Future.delayed(const Duration(seconds: 1));
        //go to the diary to see the new added trigger
        await driver.tap(diaryNav);
      });
      await driver.runUnsynchronized(() async {
        await driver.waitFor(allTriggerLogsPage);
      });
      //checks the content and the timestamp to confirm that the trigger was added
      assert(triggerExists == null);
      assert(thoughtExists == null);
      await driver.runUnsynchronized(() async {
        await driver.waitFor(triggerExists);
      });
      await driver.runUnsynchronized(() async {
        await driver.waitFor(thoughtExists);
      });
      await driver.tap(statsNav);

      await driver.runUnsynchronized(() async {
        await driver.waitFor(statsPage);
      });
      await new Future.delayed(const Duration(seconds: 1));
    });

    test("Adding Reflection", () async {
      //on the dashboard
      await driver.runUnsynchronized(() async {
        await driver.waitFor(statsPage);
        //go to logging trigger page
        await driver.tap(reflectionNav);
      });
      await driver.runUnsynchronized(() async {
        await driver.waitFor(logReflectionPage);
        await driver.tap(stressorField);
        await driver.enterText(stressorText);
        await driver.tap(progressField);
        await driver.enterText(progressText);
        //save the reflection
        await driver.tap(saveReflectionBtn);

        //go to the diary to see the new added reflection
        await driver.tap(diaryNav);
      });
      await driver.runUnsynchronized(() async {
        await driver.waitFor(allTriggerLogsPage);
        await driver.tap(toggleRefLogsBtn);
      });

      await driver.runUnsynchronized(() async {
        await driver.waitFor(allReflectionLogsPage);
      });

      //checks the content and the timestamp to confirm that the reflection was added
      assert(stressorExists == null);
      assert(progressExists == null);
      await driver.runUnsynchronized(() async {
        await driver.waitFor(stressorExists);
      });
      await driver.runUnsynchronized(() async {
        await driver.waitFor(progressExists);
      });
      //on the dashboard
      await driver.tap(statsNav);

      await driver.runUnsynchronized(() async {
        await driver.waitFor(statsPage);
      });
      await new Future.delayed(const Duration(seconds: 1));
    });
  });
}
