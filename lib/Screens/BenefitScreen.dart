import 'package:CheckIt/Controllers/BenefitController.dart';
import 'package:CheckIt/Widgets/TopBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BenefitScreen extends StatefulWidget {
  const BenefitScreen({super.key});

  @override
  State<BenefitScreen> createState() => _BenefitScreenState();
}

class _BenefitScreenState extends State<BenefitScreen> {
  BenefitController benefitController = Get.find();

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  final imageUrl =
      'https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg';

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
            child: Column(children: [
              TopBar(urlToReturn: '/benefits'),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          benefitController.currentBenefit!.imageUrl,
                          width: 180,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(imageUrl,
                                width: 180, fit: BoxFit.cover); //do something
                          },
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                      Text(
                        "שם: " + benefitController.currentBenefit!.name,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        "חברה: " + benefitController.currentBenefit!.companyId,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "קטגוריה: " +
                            benefitController.currentBenefit!.category,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                          onTap: () {
                            Uri url = Uri.parse(
                                benefitController.currentBenefit!.benefitUrl);
                            _launchUrl(url);
                          },
                          child: Text(
                            "מעבר לאתר ההטבה",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ))
            ]),
          )),
    ));
  }
}
