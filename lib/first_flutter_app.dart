import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // runs MyApp
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /// MyApp extends StatelessWidget
  /// widgets are the elements from which you build every Flutter app
  /// creates the app-wide state
  /// names the app
  /// defines the visual theme
  /// sets the home widget (starting point of app)
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  /// MyAppState defines the data the app needs to function
  /// MyAppState extends ChangeNotifier - it can notify others about its own changes
  /// this state is created and provided to the whole app using ChangeNotifierProvider (see MyApp class) - allows any widgets in the app to get a hold of the state
  var current = WordPair.random();

  // reassigns 'current' to a new random WordPair
  // calls 'notifyListeners' (a method of ChangeNotifier) to ensure anyone watching MyAppState is notified
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  // list of type WordPair - initialised empty
  // could use a set instead {}
  var favorites = <WordPair>[];

  // removes or adds current word pair to favourites list
  // notifies listeners after
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  /// stateful widget - has its own state
  /// underscore makes the class private and is enforced by compiler
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // needs to track one varaible: selectedIndex - initiaised to 0
  var selectedIndex = 0;

  @override
  // every widget defines a build() method that's automatically calledevery time the widget's circumstances cahnge so that the widget is always up to date
  Widget build(BuildContext context) {
    // page variable of type Widget
    Widget page;
    // switch statement assigns a screen to page, according to current value in selectedIndex
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
      case 1:
        page = FavoritesPage();
      case 2:
        // placeholder is a handy widget that draws a crossed rectange wherever you palce it, marking that part of the UI as unfinished
        page = Placeholder();
      default:
        //"fail fast principle" makes sure to throw an error if not selected
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // LayoutBuilder lets you change your widget tree depending on how much available space you have
    // builder calback is called every time the constraints change e.g. when the user reszies the app window, the user rotates their phone, widgets next to MyHomePage change in size
    return LayoutBuilder(
      builder: (context, constraints) {
        // every build method must return a widget / nested tree of widgets - top-level widget is Scaffold in this case
        return Scaffold(
          body: Row(
            children: [
              // ensures that its child is not obsucred by a hardware notch or a status bar
              SafeArea(
                // navigation rail has 2 destiantions with their respective icons and labels
                child: NavigationRail(
                  // doesn't show the labels next to icons if set to false
                  // shows the labels next to icons if set to true
                  // shows labels if the width of MyHomePage is greater than or equal to 600
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.extension),
                      label: Text('Placeholder'),
                    ),
                  ],
                  //defines the current selectedIndex - 0 = first destination, 1 = second destination - uses the selectedIndex varaible
                  selectedIndex: selectedIndex,
                  //updates the state - setState is similar to notifyListeners - ensures that the UI updates
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              // expanded widget takes as much of the room as possible (they are greedy)
              // multiple expanded widgets split all space between themselves
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class GeneratorPage extends StatelessWidget {
  /// each page of the app is extracted
  @override
  Widget build(BuildContext context) {
    //tracks changes to the app's current state using the watch method
    var appState = context.watch<MyAppState>();

    //accesses the 'current' member of this class (which is a WordPair)
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      // column is one of the most basi layout widgets in Flutter - takes any number of children and puts them in a column from top to bottom
      child: Column(
        // by default, the column visually places its children at the top - this centers it instead along it's main axis
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          //SizedBox widget creates visual gaps
          SizedBox(height: 10),
          Row(
            // could use mainAxisAlignment - but can also use mainAxisSize - different but yields same results
            mainAxisSize: MainAxisSize.min,
            children: [
              // creates a button with an icon
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pair});
  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    // uses the app's current theme defined in MyApp
    // uses this theme to use the theme's primary colour
    // updating the theme in MyApp will cascade changes across the whole app
    // an app-wide Theme opposed to hard-coding values
    // 'displayMedium' is a type of style for text
    // copyWith returns a copy - so that changes don't change the whole theme
    var theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    // Text widget > wrapped with Padding widget > wrapped with Card widget
    return Card(
      color: theme.colorScheme.primary,
      // padding adds room around the widget
      // padget itself is a widget - not an attribute of Text
      // can add Padding widget for anything you like
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          // WordPair provides helpful getters e.g. asPascalCase, asLowerCase
          pair.asPascalCase,
          style: style,
          // good for accessability - overrides the visual content of the text widget with a semantic content that is more appropriate for screen readers
          semanticsLabel: pair.asPascalCase,
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // accesses current state of app
    var appState = context.watch<MyAppState>();

    // if list of favourites is empty, show centered message saying "no favourites yet"
    if (appState.favorites.isEmpty) {
      return Center(child: Text('No favorites yet.'));
    }

    // otherwise, shows a column that scrolls
    return ListView(
      children: [
        // shows count of all favourites
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'You have '
            '${appState.favorites.length} favorites:',
          ),
        ),
        // iterates through all the favourites, constructs a ListTile widget for each one
        for (var pair in appState.favorites)
          // ListTile widget displays grouped propreties - leading icon and title
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asPascalCase),
          ),
      ],
    );
  }
}
