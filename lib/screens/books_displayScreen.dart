import 'dart:developer';

import 'package:books/screens/seash_Screen.dart';
import 'package:books/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/productprovider.dart';
import '../thems.dart';
import '../widgets/bandage.dart';
import '../widgets/grid_view.dart';
import 'cart._screen.dart';

class BooksDisplayScreen extends StatefulWidget {
  BooksDisplayScreen({Key? key}) : super(key: key);
  static const routName = '/booksdisplayScreen';

  @override
  State<BooksDisplayScreen> createState() => _BooksDisplayScreenState();
}

class _BooksDisplayScreenState extends State<BooksDisplayScreen> {
  String dropdownValue = 'Price :Low to high';

  @override
  void didChangeDependencies() {
    Provider.of<ProductProviders>(context).getAllBooks();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var book = Provider.of<ProductProviders>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        leading: const Center(
          child: Text(
            "Books",
            textAlign: TextAlign.center,
          ),
        ),
        title: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchSceen()));
            },
            child: Container(
              padding: EdgeInsets.only(top: 4, left: 4),
              width: 400,
              height: 30,
              color: Colors.white,
              child: Row(
                children: const [
                  Icon(
                    Icons.search,
                    // semanticLabel: "Search",
                    color: Colors.black,
                  ),
                  Text(
                    "Search",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.black26, fontSize: 16),
                  ),
                ],
              ),
            )),
        actions: [
          Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(CartScreen.namedRoute);
                      },
                      icon: const Icon(Icons.shopping_cart)),
                  value: cart.itemCount.toString(),
                  color: Colors.white))
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Books :",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "${book.items.length}",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const Spacer(),
              DropdownButton(
                value: dropdownValue,
                items: <String>['Price :Low to high', 'price: high to low']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  log(newValue.toString());
                  setState(() {
                    book.changeoRDER(newValue.toString());
                    dropdownValue = newValue.toString();
                  });
                },
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(child: ProductGridView()),
        ],
      ),
      // ],
    );
    // );
  }
}
