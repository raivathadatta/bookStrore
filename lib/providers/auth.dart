import 'dart:developer';

import 'package:books/screens/auth_screen.dart';
import 'package:books/screens/books_displayScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:fluttertoast/fluttertoast.dart';

class Auth with ChangeNotifier {
  late UserCredential userCredentia;

  bool otpVisibility = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationID = "";
  final storage = const FlutterSecureStorage();
  void loginWithPhone(
    String phoneNUmber,
  ) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: "+91" + phoneNUmber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) {
            log("You are logged in successfully");
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          log(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          log("codeSent");
          otpVisibility = true;
          notifyListeners();
          verificationID = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      log(e.toString());
    }

    log("bye");
  }

  Future<void> verifyOTP(String otpNUmber, BuildContext context) async {
    AuthCredential userCredential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpNUmber);

    userCredentia = await auth.signInWithCredential(userCredential);

    Fluttertoast.showToast(
      msg: "You are logged in successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // await FlutterSession().set("key", "user");

    log(userCredentia.user!.uid + "At 66");
    await storage.write(key: 'uid', value: userCredentia.user!.uid.toString());
    storeTokenAndData(userCredentia);
    Navigator.pushReplacementNamed(context, BooksDisplayScreen.routName);
  }

  logOut(BuildContext context) async {
    log("signout");
    try {
      storage.delete(key: 'uid');
      await auth.signOut();
      Navigator.pushReplacementNamed(context, AuthScreen.namedRoute);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  void storeTokenAndData(UserCredential? userCredential) async {
    print("storing token and data");
    await storage.write(key: "token", value: userCredential.toString());
    //   await storage.write(
    //       key: "usercredential", value: userCredential.toString());
  }

  Future<String?> getToken() async {
    log("in token");
    log(await storage.read(key: "token").toString() + "jjjjjjj");
    return await storage.read(key: "token");
  }
}
