// gives access to all widgets and features
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'dart.dart' as dart_file;
// ignore: unused_import
import 'first_flutter_app.dart' as flutter_file;

// Widget Tree
// Ctrl + Shift + P
// Flutter: Open Dev Tools
// Widget Inspector

// Flutter shortcuts for widgets:
// stful = StatefulWidget boilerplate
// stless	= StatelessWidget boilerplate
// scaf = Scaffold with AppBar and body
// cont	= Container widget
// col	= Column widget
// row	= Row widget
// cen	= Center widget
// txt	= Text widget
// btn	= ElevatedButton widget

// Convert StatelessWidget to StatefulWidget
// Ctrl + .
// Convert to Stateful Widget

// Open Widget Tree
// Control + Shift + P

// entry point for every Flutter app
// void doesn't return anything
void main() {
  // runApp attaches the widget tree to the screen and starts the Flutter renderin process
  // pass it a widget - which becomes the root of the app's widget tree
  // const means widget and its configuration won't change so Flutter can optimise it
  // runApp(const MyApp());

  // wrapped im ChangeNotifierProvider
  // creates an instacne of a class that extends ChangeNotifier
  // makes that instance available to all descendent widgets in the widget tree
  // automatically listens for changes - when notifyListeners() is called, any widget using this provider rebuilds
  // _ is a placeholder for BuildContext parameter
  runApp(
    ChangeNotifierProvider(create: (_) => CounterModel(), child: const MyApp()),
  );

  // runs dart file
  // dart_file.main;

  // runs first_flutter_app file
  flutter_file.main();
}

// defines a custom widget called MyApp
// extends StatelessWidget which is a widget without a internal state - never changes after being built
// rebuilt only if its constructor arguments change
class MyApp extends StatelessWidget {
  // passes the key up to the parent class - useful for widget identity and optimisation
  const MyApp({super.key});

  // every widget defines a build() method that returns the UI for that widget
  // gets a buildContext - allows Flutter to locate where in the widget tree you are
  @override
  Widget build(BuildContext context) {
    // MaterialApp is the root widget for most Flutter apps
    // sets up themes, navigation, localisation, debug tools, etc.
    // if all its arugments never change, can use const so Flutter can reuse that widget instead of rebuilding it - saves memory and performance
    // however, if using an AppBar, can't use const as it's not a const widget
    return MaterialApp(
      // shows / hides the 'DEBUG' banner in the corner
      debugShowCheckedModeBanner: true,

      theme: ThemeData(
        // primary colour
        primaryColor: Colors.blue,

        // scaffold background colour
        scaffoldBackgroundColor: Colors.grey[100],

        // text theme
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),

        // elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),

        // floating action button theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
      ),

      // home defines the main / first screen of the app
      // when using non-named routes use home:
      // home: const CounterScreen(),

      // when using named routes for navigation, use initialRoute
      // tells Flutter which route to load first when your app starts
      // '/' is just a string key, but represents the root or home page
      initialRoute: '/',

      // define where each named route leads to
      // map that connects string route names to widget builders
      // each eantry has a string key and a builder function
      routes: {
        '/': (context) => const CounterScreen(),
        '/info': (context) => const InfoScreen(),
      },
    );
  }
}

