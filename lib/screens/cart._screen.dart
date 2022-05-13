import 'package:books/providers/cart.dart';
import 'package:books/screens/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const namedRoute = '/cartScreen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            height: 80,
                            width: 40,
                            child: Image.network(
                                cart.items.values.toList()[index].imageUrl)),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cart.items.values.toList()[index].title),
                            Text(cart.items.values.toList()[index].auther),
                            Text(cart.items.values
                                .toList()[index]
                                .price
                                .toString()),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                cart.addItms(
                                    cart.items.values.toList()[index].id,
                                    cart.items.values.toList()[index].price,
                                    cart.items.values.toList()[index].title,
                                    cart.items.values.toList()[index].imageUrl,
                                    cart.items.values.toList()[index].auther);
                              },
                            ),
                            Text(
                                "${cart.items.values.toList()[index].quantiy}"),
                            IconButton(
                                onPressed: () {
                                  cart.removeSingeItem(
                                      cart.items.values.toList()[index].id);
                                },
                                icon: const Icon(Icons.remove)),
                            FlatButton(
                              minWidth: 10,
                              color: Colors.blue,
                              onPressed: () {
                                cart.addorderItem(
                                    cart.items.values.toList()[index]);
                                Navigator.pushNamed(
                                    context, UserDetailScreen.namedRoute);
                              },
                              child: const Text("Order"),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
