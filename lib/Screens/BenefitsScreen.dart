import 'package:CheckIt/Controllers/BenefitController.dart';
import 'package:CheckIt/Controllers/UserController.dart';
import 'package:CheckIt/Widgets/BenefitWidget.dart';
import 'package:CheckIt/Widgets/MyButton.dart';
import 'package:CheckIt/Widgets/TopBar.dart';
import 'package:CheckIt/models/Benefit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BenefitsScreen extends StatefulWidget {
  const BenefitsScreen({Key? key}) : super(key: key);

  @override
  State<BenefitsScreen> createState() => _BenefitsScreenState();
}

class _BenefitsScreenState extends State<BenefitsScreen> {
  BenefitController benefitController = Get.find();
  UserController userController = Get.find();
  final TextEditingController _searchController = TextEditingController();
  String searchValue = '';

  @override
  void initState() {
    benefitController.fetchBenefits();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    benefitController.resetBenefits();
    super.dispose();
  }

  void handleClick(Benefit benefit) {
    benefitController.setCurrentBenefit(benefit);
    Get.toNamed('/benefit');
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
                const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            child: Column(
              children: [
                TopBar(
                  urlToReturn: '/home',
                ),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 16.0),
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.search,
                                  size: 24.0,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: TextField(
                                    textDirection: TextDirection.rtl,
                                    controller: _searchController,
                                    style: TextStyle(fontSize: 16),
                                    decoration: InputDecoration(
                                      hintTextDirection: TextDirection.rtl,
                                      hintText: 'חיפוש...',
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 14,
                                      ),
                                    ),
                                    onChanged: (v) {
                                      setState(
                                        () {
                                          searchValue = v;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Obx(
                                      () => Column(
                                        children: benefitController.benefits
                                            .where((benefit) =>
                                                searchValue != ''
                                                    ? benefit.name.contains(
                                                        _searchController.text)
                                                    : true)
                                            .toList()
                                            .map((benefit) => Column(
                                                  children: [
                                                    BenefitCard(
                                                      benefit: benefit,
                                                      onClick: () {
                                                        handleClick(benefit);
                                                      },
                                                    ),
                                                    SizedBox(height: 16),
                                                  ],
                                                ))
                                            .toList(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
