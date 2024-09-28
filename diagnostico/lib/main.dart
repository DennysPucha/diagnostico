import 'src/selectors.dart';
import 'package:flutter/material.dart';
import 'src/login.dart';
//void main() => runApp(const MaterialApp(home: Home()));

void main () => runApp(
  MaterialApp(
    title: 'Routes',
    initialRoute: '/',
    routes: {
      '/':(context) => const Login(),
      '/selects': (context) => const Selectors(),
    },
  )
);