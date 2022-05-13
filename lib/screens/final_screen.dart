import 'package:books/screens/books_displayScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class FinalScreen extends StatelessWidget {
  static const namedRoute = '/finalScreeen';

  const FinalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Order is placed Succfully",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const Text(
            "hurrry!! your Order is conformed",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          ),
          const Text(
            "the order id is safe the order id for futher communication", ////ADD order id
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          FlatButton(
              color: Colors.blue,
              onPressed: () {
                cart.empltyCart();
                Navigator.pushReplacementNamed(
                    context, BooksDisplayScreen.routName);
              },
              child: Text("Continue Shoping"))
        ],
      ))),
    );
  }
}
