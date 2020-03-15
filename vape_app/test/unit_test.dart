import 'package:flutter_test/flutter_test.dart';
import 'package:vape_app/helper_functions/validation.dart';

void main() {
  group('Email', () {
    //boundry test
    test('Empty email returns error string', () {
      var result = EmailFieldValidator.validate('');
      expect(result, 'Enter an email');
    });
    // bad test
    test('bad email format returns error string ', () {
      var result = EmailFieldValidator.validate('test');
      expect(result, 'Enter a Valid Email');
    });
     test('bad email format returns error string ', () {
      var result = EmailFieldValidator.validate('@gmail.com');
      expect(result, 'Enter a Valid Email');
    });
    //good test
    test('correct email format', () {
      var result = EmailFieldValidator.validate('test@test.com');
      expect(result, null);
    });

       test('correct email format - subdomain', () {
      var result = EmailFieldValidator.validate('test@gmail.co.uk');
      expect(result, null);
    });

  });
  group('Password', () {
    //bad or boundy test
    test('password less than 6 characters returns error string', () {
      var result = PasswordFieldValidator.validate('');
      expect(result, 'Enter a password longer than 6 characters');
    });
    //good test
    test('password with more than or equal to 6 charaters returns null', () {
      var result = PasswordFieldValidator.validate('password');
      expect(result, null);
    });
  });
}
