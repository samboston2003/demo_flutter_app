import 'dart:math';

void main() {
  print('Running dart.dart');

  // string interpolation
  stringInterpolation();

  // nullable variables
  nullableVariables();

  // null-aware operators
  nullAwareOperators();

  // conditional property access
  conditionalPropertyAccess();

  // collection literals
  collectionLiterals();

  // arrow syntax
  arrowSyntax();

  // cascades
  cascades();

  // getters and setters
  gettersAndSetters();

  // named and positional parameters
  namedAndPostionalParameters();

  // exceptions
  exceptions();

  // thisInConstructor
  thisInConstructor();

  // initialiserLists
  initialiserLists();

  // namedConstructors
  namedConstructors();

  // factoryConstructors
  factoryConstructors();

  // redirectingConstructors
  redirectingConstructors();

  // constConstructors
  constConstructors();

  // enums
  enums();

  // inheritance
  inheritance();

  // mixins
  mixins();

  // abstrarctClasses
  abstrarctClasses();

  // interfaces
  interfaces();

  // async
  async();
}

// simulate a slow network call using Future.delayed
Future<String> fetchData() async {
  print('Fetching data...');
  await Future.delayed(Duration(seconds: 2)); // simulate delay
  return 'Data loaded';
}

void async() async {
  // normally code runs synchronously - one line after another
  // sometimes want to pause and wait for something without freezing the program
  // that's where 'async' and 'await' come in
  // 'Future' represents a value that will be available later
  // 'async' marks a function as asynchronous (returns a 'Future')
  // 'await' keyword pauses execution until the 'Future' completes

  print('Program started');

  // await pauses until fetchData completes
  String result = await fetchData();
  print(result);
  print('Program finished');

  // alternatitvely: without await
  // var future = fetchData();
  // print('This prints immediately!');
  // future.then((value) => print(value)); // handle Future result with .then()
  // print('Program finished');
}

// normal class, but it can be used as an interface
class Flyer {
  void fly() {
    print('Flying...');
  }
}

// normal calss, can also be used as an interface
class Swimmer2 {
  void swim() {
    print('Swimming...');
  }
}

// class that implements multiple interfaces
// all methods and properties must be overridden
// interface != inheritance, you don't get behaviour only the method SIGNATURE (no code is reused)
class Goose implements Flyer, Swimmer2 {
  @override
  void fly() {
    print('Goose is flying low');
  }

  @override
  void swim() {
    print('Goose is paddling on water');
  }
}

void interfaces() {
  // in Dart, every class defines an interface automatically - not just abstract ones
  // when you use 'implements', it means "I will follow this class's contract (methods and properties) but I will write my own implementation"
  // can implement multiple interfaces, unlike inheritance - which only allows one superclass

  var goose = Goose();
  goose.fly();
  goose.swim();
}

// abstract class — you can’t create an instance of it directly
abstract class Animal3 {
  // abstract method (declared but no body - needs to be overridden by subclass)
  void makeSound();

  // concrete method (has a body - doesn't need to be overirdden)
  void sleep() {
    print('Sleeping...');
  }
}

// a subclass must override the abstract method - all abstract methods must be overidden
class Cat extends Animal3 {
  @override
  void makeSound() {
    print('Meow!');
  }
}

void abstrarctClasses() {
  // abstract class is a class that can't be implemented directly
  // exists only to be extended (inherited from) or implemented
  // use the keyword abstract
  // usee when you want to provide base functionality and require subclasses to implement specific methods

  var cat = Cat();
  cat.makeSound();
  cat.sleep();
  // error — cannot instantiate abstract class
  // var a = Animal3();
}

// define with 'mixin' keyword
mixin Walker {
  void walk() {
    print('Walking...');
  }
}

// optional 'on' means only classes that extent or implement Animal2 can use the Swimmer mixin
mixin Swimmer on Animal2 {
  void swim() {
    print('Swimming...');
  }
}

// base class
class Animal2 {
  void eat() {
    print('Eating...');
  }
}

// class that uses mixins
class Duck extends Animal2 with Walker, Swimmer {
  void quack() {
    print('Quack!');
  }
}

