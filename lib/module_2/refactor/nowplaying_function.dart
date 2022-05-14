import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/main.dart';

Widget BlankSpace =  SizedBox(
  height: 75.h,
);

Widget smallwidth =  SizedBox(
  width: 30.w,
);

Widget bottomPlaylist({onTap, required playListName, required countSong}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            color: boxColor, borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          onTap: onTap,
          leading: Padding(
            padding:  EdgeInsets.only(left: 6.0.w, top: 5.h),
            child: Icon(
              Icons.queue_music_rounded,
              color: textWhite,
              size: 30.w.h,
            ),
          ),
          title: Padding(
            padding:  EdgeInsets.only(left: 3.0.w, bottom: 3.h, top: 5.h),
            child: Text(
              playListName,
              style: TextStyle(color: textWhite, fontSize: 18.w.h),
            ),
          ),
          subtitle: Padding(
            padding:  EdgeInsets.only(left: 3.0.w),
            child: Text(
              countSong,
              style: TextStyle(
                color: textGrey,
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 10.h,
      )
    ],
  );
}
