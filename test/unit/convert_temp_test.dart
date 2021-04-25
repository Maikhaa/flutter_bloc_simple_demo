import 'package:flutter_bloc_simple_demo/services/temp_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('convertToF', () {
    test('Returns 32.0F if temperature is 0.0C', () {
      var tempConverter = TempConverter();
      var result = tempConverter.convertToF(0.0);
      expect(result, 32.0);
    });

    test('Returns 50.0F if temperature is 10.0C', () {
      var tempConverter = TempConverter();
      var result = tempConverter.convertToF(10.0);
      expect(result, 50.0);
    });
  });

  group('convertToC', () {
    test('Returns 0.0C if temperature is 32.0F', () {
      var tempConverter = TempConverter();
      var result = tempConverter.convertToC(32.0);
      expect(result, 0.0);
    });

    test('Returns 10.0C if temperature is 50.0C', () {
      var tempConverter = TempConverter();
      var result = tempConverter.convertToC(50.0);
      expect(result, 10.0);
    });
  });
}
