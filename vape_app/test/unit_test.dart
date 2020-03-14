import 'package:flutter_test/flutter_test.dart';
import 'package:vape_app/helper_functions/validation.dart';

void main() {
  test('Empty email returns error string', () {
    var result = EmailFieldValidator.validate('');
    expect(result, 'Enter an email');
  });

  test('non-empty email returns null', () {
    var result = EmailFieldValidator.validate('email');
    expect(result, null);
  });

  test('empty password returns error string', () {
    var result = PasswordFieldValidator.validate('');
    expect(result, 'Enter a password longer than 6 characters');
  });

  test('non-empty password returns null', () {
    var result = PasswordFieldValidator.validate('password');
    expect(result, null);
  });
}
