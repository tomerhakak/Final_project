import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:CheckIt/Controllers/BenefitController.dart';
import 'package:CheckIt/Widgets/CategoryWidget.dart';
import 'package:CheckIt/Widgets/TopBar.dart';
import 'package:CheckIt/models/Category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BenefitController benefitController = Get.find();

  @override
  void initState() {
    benefitController.fetchCategories();
    super.initState();
  }

  void handleCategoryClick(Category category) {
    benefitController.currentCategory = category.categoryId;
    Get.toNamed("/benefits");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 28.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TopBar(),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(209, 209, 211, 1),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Obx(
                              () => Column(
                                children: benefitController.categoriesIds.map(
                                  (categoryId) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      child: CategoryWidget(
                                        handleCategoryClick:
                                            handleCategoryClick,
                                        categories: benefitController.categories
                                            .where((category) =>
                                                category.parentId == categoryId)
                                            .toList(),
                                        categoryId: categoryId,
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
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
      ),
    );
  }
}
