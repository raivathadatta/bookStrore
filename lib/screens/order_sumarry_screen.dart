import 'package:books/providers/cart.dart';
import 'package:books/providers/user_details.dart';
import 'package:books/screens/books_displayScreen.dart';
import 'package:books/thems.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'final_screen.dart';

class OrderSumary extends StatelessWidget {
  static const namedRoute = "/orderScreen";

  const OrderSumary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appbarColor,
          title: const Text("Order Samary"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, BooksDisplayScreen.routName);
                },
                icon: const Icon(Icons.home))
          ],
        ),
        body: Column(children: [
          Flexible(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: ((context, index) {
                return Card(
                  child: Row(
                    children: [
                      SizedBox(
                          height: 100,
                          width: 80,
                          child: Image.network(cart.getOrderItem()!.imageUrl)),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(cart.getOrderItem()!.title),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(cart.getOrderItem()!.auther),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                              "price: Rs:${cart.getOrderItem()!.price.toString()}"),
                          // Text("price: Rs:${cart.getOrderItem().toString()}"),
                        ],
                      ),
                      const Spacer(),
                      // Text("${cart.totalPrice.toString()}")

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("quantity:-${cart.getOrderItem()!.quantiy}"),
                          const Text("total :"),
                          Text(
                              "${cart.getOrderItem()!.quantiy} * ${cart.getOrderItem()!.price}"),
                          Text("total:Rs${cart.getOrderItem()!.totla}"),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          FlatButton(
            minWidth: 350,
            color: Colors.blue,
            onPressed: () {
              // cart.addItms();
              Navigator.pushNamed(context, FinalScreen.namedRoute);
            },
            child: const Text("placeOrder"),
          )
        ]));
  }
}
