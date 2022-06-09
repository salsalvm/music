import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/core/constant.dart';
import 'package:music/domain/songmodel.dart';

class UpdatePlaylist extends StatelessWidget {
  String playlistName;
  UpdatePlaylist({Key? key, required this.playlistName}) : super(key: key);
  final box = StorageBox.getInstance();
  String? title;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: darkBlue,
      title:const Center(
          child: Text(
        'Edit Your Playlist Name',
        style: TextStyle(color: textWhite),
      )),
      // update
      content: Form(
        key: formKey,
        child: TextFormField(
          initialValue: playlistName,
          style:const TextStyle(color: textWhite),
          onChanged: (value) {
            title = value.trim();
          },
          validator: (value) {
            if (value!.trim() == "") {
              return "Name Required";
            }
            return null;
          },
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 5.w),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: textWhite, width: 5.w)),
              fillColor: textWhite),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: textWhite, fontSize: 18.sp),
                  )),
              TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      List? curentPlaylistName = box.get(playlistName);
                      box.put(title, curentPlaylistName!);
                      box.delete(playlistName);
                      Navigator.pop(context);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: boxColor,
                        margin: const EdgeInsets.all(10).r,
                        content: const Text('Playlist Renamed')));
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: textWhite, fontSize: 18.sp),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
