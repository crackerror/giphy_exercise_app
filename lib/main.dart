import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:giphy_exercise_app/persentation/giphy_screen/giphy_screen.dart';

void main() {
  runApp(const MyApp());
}

///   PXkOQSY14UIOGC2C66LsVKB1mpO5ESyR

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: GiphyScreen(),
    );
  }
}
