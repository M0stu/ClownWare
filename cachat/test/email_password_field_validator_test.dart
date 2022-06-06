import 'package:cachat/widgets/custom_Einput_fields.dart';
import 'package:cachat/widgets/custom_passInput_fields.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('empty email returns error string', () {
    final result = EmailFieldValidator.validate('');
    expect(result, 'Enter a valid Email.');
  });

  test('correct email returns null', () {
    final result = EmailFieldValidator.validate('email@email.cm');
    expect(result, null);
  });

  test('empty password returns error string', () {
    final result = PasswordFieldValidator.validate('');
    expect(result, 'Enter a valid Password.');
  });

  test('correct password returns null', () {
    final result = PasswordFieldValidator.validate('password');
    expect(result, null);
  });
}
