import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

import 'locator.dart';
import 'view/page.dart';
// import 'service/service.dart';
// import 'bloc/bloc.dart';

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
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => HomePage());
            break;
          case '/input':
            return MaterialPageRoute(builder: (_) => InputPage());
            break;
          case '/ques':
            final Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(builder: (_) => QuestionPage(data));
            break;
          case '/list':
            return MaterialPageRoute(builder: (_) => ListPage());
            break;
          default:
            return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(
              child: Text('No Route'),
            ),));
        }
      },
    );
  }
}