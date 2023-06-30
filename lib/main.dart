
import 'package:flutter/material.dart';
import 'package:flutter_ml_ocr/presentation/ocr_ktp/capture_ktp_page.dart';

import 'injectable.dart';


void main() {
  // Memanggil function config dependencies INJECTOR
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const CaptureKtpPage(),
    );
  }
}

