// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:books/providers/user_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_sumarry_screen.dart';

enum AddressType { home, office, other }

class UserDetailScreen extends StatefulWidget {
  UserDetailScreen({Key? key}) : super(key: key);

  static const namedRoute = '/userDetailScreen';

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  AddressType _character = AddressType.home;

  var nameCOntroller = TextEditingController();

  var phoneController = TextEditingController();

  var pincontroller = TextEditingController();

  var locationcontroller = TextEditingController();

  var discriptionController = TextEditingController();

  var cityController = TextEditingController();

  var landmarkController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    nameCOntroller.dispose();
    phoneController.dispose();
    pincontroller.dispose();
    cityController.dispose();
    discriptionController.dispose();
    locationcontroller.dispose();
    landmarkController.dispose();
  }

  // late UserProvider userProvider;
  bool isEddited = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // userProvider = Provider.of<UserProvider>(context);
  }

  late UserProvider userProvider;
  @override
  void initState() {
    // TODO: implement initState
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.initState();

    getDataFromFireBace();
  }

  bool editButtonstate = false;
  editButtonTogglr() {
    setState(() {
      ;
    });
  }

  late User userData;
  getDataFromFireBace() async {
    log("73");
    log(userProvider.testdATA);
    userData = (await userProvider.getuser())!;
    if (userData != null) {
      log(userData.name + "dakbjfffffffffffffffffffffffffffffffffff");
      setState(() {
        editButtonstate = true;
      });
      setUp();
    }
  }

  setUp() {
    log("insetup functio");
    log(userData.phoneNumber);
    nameCOntroller.text = userData.name;
    phoneController.text = userData.phoneNumber;
    landmarkController.text = userData.landmark;
    locationcontroller.text = userData.location;
    discriptionController.text = userData.discription;
    pincontroller.text = userData.phoneNumber;
    cityController.text = userData.city;
    // log(message)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("please fill your details"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Coustomer Details",
                      style: TextStyle(fontSize: 20),
                    ),
                    Visibility(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isEddited = true;
                          });
                        },

                        ///add function nality
                        child: const Text(
                          "Edit",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      visible: editButtonstate, ////Add visibility
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  focusNode: FocusNode(),
                  enabled: isEddited,
                  maxLines: 1,
                  controller: nameCOntroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'name',
                    labelText: 'First Name',
                  ),
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return "Reuied of 3 charaters at least";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  focusNode: FocusNode(),
                  enabled: isEddited,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a phone number',
                    labelText: 'Phone',
                  ),
                  validator: (value) {
                    if (value == null || value.length != 10) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  focusNode: FocusNode(),
                  enabled: isEddited,
                  controller: pincontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '0000000',
                    labelText: 'PinCode',
                  ),
                  validator: (value) {
                    if (value == null || value.length <= 3) {
                      return 'required minimum of 3 charters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  focusNode: FocusNode(),
                  enabled: isEddited,
                  controller: locationcontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),

                    hintText: 'location',
                    labelText: 'location',
                    // labelText: '',
                  ),
                  validator: (value) {
                    if (value == null || value.length <= 2) {
                      return 'Please atleast 2   carectes';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  focusNode: FocusNode(),
                  enabled: isEddited,
                  keyboardType: TextInputType.multiline,
                  controller: discriptionController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Decraption',
                      labelText: "Decraption"),
                  validator: (value) {
                    if (value == null || value.length < 4) {
                      return 'Please enter atleast 4 charectors';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  focusNode: FocusNode(),
                  enabled: isEddited,
                  keyboardType: TextInputType.multiline,
                  controller: cityController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'city',
                      labelText: "CIty"),
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return 'Please enter valid date';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  focusNode: FocusNode(),
                  enabled: isEddited,
                  keyboardType: TextInputType.multiline,
                  controller: landmarkController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'landmark',
                      labelText: "Landmark"),
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return 'Please enter valid date';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("address type"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GridTile(
                      child: Row(
                        children: [
                          Radio<AddressType>(
                            value: AddressType.home,
                            groupValue: _character,
                            onChanged: (AddressType? value) {
                              setState(() {
                                _character = value!;
                              });
                            },
                          ),
                          const Text("Home")
                        ],
                      ),
                    ),
                    GridTile(
                      child: Row(
                        children: [
                          Radio<AddressType>(
                            value: AddressType.office,
                            groupValue: _character,
                            onChanged: (AddressType? value) {
                              setState(() {
                                _character = value!;
                              });
                            },
                          ),
                          const Text("Ofice")
                        ],
                      ),
                    ),
                    GridTile(
                      child: Row(
                        children: [
                          Radio<AddressType>(
                            value: AddressType.other,
                            groupValue: _character,
                            onChanged: (AddressType? value) {
                              setState(() {
                                _character = value!;
                              });
                            },
                          ),
                          const Text("Other")
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: FlatButton(
                        minWidth: 350,
                        color: Colors.blue,
                        child: const Text('Submit'),
                        onPressed: () async {
                          final FormState? form = _formKey.currentState;
                          if (form!.validate()) {
                            log("form.validate");

                            await userProvider.addUser(
                              User(
                                  name: nameCOntroller.text,
                                  phoneNumber: phoneController.text,
                                  pinCode: pincontroller.text,
                                  location: locationcontroller.text,
                                  city: cityController.text,
                                  landmark: landmarkController.text,
                                  discription: discriptionController.text,
                                  locationType: _character.name),
                            );
                            Navigator.pushNamed(
                                context, OrderSumary.namedRoute);
                          } else {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                content: phoneController.text.length < 10
                                    ? const Text("ple add correctNumber")
                                    : const Text('please add Allthe felds'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
