import 'package:CheckIt/models/Benefit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BenefitCard extends StatelessWidget {
  const BenefitCard({super.key, required this.benefit, required this.onClick});

  final Benefit benefit;
  final VoidCallback onClick;

  final imageUrl =
      'https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: 375,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              width: 200,
              child: Text(
                benefit.name,
                textDirection: TextDirection.rtl,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
                maxLines: 2,
              ),
            ),
            SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                benefit.imageUrl,
                width: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(imageUrl,
                      width: 90, fit: BoxFit.cover); //do something
                },
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
