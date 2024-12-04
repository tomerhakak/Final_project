import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
   final urlImage=
       'http://www.uploads.co.il/uploads/images/188376560.png';
    return Container(
      child: Image.network(urlImage),
    );

  }
}
