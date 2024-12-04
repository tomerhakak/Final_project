import 'package:CheckIt/Controllers/UserController.dart';
import 'package:CheckIt/Widgets/CompanyButton.dart';
import 'package:CheckIt/Widgets/MyButton.dart';
import 'package:CheckIt/Widgets/Space.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserController userController = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void resetPassword() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("שחזור סיסמה"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'הזן כאן את האימייל שלך'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // סגור את הדיאלוג
            },
            child: Text("ביטול"),
          ),
          TextButton(
            onPressed: () {
              // שלח בקשה לשחזור הסיסמה
              final email = emailController.text.trim();
              if (email.isNotEmpty) {
                userController.resetPassword(email);
                // אפשר להוסיף פה פרוטוקול או תרגום אחר שאתה רוצה לבצע לאחר שנשלחה הבקשה לשחזור הסיסמה
                Navigator.of(context).pop(); // סגור את הדיאלוג
              }
            },
            child: Text("שלח"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff1A2A52),
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
                          Container(
                            width: 380,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: TextField(
                              controller: emailController,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                hintText: 'אימייל',
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(),
                              ),
                              onTap: () {
                                // הקוד שתרצה לבצע בעת לחיצה על התיבה
                              },
                            ),
                          ),
                          SizedBox(height: 15),
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
                                hintText: 'סיסמה',
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(),
                              ),
                              onTap: () {
                                // הקוד שתרצה לבצע בעת לחיצה על התיבה
                              },
                            ),
                          ),
                          MyButton(
                            title: "התחבר",
                            onTap: () => userController.signInWithPassword(
                              emailController.text,
                              passwordController.text,
                            ),
                          ),
                          Container(
                            child: Text(
                              'או',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 15),
                          CompanyButton(
                            iconPath: "assets/google.svg",
                            title: "התחבר דרך גוגל",
                            onTap: () {
                              userController.signInWithGoogle(null);
                            },
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              // הפעולות שתרצה לבצע כאשר הטקסט הלחוץ נלחץ
                              Get.offNamed('/register');
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'עדיין אין לך משתמש? ',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'הרשמה',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(197, 254, 237, 1),
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // הפעולות שתרצה לבצע כאשר הטקסט הלחוץ נלחץ
                                        Get.offNamed('/register');
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Space(number: 15),
                          GestureDetector(
                            onTap: resetPassword,
                            child: RichText(
                              text: TextSpan(
                                text: 'שכחתי סיסמא',
                                style: TextStyle(
                                  color: Color.fromRGBO(197, 254, 237, 1),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
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
