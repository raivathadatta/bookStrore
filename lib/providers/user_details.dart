import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User {
  final String name;
  final String phoneNumber;
  final String pinCode;
  final String location;
  final String city;
  final String landmark;
  final String discription;
  final String locationType;

  User(
      {required this.name,
      required this.phoneNumber,
      required this.pinCode,
      required this.location,
      required this.city,
      required this.landmark,
      required this.discription,
      required this.locationType});
}

class UserProvider with ChangeNotifier {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  late DocumentSnapshot? lastDocument;
  final storage = const FlutterSecureStorage();

  String testdATA = " hAI SDGFNSDFNSDIFNSDIFNSDIFNDSIUFNSDIUFNSIUFNSIDUFNIUHN";

  get userIdf => FirebaseAuth.instance.currentUser?.uid;
  Future<void> addUser(User user) async {
    await storage.read(key: 'uid');
    try {
      log("starterds");
      final Map<String, dynamic> newUser = {
        userId: userIdf,
        userName: user.name,
        userNumber: user.phoneNumber,
        userCity: user.city,
        userLandMark: user.landmark,
        userPinCode: user.pinCode,
        userLocation: user.location,
        userDiscription: user.discription,
        userLocationType: user.locationType,
      };

      await users.doc(userIdf).set(newUser).then((value) => log(" Succfull"));
    } catch (e) {
      log(e.toString() + "at 51 ");
    }
  }

  Future<User?> getuser() async {
    try {
      final snapShot = await users.doc(userIdf).get();
      log(snapShot.toString() + " at 71 ");
      final newUser = User(
          name: snapShot[userName],
          phoneNumber: snapShot[userNumber],
          pinCode: snapShot[userNumber],
          location: snapShot[userPinCode],
          city: snapShot[userCity],
          landmark: snapShot[userLandMark],
          discription: snapShot[userDiscription],
          locationType: snapShot[userLocationType]);

      // newUser.
      log(snapShot.toString() + " at 71 ");
      log(newUser.name.toString() + "sflbfoigjsoignsonfosdnfosdnf");
      return newUser;
    } catch (error) {
      log(error.toString());
      return null;
    }
  }
}

const userName = 'name';
const userNumber = 'number';
const userCity = 'city';
const userLocation = 'location';
const userPinCode = 'pinCode';
const userLandMark = 'landmark';
const userDiscription = 'discription';
const userLocationType = 'locationType';
const userId = 'userid';
