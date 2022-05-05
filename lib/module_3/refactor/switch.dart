import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:music/main.dart';

class SwitchFunction extends StatefulWidget {
  const SwitchFunction({ Key? key }) : super(key: key);

  @override
  State<SwitchFunction> createState() => _SwitchFunctionState();
}

class _SwitchFunctionState extends State<SwitchFunction> {
  bool status=false;
  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(color: Colors.transparent),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.baseline,
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlutterSwitch(
            activeColor: darkBlue,
            inactiveColor: textGrey,
            width: 110.0,
            height: 40.0,
            valueFontSize: 20.0,
            toggleSize: 20.0,
            value: status,
            borderRadius: 30.0,
            padding: 10.0,
            showOnOff: true,
            onToggle: (val) {
              setState(() {
                status = val;
              });
            },
          ),SizedBox(height: 25,),

              ElevatedButton.icon(style: ElevatedButton.styleFrom(primary: boxColor,), onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back), label: Text('Back',style: TextStyle(fontSize: 18),))
        ],
      ),
    );
  }
}