void mixins() {
  // mixins are a way of resuing code in multiple class hierarchies
  // allows for sharing behaviour between classes without using inheritance
  // a mixin is like a small "bundle" of methods and properties that you can add to a class
  // used when you want multiple classes to chare code, but don't want them to share a parent class
  // safer and cleaner wayo f copy-pasting methods into multiple classes
  // use when multiple unrelated classes need the same behaviour
  // when you want code reuse but don't want inheritance

  // mixin = defines a reusable set of behaviours
  // with = applies one or more mixins to a class
  // on = restricts which classes can use the mixin
  // extends = still used for normal inheritance (can be combined with 'with')

  var duck = Duck();

  duck.eat(); // from Animal2 class
  duck.walk(); // from Walker mixin
  duck.swim(); // from Swimmer mixin
  duck.quack(); // from Duck itself
}

// base class / super class / parent class
class Animal1 {
  // property
  String name;

  // constructor
  Animal1(this.name);

  // methods
  void eat() {
    print('$name is eating.');
  }

  void sleep() {
    print('$name is sleeping.');
  }

  // method that will be overridden by child class
  void makeSound() {
    print('$name makes a generic animal sound.');
  }
}

// sub class / child class
class Dog extends Animal1 {
  // extra property unique to Dog
  String breed;

  // constructor calls the parent constructor using 'super'
  Dog(super.name, this.breed);

  // new method only Dog has
  void bark() {
    print('$name barks: Woof! Woof!');
  }

  // override a parent method
  @override
  void makeSound() {
    // optionally call the parent version first
    super.makeSound();
    // then add Dog-specific behavior
    print('$name (a $breed) says: Woof!');
  }
}

void inheritance() {
  // create a Dog object
  var dog = Dog('Buddy', 'Golden Retriever');

  // access properties
  print('Name: ${dog.name}');
  print('Breed: ${dog.breed}');

  // call inherited methods
  dog.eat();
  dog.sleep();

  // call subclass-specific methods
  dog.bark();

  // call overridden method
  dog.makeSound();
}

enum Weather {
  sunny('☀️', 30),
  cloudy('☁️', 20),
  rainy('🌧️', 15),
  snowy('❄️', 0);

  // fields — each enum value will have these
  final String icon;
  final int averageTemperature;

  // const constructor — used to assign data to each enum value
  const Weather(this.icon, this.averageTemperature);

  // method — example of something useful you can do
  String describe() {
    return 'Weather: ${name.toUpperCase()} $icon, Avg Temp: $averageTemperature°C';
  }

  // can also add computed properties
  bool get isCold => averageTemperature < 10;
}

void enums() {
  // enum defines a fixed set of named constants
  // can add fields, constructors, and methods

  // accessing a value
  var today = Weather.sunny;

  // using the fields
  print('Today is ${today.name} ${today.icon}');
  print('Average temperature: ${today.averageTemperature}°C');

  // using the method
  print(today.describe());

  // using the computed getter
  print('Is it cold? ${today.isCold}');

  // loop through all values
  for (var w in Weather.values) {
    print(w.describe());
  }
}

class ImmutablePoint {
  // compile-time constant instance
  // constant static field you can re-use anywhere without creating new objects
  static const ImmutablePoint origin = ImmutablePoint(0, 0);

  // all instance variables must be final
  final int x;
  final int y;

  // const constructor - allows compile-time constant objects
  const ImmutablePoint(this.x, this.y);

  @override
  String toString() => 'ImmutablePoint(x: $x, y: $y)';
}

void constConstructors() {
  // if your class produces objects that never change, you can make these obejcts compile-time constants
  // to do this define a const constructor and make sure that all instance variables are final
  // Dart canonicalises it - only one instance of that exact value in memory

  // normal object (created at runtime)
  final p1 = ImmutablePoint(3, 4);

  // compile-time constant objects (same instance)
  const p2 = ImmutablePoint(3, 4);
  const p3 = ImmutablePoint(3, 4);

  // ImmutablePoint(x: 3, y: 4)
  print(p1);
  // ImmutablePoint(x: 3, y: 4)
  print(p2);
  // ImmutablePoint(x: 3, y: 4)
  print(p3);

  // false — runtime (p1) vs const (p2)
  print(identical(p1, p2));
  // true  — both (p2, p3) compile-time constants
  print(identical(p2, p3));

  // ImmutablePoint(x: 0, y: 0)
  print(ImmutablePoint.origin);
}

class Automobile {
  String make;
  String model;
  int mpg;

  // main constructor for this class - everything else redirects to this
  Automobile(this.make, this.model, this.mpg);

  // delegates to the main constructor - body is empty, just a : and a call to the main constructor with a default mpg of 60
  Automobile.hybrid(String make, String model) : this(make, model, 60);

