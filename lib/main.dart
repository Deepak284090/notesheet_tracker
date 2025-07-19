import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: AppRoutes.roleSelector,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
