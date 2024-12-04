import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompanyButton extends StatelessWidget {
  const CompanyButton({
    Key? key,
    required this.iconPath,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String iconPath;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
