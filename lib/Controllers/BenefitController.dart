import 'package:CheckIt/Services/DatabaseService.dart';
import 'package:CheckIt/models/Benefit.dart';
import 'package:CheckIt/models/Category.dart';
import 'package:get/get.dart';

class BenefitController extends GetxController {
  RxList<Benefit> benefits = RxList<Benefit>();
  RxList<Category> categories = RxList<Category>();
  RxList<String> categoriesIds = RxList<String>();
  Benefit? currentBenefit = null;

  String currentCategory = '';

  Future<void> fetchBenefits() async {
    benefits.value = await DatabaseService.fetchBenefits(currentCategory);
    print(benefits[0]);
    update();
  }

  Future<void> fetchCategories() async {
    var res = await DatabaseService.fetchCategories();
    categories.value = res.$1;
    categoriesIds.value = res.$2;
    update();
  }

  void resetBenefits() {
    benefits.value = [];
    currentCategory = '';
  }

  void setCurrentBenefit(Benefit benefit) {
    currentBenefit = benefit;
  }
}
