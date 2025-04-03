import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:miniproject/screens/splash_screen/startscreen.dart';
import 'package:provider/provider.dart';
import 'resume_provider.dart'; // Import your ResumeProvider

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => ChangeNotifierProvider(
        create: (context) => ResumeProvider(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Nunito'),
      ),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}
