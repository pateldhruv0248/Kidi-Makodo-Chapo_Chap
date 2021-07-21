import 'package:flutter/material.dart';
import 'constants.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: kSecondaryColour,
        appBar: AppBar(
          title: Text(
            'Settings',
            style: kTitleTextStyle,
          ),
          backgroundColor: kAppbarColour,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Simplicity:  ' + simplicity.toString(), style: kTextStyle),
            SizedBox(height: 10.0),
            Slider(
              value: simplicity.toDouble(),
              onChanged: (double newDifficulty) {
                setState(() {
                  simplicity = newDifficulty.round();
                });
              },
              activeColor: kAppbarColour,
              inactiveColor: kBorderColour,
              min: 5,
              max: 500,
              divisions: 99,
            ),
            SizedBox(height: 10.0),
            MaterialButton(
              child: Text(
                'OK',
                style: TextStyle(color: kSecondaryColour),
              ),
              color: kInactiveButtonColour,
              onPressed: () {
                Navigator.pop(context);
              },
            )
            // ,
            // ElevatedButton(
            //   child: Text('OK'),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