  // delegates to a named constructor - redirects to hybrid constructor, which then redirects to main constrctor - chain of redirects
  Automobile.fancyHybrid() : this.hybrid('Futurecar', 'Mark 2');

  @override
  String toString() => 'Automobile(make: $make, model: $model, mpg: $mpg)';
}

void redirectingConstructors() {
  // sometimes a constructor's only purpose is to redirect to another constructor in the same class
  // a redirecting contructor's body is empty, with the constructor call appearing after a colon :
  // redirecting constructors cannot have a body
  // everything happens before the actual object is built

  // main constructor
  final car1 = Automobile('Toyota', 'Camry', 30);
  // redirecting constructor (calls main one with mpg = 60)
  final car2 = Automobile.hybrid('Honda', 'Insight');
  // redirecting constructor that calls another named constructor
  final car3 = Automobile.fancyHybrid();

  // Automobile(make: Toyota, model: Camry, mpg: 30)
  print(car1);
  // Automobile(make: Honda, model: Insight, mpg: 60)
  print(car2);
  // Automobile(make: Futurecar, model: Mark 2, mpg: 60)
  print(car3);
}

class Square extends Shape {}

class Circle extends Shape {}

class Shape {
  Shape();

  factory Shape.fromTypeName(String typeName) {
    if (typeName == 'square') return Square();
    if (typeName == 'circle') return Circle();

    throw ArgumentError('Unrecognised $typeName');
  }
}

void factoryConstructors() {
  // Dart supports factory constructors, which can return subtypes or even null
  // to create a factory constructor, use the factory keyword
  // factory constructor doesn't always create a new instance of its own class
  // can reutnr a subclass instance, return an existing object, reutrn null
  // e.g. creating Shape object dynamically based on string
  // factory constructor acts as a shape factory that decides which subclass to instanstiate

  Shape shape1 = Shape.fromTypeName('square');
  Shape shape2 = Shape.fromTypeName('circle');

  print(shape1);
  print(shape2);
}

class NamedPoint {
  double x, y;

  NamedPoint(this.x, this.y);

  NamedPoint.origin() : x = 0, y = 0;
}

void namedConstructors() {
  // to allow classes to have multiple consturctors, Dart supports named constuctors
  // to use a named constructor, invoke it using its full name

  // ignore: unused_local_variable
  final namedPoint = NamedPoint.origin();
}

class Point {
  final int _x;
  final int _y;
  final double _distanceFromOrigin;

  // constructor with initialiser list
  // asserts used to check for conditions that must be true during development - catches errors early and throws an AssertionError if false - only for debug mode
  Point(this._x, this._y)
    : assert(_x >= 0, 'x must be non-negative'),
      assert(_y >= 0, 'y must be non-negative'),
      _distanceFromOrigin = sqrt((_x * _x + _y * _y).toDouble());

  //getters
  int get x => _x;
  int get y => _y;
  double get distanceFromOrigin => _distanceFromOrigin;

  //overrides the toString function
  @override
  String toString() => 'Point(x: $_x, y: $_y, distance: $_distanceFromOrigin)';
}

void initialiserLists() {
  // sometimes when you implement a constructor, you need to do some setup before the construtor body exectues
  // for example, final fields must have values before the constructor body executes
  // do this work in an initialiser list, which goes between the constructor's signature and body

  final p = Point(3, 4);
  print(p.x);
  print(p.y);
  print(p.distanceFromOrigin);
  print(p);
}

class MyColourPositional {
  int red;
  int green;
  int blue;

  MyColourPositional(this.red, this.green, this.blue);
}

class MyColourNamedRequired {
  int red;
  int green;
  int blue;

  MyColourNamedRequired({
    required this.red,
    required this.green,
    required this.blue,
  });
}

class MyColourNamedDefault {
  int red;
  int green;
  int blue;

  MyColourNamedDefault({this.red = 0, this.green = 0, this.blue = 0});
}

void thisInConstructor() {
  // Dart provides handy shortcut for assigning values to properties in a contructor
  // this.propertyName when declaring the constructor

  // positional parameters
  // ignore: unused_local_variable
  final colour1 = MyColourPositional(80, 80, 128);

  // named parameters
  // required needed because int values can't be null
  // ignore: unused_local_variable
  final colour2 = MyColourNamedRequired(red: 80, green: 80, blue: 80);
  // if you add defaul values, you can omit required
  // ignore: unused_local_variable
  final colour3 = MyColourNamedDefault(red: 80, green: 80, blue: 80);
}

