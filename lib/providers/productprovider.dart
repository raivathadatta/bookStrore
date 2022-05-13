import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'product.dart';

class ProductProviders with ChangeNotifier {
  final List<Map<String, String>> _productList = [
    {
      "id": "1",
      "image": "https://picsum.photos/250?image=9",
      "title": "Building Planning",
      "author": "S. S. Bhavikatti",
      "price": "1400"
    },
    {
      "id": "2",
      "image": "https://picsum.photos/250?image=9",
      "title": "Civil Engineering",
      "author": "S. P. Gupta",
      "price": "1200"
    },
    {
      "id": "3",
      "image": "https://picsum.photos/250?image=9",
      "title": "Surveying",
      "author": "S. K. Duggal",
      "price": "1000"
    },
    {
      "id": "4",
      "image": "https://picsum.photos/250?image=9",
      "title": "Stephen King",
      "author": "Rumaysa Ahmed",
      "price": "300"
    },
    {
      "id": "5",
      "image": "https://picsum.photos/250?image=9",
      "title": "Rising hear",
      "author": "Perumal",
      "price": "400"
    },
    {
      "id": "6",
      "image": "https://picsum.photos/250?image=9",
      "title": "Just like you",
      "author": "Nick Hornby",
      "price": "500"
    },
    {
      "id": "7",
      "image": "https://picsum.photos/250?image=9",
      "title": "Richest man",
      "author": "George S. Clason",
      "price": "600"
    },
    {
      "id": "8",
      "image": "https://picsum.photos/250?image=9",
      "title": "Success Story",
      "author": "Vijay K.",
      "price": "650"
    },
    {
      "id": "9",
      "image": "https://picsum.photos/250?image=9",
      "title": "Chinese Communist",
      "author": "Handry",
      "price": "200"
    },
    {
      "id": "10",
      "image": "https://picsum.photos/250?image=9",
      "title": "Think like a Rocket",
      "author": "Panik H.",
      "price": "800"
    },
    {
      "id": "11",
      "image": "https://picsum.photos/250?image=9",
      "title": "How to speak",
      "author": "Ron Malhotra",
      "price": "850"
    },
    {
      "id": "12",
      "image": "https://picsum.photos/250?image=9",
      "title": "Wining like Sourav",
      "author": "Abhirup B.",
      "price": "880"
    },
    {
      "id": "13",
      "image": "https://picsum.photos/250?image=9",
      "title": "Oxfort Avanced",
      "author": "Ajit J.",
      "price": "1100"
    },
    {
      "id": "14",
      "image": "https://picsum.photos/250?image=9",
      "title": "Tip of the Iceberg",
      "author": "Suveen Sinha",
      "price": "690"
    },
    {
      "id": "15",
      "image": "https://picsum.photos/250?image=9",
      "title": "How to read a book",
      "author": "Nortimer J. Adler",
      "price": "780"
    },
    {
      "id": "16",
      "image": "https://picsum.photos/250?image=9",
      "title": "Winning Sachin",
      "author": "Devendra P.",
      "price": "450"
    }
  ];
  List<Book> _items = [];

  var showFavorite = false;

  bool _toggle = false;
  tougleitems() {
    log("items reversed");
    _items.sort(((b, a) {
      return int.parse(a.price).compareTo(int.parse(b.price));
    }));
    log(_items[1].price + "slknfglsknflksdnflksadnflksdnflknadlfknsdkfnk");
    notifyListeners();
  }

  String changevalue = 'Price :Low to high';

  void changeoRDER(String value) {
    changevalue = value;
  }

  get items {
    getAllBooks();
    if (changevalue == 'Price :Low to high') {
      _items.sort(((a, b) {
        return int.parse(a.price).compareTo(int.parse(b.price));
      }));
    } else {
      _items.sort(((b, a) {
        return int.parse(a.price).compareTo(int.parse(b.price));
      }));
    }
    return _items;
  }

  getAllBooks() async {
    log("inline 140 product providers");
    _items = _productList.map((book) => Book.fromJson(book)).toList();
  }

  Future fetchAndSetProduct() async {}

  Book getBookById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  List<Book> getSearchBooks(String searchVarible) {
    List<Book> searchingBooks = [];

    _items.forEach((element) {
      if (element.author.toLowerCase().contains(searchVarible.toLowerCase()) ||
          element.title.toLowerCase().contains(searchVarible.toLowerCase())) {
        searchingBooks.add(element);
      }
    });

    return searchingBooks;
  }

  get sortByLowTOhigh {
    return _items.sort(((a, b) {
      return int.parse(a.price).compareTo(int.parse(b.price));
    }));
  }
}
