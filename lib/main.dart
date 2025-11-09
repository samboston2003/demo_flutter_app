// gives access to all widgets and features
import 'package:flutter/material.dart';
// ignore: unused_import
import 'dart.dart' as dart_file;
// ignore: unused_import
import 'first_flutter_app.dart' as flutter_file;

// entry point for every Flutter app
// void doesn't return anything
void main() {
  // runApp attaches the widget tree to the screen and starts the Flutter renderin process
  // pass it a widget - which becomes the root of the app's widget tree
  // const means widget and its configuration won't change so Flutter can optimise it
  runApp(const MyApp());

  // runs dart file
  // dart_file.main;

  // runs first_flutter_app file
  // flutter_file.main();
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
    return const MaterialApp(
      // shows / hides the 'DEBUG' banner in the corner
      debugShowCheckedModeBanner: true,
      // defines the main screen of the app
      // Scaffold is a basic page structure for a Material Design app
      // provides slots for things like appBar, body, floatingActionButton, drawer
      // when empty, shows a blank white screen
      home: Scaffold(),
    );
  }
}
