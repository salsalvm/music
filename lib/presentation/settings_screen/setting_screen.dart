import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/core/constant.dart';
import 'package:music/presentation/settings_screen/widget/privacy_policy.dart';
import 'package:music/presentation/settings_screen/widget/setting_widget.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);


  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        title:const Text('Settings'),
        centerTitle: true,
        backgroundColor: lightBlue,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon:const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 13).r,
        child: ListView(children: [
          Settings(
            leadIcon: Icons.notification_add,
            text: 'Notification',
            onTap: () {},
            trialing: Switch(
              activeColor: textWhite,
              inactiveTrackColor: Colors.green,
              activeTrackColor: Colors.red,
              // thumbColor: ,
              value: status,
              onChanged: (val) {
              
              },
            ),
          ),
          Settings(
            leadIcon: Icons.privacy_tip,
            text: 'Privacy and Policy',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => Policy())));
            },
            trialing:const Icon(
              Icons.arrow_right,
              color: textWhite,
            ),
          ),
          Settings(
              leadIcon: Icons.share,
              text: 'Share',
              onTap: () {
                Share.share('check out my website https://example.com');
              },
              trialing:const Icon(
                Icons.arrow_right,
                color: textWhite,
              )),
          Settings(
            leadIcon: Icons.perm_device_information,
            text: 'About',
            onTap: () {
              showAboutDialog(
                  context: context,
                  applicationIcon: const Icon(
                    Icons.music_note,
                  ),
                  applicationName: 'beatz',
                  applicationVersion: '1.0.1');
            },
            trialing:const Icon(
              Icons.arrow_right,
              color: textWhite,
            ),
          )
        ]),
      )),
    );
  }
}
