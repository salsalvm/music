import 'package:flutter/material.dart';
import 'package:music/module_1/home_screen.dart';
import 'package:music/module_3/setting_widget.dart';
import 'package:music/MAIN/widget.dart';
import 'package:music/module_3/switch.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        backgroundColor: lightBlue,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            // pushAndRemoveUntil( MaterialPageRoute(builder: (context) => HomeScreen()),(route) => false);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        child: ListView(children: [
          Settings(
              leadIcon: Icons.notification_add,
              text: 'Notification',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SwitchFunction()));
              },
              trialing: Icon(
                Icons.arrow_right,
                color: textWhite,
              )
              // trialing: FlutterSwitch(
              //     width: 40.0,
              //     height: 25.0,
              //     valueFontSize: 12.0,
              //     toggleSize: 15.0,
              //     value: status,
              //     borderRadius: 30.0,
              //     padding: 1.0,
              //     showOnOff: true,
              //     onToggle: (val) {
              //       setState(() {
              //         status = val;
              //       });
              //     },
              //   ),
              ),
          Settings(
            leadIcon: Icons.privacy_tip,
            text: 'Privacy and Security',
            onTap: () {},
            trialing: Icon(
              Icons.arrow_right,
              color: textWhite,
            ),
          ),
          Settings(
            leadIcon: Icons.headphones,
            text: 'Help and Support',
            onTap: () {},
            trialing: Icon(
              Icons.arrow_right,
              color: textWhite,
            ),
          ),
          Settings(
            leadIcon: Icons.perm_device_information,
            text: 'About',
            onTap: () {},
            trialing: Icon(
              Icons.arrow_right,
              color: textWhite,
            ),
          )
        ]),
      )),
    );
  }
}
