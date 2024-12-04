import 'dart:ffi';

import 'package:CheckIt/Controllers/UserController.dart';
import 'package:CheckIt/Screens/LoginScreen.dart';
import 'package:CheckIt/Widgets/CompanyButton.dart';
import 'package:CheckIt/Widgets/MyButton.dart';
import 'package:CheckIt/Widgets/Space.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  UserController userController = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  DateTime? selectedDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), // Customize the calendar theme here
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        birthdayController.text = _dateFormat.format(selectedDate!);
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    birthdayController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Map<String, dynamic> prepareData() {
    return {
      "name": fullNameController.text,
      "birthDay": selectedDate,
      "phoneNumber": phoneNumberController.text,
      "address": addressController.text,
    };
  }

  void handleRegisterWithPassword() {
    var data = prepareData();
    userController.createUserWithEmailAndPassword(
        emailController.text, passwordController.text, data);
  }

  void handleRegisterGoogle() {
    var data = prepareData();
    userController.signInWithGoogle(data);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          color: Color(0xff273B69),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/logo.svg",
                  height: 64,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    IconButton(
                        iconSize: 40,
                        color: Colors.white,
                        onPressed: () => Get.offNamed('/login'),
                        icon: const Icon(Icons.arrow_back)),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: Container(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 234, 237, 1),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 32,
                          ),
                          Center(
                            child: Text(
                              "הרשמה",
                              style: TextStyle(
                                color: Color.fromRGBO(18, 18, 18, 1),
                                fontSize: 32,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            width: 380,
                            height: 40,
                            child: TextField(
                              controller: emailController,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                labelText: 'אימייל',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 380,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                labelText: 'סיסמא',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 380,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: TextField(
                              controller: fullNameController,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                labelText: 'שם מלא',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 380,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: TextField(
                              controller: birthdayController,
                              readOnly: true,
                              onTap: () {
                                _selectDate(context);
                              },
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                labelText: 'יום הולדת',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 380,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: TextField(
                              controller: phoneNumberController,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                labelText: 'מספר טלפון',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 380,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: TextField(
                              controller: addressController,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                labelText: 'כתובת',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          MyButton(
                            title: 'הירשם',
                            onTap: handleRegisterWithPassword,
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
