import 'package:diagnostico/src/map.dart';

import 'src/selectors.dart';
import 'package:flutter/material.dart';
import 'src/login.dart';
//void main() => runApp(const MaterialApp(home: Home()));

void main() => runApp(
  MaterialApp(
    title: 'Routes',
    initialRoute: '/',
    onGenerateRoute: (settings) {
      switch (settings.name) {
        case '/':
          return MaterialPageRoute(builder: (context) => const Login());
        case '/selects':
          return MaterialPageRoute(builder: (context) => const Selectors());
        case '/map':
          return MaterialPageRoute(
            builder: (context) => const MapScreen(locationType: 'parque'),
          );
        default:
          return MaterialPageRoute(builder: (context) => const Login());
      }
    },
  ),
);