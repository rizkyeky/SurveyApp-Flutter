import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'locator.dart';
import 'view/page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return MaterialApp(      
      debugShowCheckedModeBanner: false,
      title: 'Survey App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: QuestionPage(const {
        'Nomor KK': '12345',
        'Anggota': [
          {
            'Nama': 'Rizky'
          }
        ]
      }),
    );
  }
}