void exceptions() {
  // Dart can throw and catch exceptions
  // Dart's exceptions are unchecked
  // methods don't declare which excetpions they migh throw and you aren't required to catch any exceptions
  // Dart provides 'Exception' and 'Error' types, but you're allowed to throw any non-null object

  // throw = raise an exception
  // try = block of code that might fail
  // on = catch specific exception types
  // catch (e) = catch general exceptions
  // rethrow = propogate exception upward
  // finally = always run cleanup code

  void riskyOperation() {
    try {
      print('Starting risky operation...');
      // throw - how you create and raise an exception in Dart
      // can throw any object but usually throw subclass of Exception or Error
      // specific exception:
      throw FormatException('Bad input format!');
      // non-specific exception:
      // ignore: dead_code
      throw Exception('Something went wrong!');
    } catch (e) {
      print('Caught inside riskyOperation: $e');
      // rethroww passes the exception upward to the next higher level try block
      // useful if you want to log or partailly handle an erorr but still let someone else handle it fully
      rethrow;
    }
  }

  try {
    // try block encloses code that might throw an exception
    // if anything inside throws it, Dart looks for a matchning on or catch block
    riskyOperation();
  } on FormatException catch (e) {
    // on lets you catch specific exception types
    // use this when you know the type of error you're expecting
    print('Caught a FormatException: $e');
  } on Exception catch (e) {
    // catch (e) catches any exception that isn't caught by an earlier on clause
    // stackTrace can be used to inspect the call stack
    print('Caught a general Exception: $e');
  } catch (e, stackTrace) {
    // handles non-exceptions (rare)
    print('Caught something else: $e $stackTrace');
  } finally {
    // finally always executes, whether an exception was thrown or not
    // often used for cleanup
    print('Finally block: cleaning up resources...');
  }

  print('Program continues after try/catch.');
}

void namedAndPostionalParameters() {
  // dart has 2 kind of function parameters - positional and named
  // POSITIONAL: [], must call in order, optional with []
  // NAMED: {}, can call in any order, optional by default but can add 'required'
  // function can't have both optional positional and named parameters

  // positional parameter - "normal" parameters you pass in order
  // by default, all positional parameters are required
  // unless wrapped in sqaure bracket [], which make them optional positional
  // optional positional parameters must come after required ones
  // if they are omitted, they take null (or the deafult if provided)
  void greet1(String firstName, [String lastName = '']) {
    print('Hello, $firstName $lastName!');
  }

  greet1('Alice', 'Smith');
  greet1('Bob');

  // named parameters - use curly brackets {} instead of []
  // can make them required using 'required' keyword
  // the default value of a nullable named parameter is null
  // if the type of parameter is non-nullable then you must provide a default value or make the parameter as required
  void greet2({required String firstName, String lastName = ''}) {
    print('Hello, $firstName $lastName!');
  }

  greet2(firstName: 'Alice', lastName: 'Smith');
  greet2(firstName: 'Bob');
}

class MyClass {
  // underscore makes the property private to the library (only accessible in file where class is defined)
  // backing field = a private variable that actually stores the data for a property
  // property itself is accessed through getters and setters
  // backing field holds the value internally, hidden from direct external access
  // allows you to control how the value is read or written
  int _aProperty = 0;

  // getter
  // allows external code to read the value of _aProperty without giving direct access to the private variable
  // aProperty acts like a pulic property but intenrally it returns _aProperty
  int get aProperty => _aProperty;

  // setter
  // allows external code to write a value to _aProperty, but you can control the logic
  // only updates _aProperty if value >= 0
  set aProperty(int value) {
    if (value >= 0) {
      _aProperty = value;
    }
  }
}

void gettersAndSetters() {
  // define getters and setters whenever you need more control over a property than a simple field allows
  // encapsulation: keeps _aProperty private while exposing a controlled interface
  // validations: your setter cna prevent invalid values
  // flexibility: can later change how _aProperty works without changng external code
  // getters and setters don't need to be explicitly called - compiler handles it for you

  // initialise MyClass object
  final obj = MyClass();

  // 0
  // getter  called
  print(obj.aProperty);

  // 5
  // setter  called
  obj.aProperty = 5;
  // getter called
  print(obj.aProperty);

  // still 5
  // setter called
  obj.aProperty = -3;
  // getter called
  print(obj.aProperty);
}

