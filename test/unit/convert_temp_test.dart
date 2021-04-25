import 'package:flutter_bloc_simple_demo/utils/temp_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tempUtil = TempUtil();

  group('getTempInF', () {
    test('Returns 32.00 °F if temperature is 0.0 °C', () {
      var result = tempUtil.getTempInF(0.0);
      expect(result, '32.00 °F');
    });

    test('Returns 50.0 °F if temperature is 10.0 °C', () {
      var result = tempUtil.getTempInF(10.0);
      expect(result, '50.00 °F');
    });
  });

  group('getTempInC', () {
    test('Returns 20.00 °C if temperature is 20.0003 °C', () {
      var result = tempUtil.getTempInC(20.0003);
      expect(result, '20.00 °C');
    });
  });
}
