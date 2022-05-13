import 'package:books/providers/productprovider.dart';
import 'package:books/screens/cart._screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class BookOverViewScreen extends StatelessWidget {
  BookOverViewScreen({Key? key}) : super(key: key);
  static const namedRoute = '/bookovervirewScreen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final args = ModalRoute.of(context)!.settings.arguments;
    final book = Provider.of<ProductProviders>(context)
        .getBookById(args.toString()); //add arguments
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.grey,
              expandedHeight: 400,
              // pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  book.title,
                  style: const TextStyle(color: Colors.black),
                ),
                background: Hero(
                  tag: book.id,
                  child: Image.network(
                    book.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 10,
                // child:
              ),
              Text(
                'price \$:${book.price}',
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Auther :${book.author}",
                    softWrap: true,
                    textAlign: TextAlign.start,
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(1),
                margin: const EdgeInsets.all(20),
                // height: 40,
                color: Colors.blue,
                // width: 15,
                child: FlatButton(
                  onPressed: () {
                    if (!cart.items.keys.contains(book.id)) {
                      cart.addItms(book.id, double.parse(book.price),
                          book.title, book.imageUrl, book.author);
                    }
                    Navigator.pushNamed(context, CartScreen.namedRoute);
                  },
                  child: const Text("Add to Cart"),
                ),
              ),
            ])),
          ],
        ),
      ),
    );
  }
}
