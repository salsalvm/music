import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/core/constant.dart';

class Settings extends StatelessWidget {
  final leadIcon;
  final text;
  final trialing;
  VoidCallback onTap;
  Settings(
      {Key? key, required this.leadIcon,
      required this.text,
      required this.onTap,
      required this.trialing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:const EdgeInsets.only(bottom: 10.0).r,
        child: Container(
          decoration: BoxDecoration(
              color: boxColor, borderRadius: BorderRadius.circular(15).r),
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
              trailing: trialing),
        ));
  }
}
