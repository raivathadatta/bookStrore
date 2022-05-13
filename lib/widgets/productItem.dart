import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/book_detail_screen.dart';

class ProductItem extends StatefulWidget {
  ProductItem({Key? key}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Book>(context);
    final cart = Provider.of<Cart>(context, listen: false);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(BookOverViewScreen.namedRoute,
                    arguments: product.id);
              },
              child: Hero(
                tag: product.id,
                child: Container(
                    margin: const EdgeInsets.only(
                      left: 15,
                    ),
                    height: 135,
                    child: Image.network(product.imageUrl)),
              )),
          const SizedBox(height: 2),
          Text(
            product.title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontSize: 17),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              product.author,
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              " price:${product.price}",
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
          product.isWatchListed
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(0, 43, 107, 171),
                    border: Border.all(color: Colors.black),
                  ),
                  alignment: Alignment.center,
                  height: 40,
                  child: const Text(
                    " WatchList ",
                  ),
                )
              : product.isAddedToCart
                  ? Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: const Color.fromARGB(255, 211, 87, 49)),
                      alignment: Alignment.center,
                      height: 40,
                      child: const Text(
                        " Add to Cart",
                      ),
                    )
                  : ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          color: Color.fromARGB(255, 211, 87, 49),
                          child: const Text('Add'),
                          onPressed: () {
                            product.toggleaddedCart();
                            cart.addItms(
                                product.id,
                                double.parse(product.price),
                                product.title,
                                product.imageUrl,
                                product.author);
                          },
                        ),
                        RaisedButton(
                          child: const Text('watchlist'),
                          onPressed: () {
                            product.toggleFavorite();
                          },
                        ),
                      ],
                    ),
        ],
      ),
    );

    //
  }
}
