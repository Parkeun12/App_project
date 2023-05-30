import 'package:flutter/material.dart';
import 'package:app_project/navigation_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_project/screen/loading_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:app_project/firebase_options.dart';
import 'package:app_project/model/model_auth.dart';
import 'package:app_project/model/model_login.dart';

import 'model/model_page_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
        ChangeNotifierProvider(
            create: (_) => PageProvider(),
        ),

        ChangeNotifierProvider<FirebaseAuthProvider>(
          create: (_) => FirebaseAuthProvider(),
        ),

        ChangeNotifierProvider<LoginModel>(
          create: (_) => LoginModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/loading',
      routes: {
        '/': (context) => RootScreen(),
        '/loading': (context) => LoadingScreen(),
      },
    );
  }
}
