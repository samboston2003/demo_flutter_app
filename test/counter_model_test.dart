import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Flutter tests run in a test environment, not a full app
  // Shared preferences (and other Futter services) require the binding to be initialised
  // This line ensures Flutter is ready to handle async services and widgets
  TestWidgetsFlutterBinding.ensureInitialized();

  // group groups multiple related tests together
  // makes the output easier to read and organise
  // all the tests inside this group are related to CounterModel
  group('CounterModel Tests', () {
    late CounterModel counter;

    // runs before each test
    setUp(() async {
      // mocks the storage so you don't use real device storage
      // starts with an empty map, so counter starts at 0
      SharedPreferences.setMockInitialValues({});
      // creates a new instance
      counter = CounterModel();
      // loads the initial value from the mocked storage
      await counter.loadCounter();
    });

    // test(description, callback) defines asingle test
    //expect(actual, matcher) cheks if a value matches what you expect
    test('initial value is 0', () {
      expect(counter.counter, 0);
    });

    test('increment increases counter', () {
      counter.increment();
      expect(counter.counter, 1);
    });

    test('decrement decreases counter', () {
      counter.decrement();
      expect(counter.counter, -1);
    });

    test('reset sets counter to 0', () {
      counter.increment();
      counter.increment();
      counter.reset();
      expect(counter.counter, 0);
    });
  });
}
