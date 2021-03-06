import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/core/constant.dart';



Widget bottomPlaylist({onTap, required playListName, required countSong}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            color: boxColor, borderRadius: BorderRadius.circular(15).r),
        child: ListTile(
          onTap: onTap,
          leading: Padding(
            padding: const EdgeInsets.only(left: 6, top: 5).r,
            child: Icon(
              Icons.queue_music_rounded,
              color: textWhite,
              size: 30.sp,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 3.0, bottom: 3, top: 5).r,
            child: Text(
              playListName,
              style: TextStyle(color: textWhite, fontSize: 18.sp),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 3.0).r,
            child: Text(
              countSong,
              style:const TextStyle(
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
