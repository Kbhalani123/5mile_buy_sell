import 'package:flutter/material.dart';
import 'package:mile_locally/constant/app_constant.dart';

Widget getIndicator(bool isActive) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 3),
    height: isActive ? 12 : 10,
    width: isActive ? 35 : 10,
    decoration: BoxDecoration(
      color: isActive ? AppConstant.cardColor : Colors.black,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}