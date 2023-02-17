import 'package:mockito_delivery_app/src/utils/date_format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("DateFormat Test's", () {
    test('month < 10 Test', () {
      DateTime date = DateTime(2010, 1, 20);
      expect(date.format, "20 / 01 / 2010");
    });

    test('day < 10 Test', () {
      DateTime date = DateTime(2010, 11, 9);
      expect(date.format, "09 / 11 / 2010");
    });

    test('day < 10 && month < 10 Test', () {
      DateTime date = DateTime(2010, 2, 9);
      expect(date.format, "09 / 02 / 2010");
    });

    test('day > 10 && month > 10 Test', () {
      DateTime date = DateTime(2010, 11, 20);
      expect(date.format, "20 / 11 / 2010");
    });
  });
}
