import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/core/constant.dart';
import 'package:music/domain/songmodel.dart';

class CreatePlaylistForm extends StatefulWidget {
  const CreatePlaylistForm({Key? key}) : super(key: key);

  @override
  State<CreatePlaylistForm> createState() => _CreatePlaylistFormState();
}

class _CreatePlaylistFormState extends State<CreatePlaylistForm> {
  @override
  Widget build(BuildContext context) {
    List<Songs> playlist = [];
    final box = StorageBox.getInstance();
    String? title;
    final formKey = GlobalKey<FormState>();

    return AlertDialog(
      backgroundColor: darkBlue,
      alignment: Alignment.center,
      title: Center(
          child: Text(
        "Give Your Playlist Name",
        style: TextStyle(color: textWhite),
      )),

      // form validation
      content: Form(
        key: formKey,
        child: TextFormField(
            onChanged: (value) {
              title = value.trim();
            },
            validator: (value) {
              List keys = box.keys.toList();
              if (value!.trim() == "") {
                return "Name Required";
              }
              if (keys.where((element) => element == value.trim()).isNotEmpty) {
                return "This Name Already Exist";
              }
              return null;
            },
            style: TextStyle(color: textWhite),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 5.w)),
              // fillColor: textWhite,
              hintText: 'Playlist Name',
              hintStyle: TextStyle(color: textGrey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: textGrey, width: 5.0.w),
              ),
            )),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text("Cancel",
                    style: TextStyle(color: textWhite, fontSize: 16.sp)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              // add playlist from db
              TextButton(
                child: Text("Create",
                    style: TextStyle(color: textWhite, fontSize: 16.sp)),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    box.put(title, playlist);
                    Navigator.pop(context);
                    setState(() {});
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
