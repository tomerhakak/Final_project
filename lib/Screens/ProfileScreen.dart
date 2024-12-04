import 'package:CheckIt/Widgets/TopBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controllers/UserController.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => __ProfileScreenState();
}

class __ProfileScreenState extends State<ProfileScreen> {
  UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xff273B69),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TopBar(showProfileIcon: false, urlToReturn: '/home'),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 234, 237, 1),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(250, 251, 255, 1),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "שלום: ${userController.data["name"]}",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Get.toNamed('/reporting');
                            },
                            child: Text("דיווח הטבה חדשה"),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Get.toNamed(
                                  '/contact'); // הפעולה שתרצה שתתבצע בלחיצה על הכפתור
                            },
                            child: Text("צור קשר"),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              userController.signOut();
                            },
                            child: Text("התנתקות"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
