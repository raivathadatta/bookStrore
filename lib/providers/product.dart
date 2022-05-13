// ignore_for_file: unused_element

import 'dart:developer';

import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;

class Book with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final String price;
  final String description;
  final String author;
  bool isAddedToCart;
  bool isWatchListed;

  Book({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.author,
    this.isAddedToCart = false,
    this.isWatchListed = false,
  });

  void _setValue(bool newState) {
    isAddedToCart = newState;
    notifyListeners();
  }

  Future<void> toggleaddedCart() async {
    // var oldStatus = isAddedToCart;
    log("iiii");
    isAddedToCart = !isAddedToCart;
    log(isAddedToCart.toString());
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    // var oldStatus = isWatchListed;
    isWatchListed = !isWatchListed;
    notifyListeners();
  }

  static Book fromJson(Map<String, Object?> book) {
    log("in from json"); //////////////////////////////////////////
    return Book(
      id: book[idFeld] as String,
      author: book[auther] as String,
      title: book[bookTitle] as String,
      imageUrl: book[bookImage] as String,
      price: book[bookPrice] as String,
      description: '',
    );
    // log("at 46 in products");
  }
}

const bookTitle = "title";
const idFeld = "id";
const auther = "author";
const bookPrice = "price";
const bookImage = "image";