void cascades() {
  // to perform a sequence of operations on the same object, use cascades (..)
  // can chain together operations that would otherwise require separate statements

  // without cascades
  final list1 = <int>[];
  list1.add(1);
  list1.add(12);
  list1.add(3);
  list1.sort();
  print(list1);

  // with cascades
  final list2 = <int>[]
    // ignore: prefer_inlined_adds
    ..add(1)
    ..add(12)
    ..add(3)
    ..sort();
  print(list2);
}

void arrowSyntax() {
  // => symbol is a way to define a function that executes the expression to its right and returns its value
  // both functions check the list to see if any of the elements are empty - the 2nd is much simpler

  //example 1
  final aListOfStrings1 = ['one', 'two', 'three'];
  final aListOfStrings2 = ['one', 'two', 'three', ''];

  bool hasEmpty1 = aListOfStrings1.any((s) {
    return s.isEmpty;
  });
  print(hasEmpty1);

  bool hasEmpty2 = aListOfStrings2.any((s) => s.isEmpty);
  print(hasEmpty2);

  //example 2
  int value1 = 2;
  int value2 = 3;
  int value3 = 5;

  int multiplyValues1() {
    return value1 * value2 * value3;
  }

  print(multiplyValues1());

  int multiplyValues2() => value1 * value2 * value3;
  print(multiplyValues2());

  //example 3
  String joinWithCommas1(List<String> strings) {
    return strings.join(',');
  }

  print(joinWithCommas1(aListOfStrings1));

  String joinWithCommas2(List<String> strings) => strings.join(',');
  print(joinWithCommas2(aListOfStrings1));
}

void collectionLiterals() {
  // built in support for lists, maps, and sets
  // dart's type inference can assign types to these variables
  // or can specify the types yourself
  // final means you can only assign the variable once - but can still modify the value if it's a mutable objet e.g. list, map, set

  // list - inferred type List<String>
  // ignore: unused_local_variable
  final aListOfStrings = ['one', 'two', 'three'];
  // set - inferred type Set<String>
  // ignore: unused_local_variable
  final aSetOfStrings = {'one', 'two', 'three'};
  // map - inferred type Map<String, int>
  // ignore: unused_local_variable
  final aMapOfStringsToInts = {'one': 1, 'two': 2, 'three': 3};

  // list - type int
  // ignore: unused_local_variable
  final aListOfInts = <int>[];
  // set - type int
  // ignore: unused_local_variable
  final aSetOfInts = <int>{};
  // map - type <int, double>
  // ignore: unused_local_variable
  final aMapOfIntToDouble = <int, double>{};

  // useful when initialise a list with contents of a subtype
  final aListOfNums = <num>[1, 2.5];
  aListOfNums.add(3);
  aListOfNums.add(4.75);
  print(aListOfNums);
}

void conditionalPropertyAccess() {
  //guard access to a property or method of an object that might be null - put a ? before .

  // word is null - so .toLowerCase() will not run
  String? word;
  // ignore: dead_code
  print(word?.toLowerCase());

  // word is not null - so .toLowerCase() will run
  word = "HELLO";
  // ignore: invalid_null_aware_operator
  print(word?.toLowerCase());
}

void nullAwareOperators() {
  /// dart offers operators that handle values that could be null
  /// ??= assignment operator assigns a value only if variable is currently null
  /// ?? returns expression on left unless that expression's value is null - in which case it returns expression on right

  // successful overwrite
  int? nullable4;
  nullable4 ??= 3;
  print(nullable4);

  //unsuccessful overwrite
  // ignore: dead_code, dead_null_aware_expression
  nullable4 ??= 5;
  print(nullable4);

  //prints 1
  // ignore: dead_null_aware_expression
  print(1 ?? 3);

  // prints 12
  // ignore: unnecessary_null_in_if_null_operators
  print(null ?? 12);
}

void nullableVariables() {
  /// dart enforces sound null safety - types are default non-nullable

  // invalid example
  // int nullable1 = null

  // valid example
  // ignore: avoid_init_to_null
  int? nullable2 = null;
  print(nullable2);

  // simplified example - null is deafuly for uninitialised varaibles
  int? nullable3;
  print(nullable3);
}

void stringInterpolation() {
  /// wrap in ${expresion}

  //yields '5' as a string
  print('${3 + 2}');

  // yields 'WORD' as a sring
  // string interpolation not needed as just handling strings
  // ignore: unnecessary_string_interpolations
  print('${"word".toUpperCase()}');
  print("word".toUpperCase());

  // yields 123 as a string
  int number = 123;
  print('$number');
}
