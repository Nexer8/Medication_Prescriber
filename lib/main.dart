import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:ptsiim/services/service_locator.dart';

import 'screens/mobile/welcome_screen.dart';
import 'screens/web/welcome_screen.dart';

void main() {
  DIContainer.registerServices();

  runApp(MedicationPrescriber());
}

class MedicationPrescriber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.black,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medication prescriber',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: kIsWeb ? WebWelcomeScreen() : MobileWelcomeScreen(),
    );
  }
}
