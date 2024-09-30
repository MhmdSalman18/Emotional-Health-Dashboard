import 'package:demo1/demo1.dart';
import 'package:demo1/home_screen.dart';
import 'package:demo1/home2.dart';
import 'package:demo1/register.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(Myapp());
}
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 234, 7, 255)),
      home: RegisterPage(),
    );
  }
}