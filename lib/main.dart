
import 'package:flutter/material.dart';

import 'injectable.dart';
import 'presentation/ocr_ktp/capture_ktp_page.dart';


void main() {
  registerWebViewWebImplementation();
  // Memanggil function config dependencies INJECTOR
  configureDependencies();
  runApp(const MyApp());
}

void registerWebViewWebImplementation() {
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

