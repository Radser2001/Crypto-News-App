import 'package:flutter/material.dart';
import 'package:newsapp/screens/home.dart';
import 'package:newsapp/widgets/article_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': ((context) => const Home()),
      '/article': ((context) => Article()),
    },
  ));
}
