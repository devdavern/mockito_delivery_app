import 'package:mockito_delivery_app/src/data/models/user.dart';
import 'package:mockito_delivery_app/src/helpers/get.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// TODO setUpAll se ejecuta previo a todos los test's
  setUpAll(() {
    print("PRINT PRE-ALL-TEST'S");
  });

  /// TODO tearDownAll se ejecuta despues de todos los
  ///  test's y permite funciones async
  tearDownAll(() {
    print("PRINT POST-ALL-TEST'S");
  });

  group("Get Test's", () {
    /// TODO setUp se ejecuta previo a cada test,
    ///  admite ejecucion async siempre que tearDown
    ///  posea async en su composicion
    setUp(() {
      print('PRINT PRE-EVERY-TEST');
    });

    /// TODO tearDown se ejecuta despues de cada test
    ///  y permite funciones async
    tearDown(() {
      print('PRINT POST-EVERY-TEST');
      print('XXXXXXXXXXXXXXXXXXXXX');
      print('Remove data::: ${Get.i.clear()}');
      print('Remove lazyData::: ${Get.i.lazyClear()}');
    });

    test('isAssertionError Test', () {
      /// TODO addTearDown se usa dentro de un test
      ///  especifico y se ejecuta justo despues de
      ///  culminar este mismo, permite funciones async
      addTearDown(() async {
        await Future.delayed(const Duration(milliseconds: 2000));
        print('PRINT POST-THIS-SPECIFIC-TEST');
      });

      bool catchCalled = false;

      try {
        Get.i.find<String>(tag: 'apiKey');
      } catch (e) {
        if (e is AssertionError) {
          // e is AssertionError == isAssertionError
          catchCalled = true;
        }
      }
      expect(catchCalled, true);
      catchCalled = false;

      try {
        Get.i.find<String>();
      } catch (e) {
        if (e is AssertionError) {
          catchCalled = true;
        }
      }
      expect(catchCalled, true);
      catchCalled = false;

      try {
        Get.i.find<User>(lazy: true);
      } catch (e) {
        if (e is AssertionError) {
          catchCalled = true;
        }
      }

      expect(catchCalled, true);
      catchCalled = false;

      try {
        Get.i.find<User>(lazy: true, tag: 'user');
      } catch (e) {
        if (e is AssertionError) {
          catchCalled = true;
        }
      }
      expect(catchCalled, true);
    });

    test('FIND / REMOVE and PUT Test', () {
      Get.i.put<String>('API_KEY', tag: 'apiKey');
      final apiKey = Get.i.find<String>(tag: 'apiKey');
      expect(apiKey, 'API_KEY');

      Get.i.put<String>('GOOGLE_MAPS_API_KEY');
      final gooMapsApiKey = Get.i.find<String>();
      expect(gooMapsApiKey, 'GOOGLE_MAPS_API_KEY');

      expect(Get.i.remove<String>(tag: 'apiKey'), true);
      expect(Get.i.remove<String>(), true);
      expect(Get.i.remove<User>(tag: 'User2'), false);
      expect(Get.i.remove<User>(), false);
    });

    test('LAZYPUT and LAZY FIND Test', () {
      int counter = 0;
      int counter2 = 0;

      Get.i.lazyPut<User>(
        () {
          counter++;
          return User(
            id: '1234',
            email: 'test@test.com',
            name: 'David',
            lastName: 'Hernandez',
            password: '0000',
            birthday: DateTime(1999, 8, 10),
          );
        },
      );

      Get.i.lazyPut<User>(() {
        counter2++;
        return User(
          id: '5555',
          email: 'test@test.com',
          name: 'Chris',
          lastName: 'Evans',
          password: '1111',
          birthday: DateTime(1999, 10, 10),
        );
      }, tag: 'User2');

      Get.i.find<User>(lazy: true);
      expect(counter, 1);
      final user1 = Get.i.find<User>(lazy: true);
      expect(counter, 1);
      Get.i.find<User>(lazy: true, tag: 'User2');
      expect(counter2, 1);
      final user2 = Get.i.find<User>(lazy: true, tag: 'User2');
      expect(counter2, 1);

      expect(user1 != user2, true);
      expect(Get.i.remove<User>(tag: 'User2'), true);
      expect(Get.i.remove<User>(), true);

      Get.i.find<User>(lazy: true);
      expect(counter, 2);
      Get.i.find<User>(lazy: true, tag: 'User2');
      expect(counter2, 2);
    });

    test('CLEAR && LAZYCLEAR Test', () {
      expect(Get.i.clear(), 0);
      Get.i.put<String>('ADD TO DATA');
      expect(Get.i.clear(), 1);

      expect(Get.i.lazyClear(), 0);
      Get.i.lazyPut<String>(() => DateTime.now().toString());
      expect(Get.i.lazyClear(), 1);
    });
  });
}
