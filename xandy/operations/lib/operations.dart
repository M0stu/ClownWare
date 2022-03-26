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
  double sinVal(num value) => sin(value);
  double cosVal(int value) => cos(value);
  double tanVal(int value) => tan(value);
  num powerVal(num val, num exponent) => pow(val, exponent);
}

