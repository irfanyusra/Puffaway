import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:math';
void main() {
  group("Puffaway App Test", () {
    final signInPage = find.byType("SignIn");
    final emailField = find.byValueKey("email-field");
    final passwordField = find.byValueKey("password-field");
    final signInButton = find.byValueKey("signin-btn");
    final error = find.text("Vaping makes you forget, please try again and change your habit");
    // final statsPage = find.byValueKey("dashboard");
    final statsPage = find.byType("Statistics");
    // final statsPage = find.text("Time Since Last Hit");
    // final logTriggerPage = find.byType("LoggingTrigger");
    final thoughtField = find.byValueKey("thought-field");
    final saveTriggerBtn = find.byValueKey("save-trigger-btn");
    final diaryNav = find.byValueKey("diary-nav");
    // final triggerLogPage = find.byValueKey("trigger-log-page");
    final allTriggerLogsPage = find.byType("AllLogs");
    final thoughtText = "some thought";
    final triggerText = "";
    final triggerExists = find.text("Trigger: " + triggerText);
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
    final progressExists = find.text("Progress: " + progressText + "\n a moment ago");

    final settingsNavBtn = find.byValueKey("settings-nav-btn");
    final addTriggerField = find.byValueKey("add-trigger-field");
    final settingsPage = find.byType("Settings");
    //final triggerTest = "some trigger";
    final addTriggerBtn2 = find.byValueKey("save-trigger-btn");
    final logNav = find.byValueKey("log-nav");
    final logTriggerPage = find.byValueKey("log-trigger-page");
    final triggerDropdown = find.byValueKey("trigger-dropdown");
    final triggerDropdownValue = find.byValueKey("dropdown_some trigger");

    final registerBtn = find.byValueKey("register-btn");
    final setupPage = find.byType("Setup");
    final nameField = find.byValueKey("name-field");
    final nameTest = "some name";
    final dobField = find.byValueKey("dob-field");
    final goalField = find.byValueKey("goal-field");
    final goalTest = "5";
    final triggerField = find.byValueKey("trigger-field");
    final triggerTest = "some trigger";
    final addTriggerBtn = find.byValueKey("save-trigger-btn");
    final nextBtn = find.byValueKey("next-btn");
    final logoutBtn = find.byValueKey("logout-btn");

    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) driver.close();
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
      await driver.enterText("123@123.com");
      await driver.tap(passwordField);
      await driver.enterText("123456");
      await driver.tap(signInButton);

      // await driver.waitFor(statsPage);
      print("wating for stats page");
      await driver.runUnsynchronized(() async {
        await driver.waitFor(statsPage);
        assert(statsPage == null);
        await driver.tap(settingsNavBtn);
      });

      await driver.runUnsynchronized(() async {
        await driver.waitFor(settingsPage);
        assert(settingsPage == null);
        await driver.tap(logoutBtn);
      });

    });


    test("Register page fails with duplicate email, succeeds with unique email. Setup page saves values to settings and add trigger saves to dropdown", () async {

      //random number to create unique email
      Random random = new Random();
      int randomNumber = random.nextInt(100);

      await driver.waitFor(signInPage);
      await driver.runUnsynchronized(() async {
        //register fails with duplicate email
        await driver.tap(registerBtn);
        await driver.tap(emailField);
        await driver.enterText("123@123.com");
        await driver.tap(passwordField);
        await driver.enterText("123456");
        await driver.tap(registerBtn);
        await new Future.delayed(const Duration(seconds: 2));
        await driver.waitFor(find.text("Email already in use, please use a different email"));
        print("Register page fails with duplicate email test succeeded");

        //register succeeds with unique email
        await driver.tap(emailField);
        await driver.enterText(randomNumber.toString() + "@123.com");
        await driver.tap(passwordField);
        await driver.enterText("123456");
        await driver.tap(registerBtn);
        print("Register succeeded");
      });

      print("wating for setup page");
      await driver.runUnsynchronized(() async {
        await driver.waitFor(setupPage);
        await driver.tap(nameField);
        await driver.enterText(nameTest);
        await driver.tap(dobField);
        await new Future.delayed(const Duration(seconds: 2));
        await driver.tap(find.text('15'));
        await driver.tap(find.text('OK'));
        await driver.tap(goalField);
        await driver.enterText(goalTest);
        await driver.tap(triggerField);
        await driver.enterText(triggerTest);
        await driver.tap(addTriggerBtn);
        await new Future.delayed(const Duration(seconds: 2));
        await driver.tap(nextBtn);
        print("enter settings succeeded");
      });

      print("waiting for dashboard");
      await driver.runUnsynchronized(() async {
        //on the dashboard
        await driver.waitFor(statsPage);
        assert(statsPage == null);
        // go to settings page
        await driver.tap(settingsNavBtn);
        await Future.delayed(Duration(seconds: 2));
      });

      print("waiting for settings page");
      //settings page
      await driver.runUnsynchronized(() async {
        await driver.waitFor(settingsPage);
        await driver.tap(find.text(nameTest));
        print("correct name found");
        await new Future.delayed(const Duration(seconds: 2));
        expect(find.text('2020-03-15'), anything);
        print("correct date found");
        await new Future.delayed(const Duration(seconds: 2));
        await driver.tap(find.pageBack());
      });

      //log trigger page
      await driver.runUnsynchronized(() async {
        await driver.waitFor(statsPage);
        await driver.tap(logNav);
        await driver.waitFor(logTriggerPage);
        await driver.tap(triggerDropdown);
        await driver.tap(triggerDropdownValue);
        print("setup values saved successfully");
      });

    });

    test("Adding Log", () async {
      /*await driver.runUnsynchronized(() async {
        //on the dashboard
        await driver.waitFor(statsPage);
        assert(statsPage == null);
        // go to logging trigger page
        await driver.tap(logNav);
      });*/

      await driver.runUnsynchronized(() async {
        //await driver.waitFor(logTriggerPage);
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
      /*await driver.tap(statsNav);

      await driver.runUnsynchronized(() async {
        await driver.waitFor(statsPage);
      });
      await new Future.delayed(const Duration(seconds: 1));*/
    });

    test("Adding Reflection", () async {
      //on the dashboard
      /*await driver.runUnsynchronized(() async {
        await driver.waitFor(statsPage);
        //go to logging trigger page
        await driver.tap(reflectionNav);
      });*/
      await driver.tap(reflectionNav);

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

     /* await driver.runUnsynchronized(() async {
        await driver.waitFor(statsPage);
      });
      await new Future.delayed(const Duration(seconds: 1));*/
    });

    test("Adding Trigger", () async {
     /* await driver.tap(emailField);
      await driver.enterText("123@123.com");
      await driver.tap(passwordField);
      await driver.enterText("123456");
      await driver.tap(signInButton);*/



      //dashboard
      await driver.runUnsynchronized(() async {
        print("wating for stats page");
        await driver.waitFor(statsPage);
        assert(statsPage == null);
        // go to settings page
        await driver.tap(settingsNavBtn);
        await Future.delayed(Duration(seconds: 2));
      });

      //settings page
      await driver.runUnsynchronized(() async {
        await driver.waitFor(settingsPage);
        await driver.tap(addTriggerField);
        await driver.enterText(triggerTest);
        // save the trigger
        await driver.tap(addTriggerBtn2);
        await Future.delayed(Duration(seconds: 2));
        //back from the settings page
        await driver.tap(find.pageBack());
        await Future.delayed(Duration(seconds: 2));
      });

      //log trigger page
      await driver.runUnsynchronized(() async {
        await driver.tap(logNav);
        await driver.waitFor(logTriggerPage);
        await driver.tap(triggerDropdown);
        await Future.delayed(Duration(seconds: 2));
        await driver.tap(triggerDropdownValue);
      });
    });
  });


}
