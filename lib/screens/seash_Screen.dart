import 'dart:developer';

import 'package:books/providers/productprovider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../widgets/productItem.dart';
import 'book_detail_screen.dart';

class SearchSceen extends StatefulWidget {
  const SearchSceen({Key? key}) : super(key: key);

  @override
  State<SearchSceen> createState() => _SearchSceenState();
}

class _SearchSceenState extends State<SearchSceen> {
  List<Book> searchResultBooks = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }
  

  late Cart cart;
  getExample() {
    cart = Provider.of<Cart>(context);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    // final cart = Provider.of<Cart>(context);
    final product = Provider.of<ProductProviders>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_outlined),
                  color: Colors.black,
                ),
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Search Your Books",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    onChanged: (value) {
                      log(value + "at 64");
                      searchResultBooks = [];
                      if (value != "") {
                        searchResultBooks = product
                            .getSearchBooks(value.toString().toLowerCase());

                        log(searchResultBooks.length.toString());
                      }
                      setState(() {});
                      // log(value);
                    },
                  ),
                ),
              ],
            ),
//
            Flexible(
              child: GridView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(2.0),
                itemCount: searchResultBooks.length,
                itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                  value: searchResultBooks[index],
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  BookOverViewScreen.namedRoute,
                                  arguments: searchResultBooks[index].id);
                            },
                            child: Hero(
                              tag: searchResultBooks[index].id,
                              child: SizedBox(
                                  height: 135,
                                  child: Image.network(
                                      searchResultBooks[index].imageUrl)),
                            )),
                        const SizedBox(height: 2),
                        Text(
                          searchResultBooks[index].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.brown, fontSize: 17),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            searchResultBooks[index].author,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.brown, fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            " \$:${searchResultBooks[index].price}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.brown, fontSize: 12),
                          ),
                        ),
                        searchResultBooks[index].isWatchListed
                            ? Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                alignment: Alignment.center,
                                height: 40,
                                child: const Text(
                                  " WatchList ",
                                ),
                              )
                            : searchResultBooks[index].isAddedToCart
                                ? Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Color.fromARGB(39, 53, 87, 222),
                                    ),
                                    alignment: Alignment.center,
                                    height: 40,
                                    child: const Text(
                                      " Add to Cart",
                                    ),
                                  )
                                : ButtonBar(
                                    children: <Widget>[
                                      RaisedButton(
                                        color: Color.fromARGB(236, 212, 53, 64),
                                        child: const Text('Add'),
                                        onPressed: () {
                                          searchResultBooks[index]
                                              .toggleaddedCart();
                                          cart.addItms(
                                              searchResultBooks[index].id,
                                              double.parse(
                                                  searchResultBooks[index]
                                                      .price),
                                              searchResultBooks[index].title,
                                              searchResultBooks[index].imageUrl,
                                              searchResultBooks[index].author);
                                        },
                                      ),
                                      RaisedButton(
                                        child: const Text('watchlist'),
                                        onPressed: () {
                                          log("hello");
                                          searchResultBooks[index]
                                              .toggleFavorite();
                                        },
                                      ),
                                    ],
                                  ),
                      ],
                    ),
                  ),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // mainAxisExtent: 0.2,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 4),
              ),
            ),
          ],

          // Fle
        ),
      ),
    );
  }
}
