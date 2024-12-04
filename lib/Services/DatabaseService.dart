import 'package:CheckIt/models/Benefit.dart';
import 'package:CheckIt/models/Category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  static Future<Map<String, dynamic>?> fetchUserData(String uid) async {
    final db = FirebaseFirestore.instance;
    var result = await db.collection('users').doc(uid).get();
    if (result.exists) {
      return result.data();
    } else {
      return null;
    }
  }

  static Future<void> updateUserData(
      String uid, Map<String, dynamic> data) async {
    final db = FirebaseFirestore.instance;
    await db.collection('users').doc(uid).set(data, SetOptions(merge: true));
  }

  static Future<List<Benefit>> fetchBenefits(categoryId) async {
    final db = FirebaseFirestore.instance;
    final result = await db.collection("benfits").where("Category", isEqualTo: categoryId).get();
    List<Benefit> benefits = [];
    for (var benefit in result.docs) {
      benefits.add(Benefit.fromSnapshot(benefit.data()));
    }
    return benefits;
  }

  static Future<(List<Category>, List<String>)> fetchCategories() async {
    final db = FirebaseFirestore.instance;
    final result = await db.collection("data").doc('categories').get();
    List<Category> categories = [];
    List<String> mainIds = [];
    if (result.exists) {
      Map<String, dynamic> data = result.data()!;
      if (data.containsKey('categories')) {
        for (var category in data['categories']) {
          categories.add(Category.fromSnapshot(category));
        }
      }
      mainIds = (data['mainIds'] as List).map((e) => e.toString()).toList();
    }
    return (categories, mainIds);
  }
}
