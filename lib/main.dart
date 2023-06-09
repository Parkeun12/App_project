import 'package:flutter/material.dart';
import 'package:app_project/navigation_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_project/screen/loading_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:app_project/firebase_options.dart';
import 'package:app_project/model/model_auth.dart';
import 'package:app_project/model/model_login.dart';
import 'package:app_project/model/model_query.dart';
import 'package:app_project/screen/search_screen.dart';
import 'package:app_project/database/drift_database.dart';
import 'package:get_it/get_it.dart';

import 'model/model_page_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting();

  final database = LocalDatabase();

  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<QueryProvider>(
          create: (_) => QueryProvider(),
        ),
        ChangeNotifierProvider<FirebaseAuthProvider>(
          create: (_) => FirebaseAuthProvider(),
        ),
        ChangeNotifierProvider<LoginModel>(
          create: (_) => LoginModel(),
        ),
        ChangeNotifierProvider<PageProvider>(
          create: (_) => PageProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'App Project',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/loading',
        routes: {
          '/': (context) => RootScreen(),
          '/search': (context) => SearchScreen(number: 1),
          '/loading': (context) => LoadingScreen(),
        },
      ),
    );
  }
}
