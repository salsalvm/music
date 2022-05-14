

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/main.dart';

class Settings extends StatelessWidget {
  final leadIcon;
  final text;
  final trialing;
  VoidCallback onTap;
  Settings(
      {required this.leadIcon,
      required this.text,
      required this.onTap,
      required this.trialing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 10.0.h),
      child: Container(
        decoration: BoxDecoration(
            color: boxColor, borderRadius: BorderRadius.circular(15)),
        child: ListTile(
            onTap: onTap,
            leading: Icon(
              leadIcon,
              color: textWhite,
            ),
            title: Text(
              text,
              style: TextStyle(color: textWhite),
            ),
            trailing: trialing
            // Icon(
            //   Icons.arrow_right,
            //   color: textWhite,
            // ),
            ),
      )
    );
  }
}
