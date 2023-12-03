import 'package:flutter/material.dart';
import 'package:image_scanner/home.dart';
import 'package:image_scanner/result.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Home(),
    routes: {
      "/result": (context) => const Result(),
    },
  ));
}

