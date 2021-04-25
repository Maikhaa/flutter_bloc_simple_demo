import 'package:flutter_bloc_simple_demo/services/temp_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('convertToF', () {
    test('Returns 32.0F if temperature is 0.0C', () {
      var tempConverter = TempConverter();
      var result = tempConverter.toF(0.0);
      expect(result, 32.0);
    });

    test('Returns 50.0F if temperature is 10.0C', () {
      var tempConverter = TempConverter();
      var result = tempConverter.toF(10.0);
      expect(result, 50.0);
    });
  });
}
