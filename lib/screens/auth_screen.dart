import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/auth.dart';

class AuthScreen extends StatefulWidget {
  static const namedRoute = '/authScreen';
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final otpController = TextEditingController();

  final phoneController = TextEditingController();

  // bool otpVisibility = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("AuthScreen"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('+91'),
                  ),
                ),
                maxLength: 10,
                keyboardType: TextInputType.phone,
              ),
              Visibility(
                child: TextField(
                  controller: otpController,
                  decoration: const InputDecoration(
                    hintText: 'OTP',
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(''),
                    ),
                  ),
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                ),
                visible: provider.otpVisibility,
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                color: Colors.indigo[900],
                onPressed: () {
                  if (provider.otpVisibility) {
                    provider.verifyOTP(otpController.text, context);
                  } else {
                    provider.loginWithPhone(phoneController.text);
                  }
                },
                child: Text(
                  provider.otpVisibility ? "Verify" : "Login",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
