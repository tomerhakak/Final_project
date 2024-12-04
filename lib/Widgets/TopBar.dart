import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TopBar extends StatelessWidget {
  const TopBar(
      {super.key,
      this.showBackButton1 = true,
      this.showProfileIcon = true,
      this.urlToReturn = ''});
  final bool showBackButton1;
  final bool showProfileIcon;
  final String urlToReturn;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: showBackButton1,
          child: IconButton(
            iconSize: 36,
            color: Colors.white,
            onPressed: () => Get.offNamed(urlToReturn),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SvgPicture.asset("assets/logo.svg", height: 48, width: 200),
        ),
        Visibility(
          visible: showProfileIcon,
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Color.fromARGB(255, 216, 212, 212),
            child: IconButton(
              iconSize: 30,
              color: const Color.fromARGB(255, 10, 10, 10),
              onPressed: () => Get.offNamed('/profile'),
              icon: const Icon(Icons.person),
            ),
          ),
        ),
      ],
    );
  }
}
