import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Cart with ChangeNotifier {
  Map<String, CartItems> _items = {};
  void addorderItem(CartItems cartItems) {
    _cartItems = cartItems;
    log(_cartItems.quantiy.toString() +
        "sdkgbjjjjjjjjjjjjjjjbiuvdssssssdgsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
    notifyListeners();
  }

  Map<String, CartItems> _orderitem = {};
  // final storage = FlutterSecureStorage();
  var userIdf = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Map<String, CartItems> get items {
    return {..._items};
  }

  int get itemCount {
    log(_items.length.toString());
    return _items.length;
  }

  // double get totalPrice {
  //   // var total = 0.0;

  //   // return _cartItems.totla;
  // }

  Future<void> addItms(
    String productId,
    double price,
    String title,
    String imageUrl,
    String auther,
  ) async {
    //add for adding more items
    if (_items.containsKey(productId)) {
      // int tempQuantity =
      _items.update(
          productId,
          (existingItem) => CartItems(
              id: productId,
              title: title,
              price: price,
              quantiy: existingItem.quantiy + 1,
              imageUrl: existingItem.imageUrl,
              auther: auther,
              totla: existingItem.price * (existingItem.quantiy + 1)));
      notifyListeners();
      log(_items[productId]!.totla.toString());
      log("updated Succfully");
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItems(
              id: productId,
              title: title,
              price: price,
              quantiy: 1,
              imageUrl: imageUrl,
              auther: auther,
              totla: price));
    }
    notifyListeners();
  }

//remove items
  Future<void> removeSingeItem(String productId) async {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantiy > 1) {
      _items.update(
        productId,
        (exeistingCartItem) => CartItems(
            id: exeistingCartItem.id,
            title: exeistingCartItem.title,
            price: exeistingCartItem.price,
            quantiy: exeistingCartItem.quantiy - 1,
            imageUrl: exeistingCartItem.imageUrl,
            auther: exeistingCartItem.auther,
            totla: exeistingCartItem.price * (exeistingCartItem.quantiy - 1)),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  empltyCart() {
    _items = {};
    notifyListeners();
  }

  CartItems _cartItems = CartItems(
      id: "",
      title: "",
      price: 0,
      quantiy: 1,
      imageUrl: imageUrl,
      auther: auther,
      totla: 0);

  CartItems? getOrderItem() {
    log(_cartItems.quantiy.toString() +
        "sdkgbjjjjjjjjjjjjjjjbiuvdsssssssssssss");
    if (_cartItems.quantiy > 0) {
      log(_cartItems.totla.toString());
      return _cartItems;
    } else
      return null;
  }

  onPlaceordewr() async {
    var doc = users.doc(userIdf).collection("cart").doc();

    final newNoteset = {
      cartid: _cartItems.id,
      title: _cartItems.title,
      prise: _cartItems.price,
      auther: _cartItems.auther,
      imageUrl: _cartItems.imageUrl,
      quantity: _cartItems.quantiy,
      totalAmout: _cartItems.totla,
    };

    await doc.set(newNoteset);

    log("data add succfulluy");
  }
}

class CartItems {
  final String id;
  final String title;
  final double price;
  final int quantiy;
  final String imageUrl;
  final String auther;
  final double totla;

  CartItems({
    required this.id,
    required this.title,
    required this.price,
    required this.quantiy,
    required this.imageUrl,
    required this.auther,
    required this.totla,
  });

  // int get quantity {
  //   // ignore: recursive_getters
  //   return quantity;
  // }
}

const quantity = 'quantity';
const auther = 'auther';
const prise = 'prise';
const productId = 'productId';

const cartid = 'id';
const title = 'title';
// const price = 'price';
const cartquantiy = 'quantity';
const imageUrl = 'imageUrl';
const totalAmout = 'totalprice';
