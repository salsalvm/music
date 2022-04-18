import 'package:flutter/material.dart';
import 'package:music/MAIN/widget.dart';

class MyVolumeUp extends StatefulWidget {
  const MyVolumeUp({Key? key}) : super(key: key);

  @override
  State<MyVolumeUp> createState() => _MyVolumeUpState();
}

class _MyVolumeUpState extends State<MyVolumeUp> {
  int _value = 6;
  Duration position = Duration();
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: Colors.transparent,
        icon: Icon(
          Icons.volume_up,
          color: textWhite,
        ),
        itemBuilder: (context) => [
              PopupMenuItem(
                padding: EdgeInsets.only(left: 70,),
                  child: Slider(
              value: _value.toDouble(),
              min: 1.0,
              max: 10.0,
              divisions: 10,
                // value: position.inSeconds.toDouble(),
                activeColor: textWhite, inactiveColor: textGrey,
                // max: duration.inSeconds.toDouble(),
                onChanged: (double newValue) {
                setState(() {
                  _value = newValue.round();
                });
                
              },semanticFormatterCallback: (double newValue) {
                return '${newValue.round()} dollars';
              }
              ))
            ]);
  }
}
