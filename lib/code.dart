import 'package:flutter/material.dart';

//יצירת כפתורים
getBottom(String s) {
  return Container(
    width: 380,
    height: 40,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[getbutton(s)],
    ),
  );
}

getbutton(title) {
  return ElevatedButton(
    onPressed: () {},
    child: Text(
      title,
      style: TextStyle(color: Colors.black),
    ),
    style: ElevatedButton.styleFrom(
      primary: Color.fromRGBO(153, 238, 194, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
    ),
  );
}

//יצירת כפתורים
getBottomI(String s) {
  return Container(
    width: 380,
    height: 40,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[getbuttonI(s)],
    ),
  );
}

getbuttonI(title) {}
