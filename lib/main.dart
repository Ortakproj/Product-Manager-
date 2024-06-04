import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:product_manager/View/screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD2otFQ3T_Eu6LQAW1kBGEh6ML0vDzK7as",
      appId: "1:87184472525:android:43d1bc663dd48d1173ec84",
      messagingSenderId: "87184472525",
      projectId: "product-manager-b5b96",
    ),
  )
  :await Firebase.initializeApp();
/*
  await Firebase.initializeApp(
      name: 'product-manager-b5b96',
      options: const FirebaseOptions(
        apiKey: "AIzaSyD2otFQ3T_Eu6LQAW1kBGEh6ML0vDzK7as",
        appId: "1:87184472525:android:43d1bc663dd48d1173ec84",
        messagingSenderId: "87184472525",
        authDomain: "product-manager-b5b96.firebaseapp.com",
        projectId: "product-manager-b5b96",
        databaseURL: 'https://product-manager-b5b96.firebaseio.com',
        storageBucket: 'gs://product-manager-b5b96.appspot.com',
        // measurementId: 'G-VF5Z5GWN64',
      ));
*/
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar', 'AR'),
        startLocale: const Locale('ar', 'AR'),
        useOnlyLangCode: true,
        saveLocale: true,
        child: const MyApp()),
     
      /*  supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: const Locale('en', 'US'),
      useOnlyLangCode: true,
      saveLocale: true,
      child: const MyApp()), */
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Manager',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        // primarySwatch: Colors.grey,
        // brightness: Brightness.dark,
        unselectedWidgetColor: const Color(0xFF333333),
        primaryColor: const Color(0xFFffffff),
        primaryColorDark: const Color(0xFF813892),
        primaryColorLight: const Color(0xFFC7C7C6),
        indicatorColor: const Color(0xFF333333),
        highlightColor: const Color(0xFFffffff),
        // dialogBackgroundColor: const Color(0xFFf9f9f9),
        cardColor: const Color(0xFFfbfbfb),
        scaffoldBackgroundColor: const Color(0xFFffffff),
        splashColor: const Color(0xFFffffff),
        tabBarTheme: const TabBarTheme(
            labelColor: Color(0xFF813892),
            labelStyle: TextStyle(color: Color(0xFF813892)), // color for text
            indicator: UnderlineTabIndicator(
              // color for indicator (underline)
                borderSide: BorderSide(color: Color(0xFF813892)))),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(0xFF813892), circularTrackColor: Color(0xFFC7C7C6)),
      ),
      home:  const SignInScreen(),
    );
  }
}

