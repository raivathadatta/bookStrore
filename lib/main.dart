import 'dart:developer';

import 'package:books/providers/auth.dart';
import 'package:books/providers/cart.dart';
import 'package:books/providers/productprovider.dart';
import 'package:books/providers/user_details.dart';
import 'package:books/screens/auth_screen.dart';
import 'package:books/screens/book_detail_screen.dart';
import 'package:books/screens/books_displayScreen.dart';
import 'package:books/screens/cart._screen.dart';
import 'package:books/screens/final_screen.dart';
import 'package:books/screens/order_sumarry_screen.dart';
import 'package:books/screens/user_detail_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();

    Future<bool> checkUser() async {
      String? validate = await storage.read(key: 'uid');
      if (validate == null) {
        return false;
      }
      return true;
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => ProductProviders()),
        ChangeNotifierProvider(
          create: ((context) => UserProvider()),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: checkUser(),
          builder: (context, snapshot) {
            if (snapshot.data == false) {
              return AuthScreen();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return BooksDisplayScreen();
            }
          },
        ),

        // home: BooksDisplayScreen(),
        routes: {
          BooksDisplayScreen.routName: (context) => BooksDisplayScreen(),
          BookOverViewScreen.namedRoute: ((context) => BookOverViewScreen()),
          CartScreen.namedRoute: ((context) => CartScreen()),
          UserDetailScreen.namedRoute: ((context) => UserDetailScreen()),
          AuthScreen.namedRoute: (context) => AuthScreen(),
          OrderSumary.namedRoute: ((context) => OrderSumary()),
          FinalScreen.namedRoute: (context) => const FinalScreen(),
          // cartsc
        },
      ),
    );
  }
}
