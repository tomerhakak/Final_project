import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Widgets/TopBar.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _providerNameController = TextEditingController();
  TextEditingController _organizationTypeController = TextEditingController();
  TextEditingController _referralTypeController = TextEditingController();
  TextEditingController _isGuideOrSystemController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List<PlatformFile>? _selectedFiles;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _providerNameController.dispose();
    _organizationTypeController.dispose();
    _referralTypeController.dispose();
    _isGuideOrSystemController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    final pattern = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return pattern.hasMatch(email);
  }

  void _sendDataToFirestore() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    final providerName = _providerNameController.text;
    final organizationType = _organizationTypeController.text;
    final referralType = _referralTypeController.text;
    final isGuideOrSystem = _isGuideOrSystemController.text;
    final description = _descriptionController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        providerName.isEmpty ||
        organizationType.isEmpty ||
        referralType.isEmpty ||
        isGuideOrSystem.isEmpty ||
        description.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('שגיאה בשליחת הנתונים'),
            content: Text('אנא מלא את כל השדות.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('סגור'),
              ),
            ],
          );
        },
      );
      return; // אם יש שדה ריק, אל תשלח את הנתונים
    }

    if (!isValidEmail(email)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('שגיאה בשליחת הנתונים'),
            content: Text('כתובת האיימל אינה תקינה.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('סגור'),
              ),
            ],
          );
        },
      );
      return; // אם כתובת האיימל אינה תקינה, אל תשלח את הנתונים
    }

    // שאר השלבים של הפונקציה נשמרים כמו שהם
    final dataToSend = {
      'name': name,
      'email': email,
      'phone': phone,
      'providerName': providerName,
      'organizationType': organizationType,
      'referralType': referralType,
      'isGuideOrSystem': isGuideOrSystem,
      'description': description,
    };

    try {
      await FirebaseFirestore.instance.collection('contacts').add(dataToSend);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('הנתונים נשלחו בהצלחה'),
            content: Text('תודה על פנייתך.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _clearFields(); // ניקוי השדות לאחר שליחה
                },
                child: Text('סגור'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('שגיאה בשליחת הנתונים'),
            content: Text('אנא נסה שוב מאוחר יותר.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('סגור'),
              ),
            ],
          );
        },
      );
    }
  }

  void _clearFields() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _providerNameController.clear();
    _organizationTypeController.clear();
    _referralTypeController.clear();
    _isGuideOrSystemController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedFiles = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          child: Column(
            children: [
              TopBar(urlToReturn: '/profile'),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(209, 209, 211, 1),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // קוד הטקסטפילדים
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              "פרטי התקשורת",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller: _nameController, // שם מלא
                              decoration: InputDecoration(
                                labelText: 'שם מלא',
                              ),
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller: _emailController, // כתובת איימל
                              decoration: InputDecoration(
                                labelText: "כתובת איימל",
                              ),
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller: _phoneController, // מספר טלפון
                              decoration: InputDecoration(
                                labelText: "מספר טלפון",
                              ),
                            ),
                          ),
                          // פרטי נותן הההטבה
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              "פרטי נותן הההטבה",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller:
                                  _providerNameController, // שם מספק הההטבה
                              decoration: InputDecoration(
                                labelText: "שם מספק הההטבה",
                              ),
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller:
                                  _organizationTypeController, // סוג הארגון (חבר מועדון/חברת אשראי)
                              decoration: InputDecoration(
                                labelText: "סוג הארגון (חבר מועדון/חברת אשראי)",
                              ),
                            ),
                          ),
                          // סיבת הפניה
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              "סיבת הפניה",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller:
                                  _referralTypeController, // אופי הפניה (דוח תקלות/זיהוי פערים/בקשה לשנוי)
                              decoration: InputDecoration(
                                labelText:
                                    "אופי הפניה (דוח תקלות/זיהוי פערים/בקשה לשנוי)",
                              ),
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller:
                                  _isGuideOrSystemController, // אם מדובר במדריך או במערכת
                              decoration: InputDecoration(
                                labelText: "אם מדובר במדריך או במערכת",
                              ),
                            ),
                          ),
                          // פרטי הפניה
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              "פרטי הפניה",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller:
                                  _descriptionController, // תיאור הבקשה (עד 500 מילים)
                              maxLines: null,
                              maxLength: 500,
                              decoration: InputDecoration(
                                labelText: 'תיאור הבקשה (עד 500 מילים)',
                                hintText: 'כתוב כאן תיאור מפורט של הבקשה',
                              ),
                            ),
                          ),
                          SizedBox(height: 16),

                          // קבצים נלווים
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              "קבצים נלווים",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              final result =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                              );
                              if (result != null) {
                                setState(() {
                                  _selectedFiles = result.files;
                                });
                              }
                            },
                            child: Text("בחר קבצים"),
                          ),

                          if (_selectedFiles != null &&
                              _selectedFiles!.isNotEmpty)
                            ListView.builder(
                              itemCount: _selectedFiles!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final file = _selectedFiles![index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "קובץ ${index + 1}:",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    Text(file.name),
                                    SizedBox(height: 8),
                                  ],
                                );
                              },
                            )
                          else
                            Text(
                              "לא נבחרו קבצים",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          SizedBox(height: 16),

                          // הוספת כפתורים לשליחה וניקוי
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: _sendDataToFirestore,
                                child: Text("שלח"),
                              ),
                              ElevatedButton(
                                onPressed: _clearFields,
                                child: Text("נקה"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
