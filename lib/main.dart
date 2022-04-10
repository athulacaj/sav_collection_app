import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/admin_data_provider.dart';
import 'providers/itemDetailsProvider.dart';
import 'providers/user_login_provider.dart';
import 'screens/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'screens/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ItemDetailsProvider()),
      ChangeNotifierProvider(create: (context) => UserLoginProvider()),
      ChangeNotifierProvider(create: (context) => AdminDataProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sales App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashScreenWindow.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          SplashScreenWindow.id: (context) => SplashScreenWindow(),
        });
  }
}