// Counter Screen implementation without ChangeNotifier and with a StatefulWidget
// // Created a StatefulWidget instead of StatelessWidet
// // StatelessWidgets can't update themselves - once built they stay the same
// // StatefulWidgets have a separate State object that can change and rebuild the UI
// // This is just the wrapper for the widget - doesn't hold the data itself - instead linked to another class that holds the state
// class CounterScreen extends StatefulWidget {
//   const CounterScreen({super.key});
//   @override
//   // method creates the State object where all the logic and mutable data live
//   State<CounterScreen> createState() => _CounterScreenState();
// }
// class _CounterScreenState extends State<CounterScreen> {
//   // counter variable
//   // _ makes it priviate to this file
//   int _counter = 0;
//   // void = function doesn't return a value
//   // _incrementCounter = name of function
//   // _ at the start = private to this file
//   // () = no parameters are passed to this function
//   // => = Dart shorthand for single experssion function
//   // SetState = method of StatefulWidget's State class - tells Flutter to rebuild the widget - triggering the build() method again
//   // () = defines function's parameters - empty as no arguments
//   // => _counter++ = function's body
//   void _incrementCounter() => setState(() => _counter++);
//   void _decrementCounter() => setState(() => _counter--);
//   void _resetCounter() => setState(() => _counter = 0);
//   @override
//   // every widget defines a build() method that returns the UI for that widget
//   // gets a buildContext - allows Flutter to locate where in the widget tree you are
//   Widget build(BuildContext context) {
//     // Scaffold is a basic page structure for a Material Design app - gives a full page layout
//     // provides slots for things like appBar, body, floatingActionButton, drawer
//     // when empty, shows a blank white screen
//     return Scaffold(
//       // app Bar is part of Scaffold
//       // puts it at top of screen - typically for titles, navigation buttons, actions
//       appBar: AppBar(
//         // title is what appears in appBar - often a Text widget but can be any type of widget
//         title: Text(
//           'Counter Page',
//           style: Theme.of(context).textTheme.headlineSmall,
//         ),
//         // centers the title horizontally - different default alignment on different devices - so this enforces it on all
//         centerTitle: true,
//         // changes background colour of AppBar
//         // Colors is part of Flutter's Material librayr - contains many pre-defined colours
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//       // global drawer
//       drawer: const AppDrawer(),
//       // body is part of Scaffold
//       // body is what fills the main screen area of your app
//       // Padding adds space around child
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         // Center is a layout widget which simply centers its child both vertically and horizontally
//         child: Center(
//           // Columns arrange widgets vertically
//           child: Column(
//             // esures column doesn't stretch the whole screen
//             mainAxisSize: MainAxisSize.min,
//             // children of column
//             children: [
//               // Stack widget allows you to place widgets on top of each other
//               // first child is at bottom, and each subsequent child is layered on top
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   // background circle behind text
//                   Container(
//                     width: 150,
//                     height: 150,
//                     decoration: BoxDecoration(
//                       color: Colors.blue[100],
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   // Text is a basic widget - simply displays a string on the screen
//                   // Use $ to reference variables - interpolated the variables into the string dynamically
//                   // When _counter changes, the whole widget rebuilds, showing the new value
//                   Text(
//                     '$_counter',
//                     // customise the look of the text with TextStyle
//                     // can be const as style is fixed
//                     style: Theme.of(context).textTheme.headlineLarge,
//                   ),
//                   // Positioned Widget used inside a Stack
//                   // allows you to precisley position a child relative to the Stack's edges
//                   Positioned(
//                     // top edge of the child is aligned 0 pixels from the top of the stack
//                     top: 0,
//                     // right edge of the child is aligned 0 pixels from the right of the stack
//                     right: 0,
//                     // Container = general purose wdget for layout, styling, and decoration
//                     child: Container(
//                       // padding adds pixels of padding inside container around its child
//                       padding: const EdgeInsets.all(10),
//                       // decoration used to style the Container visually
//                       decoration: BoxDecoration(
//                         // sets a colour of container
//                         color: Colors.red,
//                         // sets a shape of container
//                         shape: BoxShape.circle,
//                       ),
//                       // child of container, placed inside the padded, circuular, background
//                       child: const Icon(
//                         // star icon
//                         Icons.star,
//                         // size of icon
//                         size: 16,
//                         // colour of icon
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               // space between widgets
//               // hegiht = vertical
//               // weight = horizonal
//               const SizedBox(height: 20),
//               // rows align children horizontally
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ElevatedButton(
//                     onPressed: _decrementCounter,
//                     child: const Icon(Icons.remove),
//                   ),
//                   const SizedBox(width: 20),
//                   ElevatedButton(
//                     onPressed: _incrementCounter,
//                     child: const Icon(Icons.add),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               // Card is a material widget that adds a background, elevation, and shape
//               Card(
//                 // shadow effect
//                 elevation: 4,
//                 // shape of card
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 color: Colors.blue[50],
//                 child: Padding(
//                   // padding - space inside card
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text(
//                     'Use the + and - buttons to change the counter. \nTap the cross to reset.',
//                     // center the text inside the card
//                     textAlign: TextAlign.center,
//                     // override the theme colour
//                     style: Theme.of(
//                       context,
//                     ).textTheme.bodyMedium?.copyWith(color: Colors.blue[800]),
//                   ),
//                 ),
//               ),
//               // sized box
//               const SizedBox(height: 20),
//               // button
//               ElevatedButton(
//                 // when presed navigate to the /info page, passing the current context, as well as any arguments
//                 // this is the most direct and explicit way to pass arguments
//                 // sent in a small map so you can add more arguments later
//                 // ModalRoute is a Flutter class that represents the current route
//                 // .of(context) finds the current route from the given BuildContext
//                 // ?. is a null aware opeator - only accesses .settings if not null - returns null otherwise
//                 // .name is the string identifier - i.e. name of current route
//                 // ?? is a null coalescing operator - if value on left is null - use value on right instead
//                 onPressed: () {
//                   Navigator.pushNamed(
//                     context,
//                     '/info',
//                     arguments: {
//                       'from':
//                           ModalRoute.of(context)?.settings.name ?? 'Unknown',
//                     },
//                   );
//                 },
//                 child: const Text('Go to Info Page'),
//               ),
//             ],
//           ),
//         ),
//       ),
//       // floatingActionButton is part of Scaffold
//       // usually a circular button that floats over the main content
//       // Flutter automatically places it in the bottom right corner
//       floatingActionButton: FloatingActionButton(
//         // callback that runs when the button is tapped
//         // can be set to null so button is disabled
//         // can calso call method - each tap increases _counter and triggersa rebuild
//         onPressed: _resetCounter,
//         // required a child - typically an Icon
//         // use Flutter's built in icon set (Icons.clear)
//         // can be any widget
//         child: const Icon(Icons.clear),
//       ),
//     );
//   }
// }

// Created a StatefulWidget instead of StatelessWidget
// StatelessWidgets can't update themselves - once built they stay the same
// StatefulWidgets have a separate State object that can change and rebuild the UI
// This is just the wrapper for the widget - doesn't hold the data itself - instead linked to another class that holds the state

// However, when using Provider (or any other state management) - widget doesn't need to be stateful to respond to chagnes
// Provider.of<CounterModel>(context) listens for changes in the model
// whenever you call notifyListeners() inside CounterModel, all widgets that listen to it automatcally rebuild
// therefore, rebuilds are triggered by the model, not the widget itself
// however in the current implementation, it rebuilds the whole app every time the model is updated
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  // method creates the State object where all the logic and mutable data live
  Widget build(BuildContext context) {
    final counterModel = Provider.of<CounterModel>(context);

    // Scaffold is a basic page structure for a Material Design app - gives a full page layout
    // provides slots for things like appBar, body, floatingActionButton, drawer
    // when empty, shows a blank white screen
    return Scaffold(
      // app Bar is part of Scaffold
      // puts it at top of screen - typically for titles, navigation buttons, actions
      appBar: AppBar(
        // title is what appears in appBar - often a Text widget but can be any type of widget
        title: Text(
          'Counter Page',
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        // centers the title horizontally - different default alignment on different devices - so this enforces it on all
        centerTitle: true,

        // changes background colour of AppBar
        // Colors is part of Flutter's Material librayr - contains many pre-defined colours
        backgroundColor: Theme.of(context).primaryColor,
      ),

      // global drawer
      drawer: const AppDrawer(),

      // body is part of Scaffold
      // body is what fills the main screen area of your app
      // Padding adds space around child
      body: Padding(
        padding: const EdgeInsets.all(10.0),

        // Center is a layout widget which simply centers its child both vertically and horizontally
        child: Center(
          // Columns arrange widgets vertically
          child: Column(
            // esures column doesn't stretch the whole screen
            mainAxisSize: MainAxisSize.min,
            // children of column
            children: [
              // Stack widget allows you to place widgets on top of each other
              // first child is at bottom, and each subsequent child is layered on top
              Stack(
                alignment: Alignment.center,
                children: [
                  // background circle behind text
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      shape: BoxShape.circle,
                    ),
                  ),

                  // Text is a basic widget - simply displays a string on the screen
                  // Use $ to reference variables - interpolated the variables into the string dynamically
                  // When _counter changes, the whole widget rebuilds, showing the new value
                  Text(
                    '${counterModel.counter}',

                    // customise the look of the text with TextStyle
                    // can be const as style is fixed
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),

                  // Positioned Widget used inside a Stack
                  // allows you to precisley position a child relative to the Stack's edges
                  Positioned(
                    // top edge of the child is aligned 0 pixels from the top of the stack
                    top: 0,

                    // right edge of the child is aligned 0 pixels from the right of the stack
                    right: 0,

                    // Container = general purose wdget for layout, styling, and decoration
                    child: Container(
                      // padding adds pixels of padding inside container around its child
                      padding: const EdgeInsets.all(10),

                      // decoration used to style the Container visually
                      decoration: BoxDecoration(
                        // sets a colour of container
                        color: Colors.red,

                        // sets a shape of container
                        shape: BoxShape.circle,
                      ),

                      // child of container, placed inside the padded, circuular, background
                      child: const Icon(
                        // star icon
                        Icons.star,

                        // size of icon
                        size: 16,

                        // colour of icon
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              // space between widgets
              // hegiht = vertical
              // weight = horizonal
              const SizedBox(height: 20),

              // rows align children horizontally
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: counterModel.decrement,
                    child: const Icon(Icons.remove),
                  ),

                  const SizedBox(width: 20),

                  // call animated increment button instead
                  const AnimatedIncrementButton(),
                  // ElevatedButton(
                  //   onPressed: counterModel.increment,
                  //   child: const Icon(Icons.add),
                  // ),
                ],
              ),

              const SizedBox(height: 20),

              // Card is a material widget that adds a background, elevation, and shape
              Card(
                // shadow effect
                elevation: 4,
                // shape of card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.blue[50],
                child: Padding(
                  // padding - space inside card
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Use the + and - buttons to change the counter. \nTap the cross to reset.',
                    // center the text inside the card
                    textAlign: TextAlign.center,
                    // override the theme colour
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.blue[800]),
                  ),
                ),
              ),

              // sized box
              const SizedBox(height: 20),

              // button
              ElevatedButton(
                // when presed navigate to the /info page, passing the current context, as well as any arguments
                // this is the most direct and explicit way to pass arguments
                // sent in a small map so you can add more arguments later
                // ModalRoute is a Flutter class that represents the current route
                // .of(context) finds the current route from the given BuildContext
                // ?. is a null aware opeator - only accesses .settings if not null - returns null otherwise
                // .name is the string identifier - i.e. name of current route
                // ?? is a null coalescing operator - if value on left is null - use value on right instead
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/info',
                    arguments: {
                      'from':
                          ModalRoute.of(context)?.settings.name ?? 'Unknown',
                    },
                  );
                },
                child: const Text('Go to Info Page'),
              ),
            ],
          ),
        ),
      ),

      // floatingActionButton is part of Scaffold
      // usually a circular button that floats over the main content
      // Flutter automatically places it in the bottom right corner
      floatingActionButton: FloatingActionButton(
        // callback that runs when the button is tapped
        // can be set to null so button is disabled
        // can calso call method - each tap increases _counter and triggersa rebuild
        onPressed: counterModel.reset,

        // required a child - typically an Icon
        // use Flutter's built in icon set (Icons.clear)
        // can be any widget
        child: const Icon(Icons.clear),
      ),
    );
  }
}

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // gets current route
    // ! is a null assertion operator - only use when certain widget inside isn't null
    // get the arguments from within (default type of Object?) and cast it to correct type you're expecting - Map
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    // now you hvave Map, accessess the 'from' key in the map i.e. the name of the screen that sent you here
    final previousScreen = args['from'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Info Page',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),

      // Drawer slides in from left when the user swipes or taps the menu icon
      // global drawer
      drawer: const AppDrawer(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Navigated here from: $previousScreen',
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            const SizedBox(height: 30),

            // listens to CounterModel and rebuilds the textWidget whenevr counter changes
            // uses shared CounterModel instead of local _counter
            // no setState needed
            Consumer<CounterModel>(
              builder: (context, counterModel, child) => Text(
                'Current counter: ${counterModel.counter}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                ElevatedButton(
                  onPressed: () => context.read<CounterModel>().decrement(),
                  child: const Icon(Icons.remove),
                ),

                const SizedBox(width: 20),

                // call animated increment button instead
                const AnimatedIncrementButton(),

                // ElevatedButton(
                //   onPressed: () => context.read<CounterModel>().increment(),
                //   child: const Icon(Icons.add),
                // ),
                const SizedBox(width: 20),

                ElevatedButton(
                  onPressed: () => context.read<CounterModel>().reset(),
                  child: const Icon(Icons.clear),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    //current route name
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '/';

    // Drawer slides in from left when the user swipes or taps the menu icon
    return Drawer(
      // Drawer's content scrolls vertically - so use a ListView
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // customisable top section - for titles, logos, or user info
          SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Flutter Demo',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),

          // Each item in Drawer (like 'Home' or 'Info')
          // onTap defines what happens when you press it
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Counter Page'),
            //highlights current page tile
            selected: currentRoute == '/',
            selectedTileColor: Colors.blue[100],
            onTap: () {
              // closes the drawer - since it's technically a route overlay
              Navigator.pop(context);
              // navigates to another named route
              Navigator.pushNamed(context, '/');
            },
          ),

          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Info Page'),

            //highlights current page tile
            selected: currentRoute == '/info',
            selectedTileColor: Colors.blue[100],
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                '/info',
                arguments: {
                  'from': ModalRoute.of(context)?.settings.name ?? 'Unknown',
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// extends ChangeNotifier means that CounterModel inherits from ChangeNotifier
// ChangeNotifier is a built in Flutter class that lets you nottify listeners when the state changes
// any Widget that's listening to this model (via provider or consumer) will rebuild automatically when you call notifyListeners()
class CounterModel extends ChangeNotifier {
  // field
  int counter = 0;

  // loads the counter value when initialised
  CounterModel() {
    loadCounter();
  }

  // Future<void> is asynchronous and returns a Future that completes with no value (void)
  // Reading from persistent storage can take some time, so we don't block the UI
  // async / await - pauses execution until the asynchronous operation completes
  // gets a singleton insance of SharedPreferences which allows reading and writing key-value pairs locally on device
  // readsan integer value stored under the key 'counter'
  // if value exists, assign it to counter
  // if no value exists defaults to 0
  // tells any widget listening to this ChangeNotifier that the counter has changed and the UI rebuilds
  Future<void> loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    counter = prefs.getInt('counter') ?? 0;
    notifyListeners();
  }

  // Future<void> is asynchronous because writing to storage is not instantaneous
  // gets the same instance of SharedPreferences used for saving
  // saves the current value of counter under the key 'counter' - ensures next time _loadCounter() is called, latest value is retreived
  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', counter);
  }

  // methods - every time counter changes, save
  void increment() {
    counter++;
    _saveCounter();
    notifyListeners();
  }

  void decrement() {
    counter--;
    _saveCounter();
    notifyListeners();
  }

  void reset() {
    counter = 0;
    _saveCounter();
    notifyListeners();
  }
}

class AnimatedIncrementButton extends StatefulWidget {
  const AnimatedIncrementButton({super.key});

  @override
  State<AnimatedIncrementButton> createState() =>
      _AnimatedIncrementButtonState();
}

class _AnimatedIncrementButtonState extends State<AnimatedIncrementButton> {
  double _scale = 1.0;

  //scale up when pressed
  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 1.2);
  }

  //scaled down when released
  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
  }

  // reset if tap is cancelled
  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      //onTap: () => context.read<CounterModel>().increment(),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: ElevatedButton(
          onPressed: () => context.read<CounterModel>().increment(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

// HOW TO IMPROVE:
// 1) Split pages across mutliple files for simplicity
// 2) Break down widgets into collections of smaller widgets for simplicity
// 3) Better commenting
// 4) Use of /// for documentation
// 5) Better use of theming
// 6) Instead of hard coding pages in the drawer, define these at the start, then use a loop to display all of them
// 7) Better use of classes for reusable objects - e.g. with the Buttons
// 8) Store AppState in MyApp
// 9) Home Page - then build pages off this
