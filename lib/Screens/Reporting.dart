import 'package:CheckIt/Widgets/TopBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Reporting extends StatefulWidget {
  const Reporting({Key? key});

  @override
  State<Reporting> createState() => _ReportingState();
}

class _ReportingState extends State<Reporting> {
  final TextEditingController hebrewTextController = TextEditingController();
  final TextEditingController linkTextController = TextEditingController();

  void _sendReport() {
    final hebrewText = hebrewTextController.text;
    final linkText = linkTextController.text;

    // בדוק אם אחת מהתיבות ריקה ואם כן, הצג הודעה
    if (hebrewText.isEmpty || linkText.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Text('שדות חסרים'),
              content: Text('אנא מלא את כל השדות הטקסט.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('סגור'),
                ),
              ],
            ),
          );
        },
      );
      return; // אל תשלח את הדיווח אם יש שדות חסרים
    }

    // אחרי השלמת הטקסטים שמוזנים בשדות הטקסט, שלח אותם ל Firestore
    FirebaseFirestore.instance.collection('add_benfit').add({
      'שם_הטבה': hebrewText,
      'קישור_להטבה': linkText,
    });

    // הצג הודעה או בציות שהדיווח נשלח בהצלחה
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text('הטבה נשלחה לבדיקה'),
            content: Text(
                'כל הטבה תבדק ומדידת הצורך נעלה את הטבה לאפליקצייה Check It.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // מחק את הטקסט משדות הטקסט
                  hebrewTextController.clear();
                  linkTextController.clear();
                },
                child: Text('סגור'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xff273B69),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TopBar(urlToReturn: '/profile'),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 234, 237, 1),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              "דיווח על הטבה חדשה",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 16),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller: hebrewTextController,
                              decoration: InputDecoration(
                                labelText: 'שם הטבה',
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller: linkTextController,
                              decoration: InputDecoration(
                                labelText: 'קישור להטבה',
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _sendReport,
                            child: Text('שלח דיווח'),
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
