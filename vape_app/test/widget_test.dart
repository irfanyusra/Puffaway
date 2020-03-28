// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vape_app/Reflections/reflections_page.dart';
import 'package:vape_app/authenticate/register.dart';
import 'package:vape_app/authenticate/sign_in.dart';
import 'package:vape_app/settings/settings.dart';

void main() {
  Widget makeTestable({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  var emailField = find.byKey(Key("email-field"));
  var passwordField = find.byKey(Key("password-field"));
  var signInButton = find.byKey(Key("signin-btn"));
  var registerButton = find.byKey(Key("register-btn"));

  group("sign in page test", () {
    testWidgets("validates empty email and password",
        (WidgetTester tester) async {
      await tester.pumpWidget(makeTestable(child: SignIn()));
      await tester.tap(signInButton);
      await tester.pump();
      expect(find.text("Enter an email"), findsOneWidget);
      expect(find.text("Enter a password longer than 6 characters"),
          findsOneWidget);
    });

    testWidgets(
        "validates wrong email format and password that is less than 6 characters",
        (WidgetTester tester) async {
      await tester.pumpWidget(makeTestable(child: SignIn()));
      await tester.enterText(emailField, "email");
      await tester.tap(passwordField);
      await tester.enterText(passwordField, "pass");
      await tester.tap(signInButton);
      await tester.pump();

      expect(find.text("email"), findsOneWidget);
      expect(find.text("Enter a Valid Email"), findsOneWidget);
      expect(find.text("Enter a password longer than 6 characters"),
          findsOneWidget);
    });
  });

  group("register page test", () {
    testWidgets("validates empty email and password",
        (WidgetTester tester) async {
      await tester.pumpWidget(makeTestable(child: Register()));
      await tester.tap(registerButton);
      await tester.pump();
      expect(find.text("Enter an email"), findsOneWidget);
      expect(find.text("Enter a password longer than 6 characters"),
          findsOneWidget);
    });
    testWidgets(
        "validates wrong email format and password that is less than 6 characters",
        (WidgetTester tester) async {
      await tester.pumpWidget(makeTestable(child: Register()));
      await tester.enterText(emailField, "email");
      await tester.tap(passwordField);
      await tester.enterText(passwordField, "pass");
      await tester.tap(registerButton);
      await tester.pump();

      expect(find.text("email"), findsOneWidget);
      expect(find.text("Enter a Valid Email"), findsOneWidget);
      expect(find.text("Enter a password longer than 6 characters"),
          findsOneWidget);
    });
  });

  group("reflections page", () {
    testWidgets("validates that reflections is saved",
        (WidgetTester tester) async {
      await tester.pumpWidget(makeTestable(child: Reflections()));
      await tester.enterText(
          find.byKey(Key('stressors-field')), "random stressor");
      await tester.enterText(
          find.byKey(Key('progress-field')), "random progress");
      await tester.tap(find.byKey(Key('save-reflection-btn')));
      await tester.pump();
      expect(find.text("Add your text here"), findsWidgets);
      //TODO: save method called to the db
    });
  });

  group("log trigger page", () {
    testWidgets("validates that trigger log is saved",
        (WidgetTester tester) async {
      //TODO: save method called to the db
    });
  });
}
