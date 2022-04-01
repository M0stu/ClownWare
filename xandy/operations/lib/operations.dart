library operations;
import 'dart:math';
/// A Calculator.
class Calculator {
  int addOne(int value) => value + 1;

  int subOne(int value) => value - 1;

  int addTwoNumbers(int val1, int val2) => val1 + val2;

  int subTwoNumbers(int val1, int val2) => val1 - val2;

  int mulTwoNumbers(int val1, int val2) => val1 * val2;

  double divTwoNumbers(int val1, int val2) => val1 / val2;

  int modulus(int val1, int val2) => val1 % val2;

  double sinVal(double value) => sin(double.parse(value.toString()));
  double cosVal(double value) => cos(double.parse(value.toString()));
  double tanVal(double value) => tan(double.parse(value.toString()));
  
  num powerVal(num val, num exponent) => pow(val, exponent);
}
