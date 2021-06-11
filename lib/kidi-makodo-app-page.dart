import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:math';
import 'package:kidimakodochapochap/constants.dart';
import 'settings.dart';
import 'circular_button.dart';

class KidiMakodoApp extends StatefulWidget {
  @override
  _KidiMakodoAppState createState() => _KidiMakodoAppState();
}

enum textToShow { PressHold, Replay }

class _KidiMakodoAppState extends State<KidiMakodoApp> {
  String handAnimation = "Idle";
  List texts = ["Press & Hold", "Replay"];
  var buttonStatus = textToShow.PressHold;
  Stopwatch timer = Stopwatch();
  Color kButtonColour = kInactiveButtonColour;
  String winLose = 'Winner or Loser ?';
  int timeStamp = 0;
  Color kFLashLight = kUnflashColour;
  bool flag = false;
  void animateHand() {
    handAnimation = handAnimation;
  }

  final assetsAudioPlayer = AssetsAudioPlayer();
  void musicBox() async {
    timer.start();
    await assetsAudioPlayer.open(
      Playlist(audios: [
        Audio('assets/kidi', playSpeed: Random().nextInt(5) + 1.1),
        Audio('assets/makodo', playSpeed: Random().nextInt(5) + 1.1),
        Audio('assets/chapochap', playSpeed: Random().nextInt(6) + 1.1)
      ]),
    );
    try {
      await assetsAudioPlayer.playlistFinished
          .where((finished) => finished == true)
          .first;
      setState(() {
        kFLashLight = kFlashColour;
      });
      timer.reset();
      flag = true;
    } catch (e) {
      print('error');
    }
  }

  void onTapRelease() {
    timeStamp = timer.elapsedMilliseconds;
    setState(
      () {
        if (buttonStatus == textToShow.PressHold) {
          if (flag) {
            if (timeStamp <= simplicity && timeStamp > 0) {
              winLose = 'You Win, Play again  -';
              handAnimation = "Winner";
            } else {
              handAnimation = "Loser";
              winLose = 'You Lose, Be quick  -';
            }
          } else {
            handAnimation = "Loser";
            winLose = 'Too early, Be patient  -';
            timeStamp = 0;
          }
          buttonStatus = textToShow.Replay;
          assetsAudioPlayer.stop();
        } else {
          buttonStatus = textToShow.PressHold;
          handAnimation = "Idle";
          kFLashLight = kUnflashColour;
        }
        animateHand();
        timer.stop();
        timer.reset();
        flag = false;
        kButtonColour = kInactiveButtonColour;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: kSecondaryColour,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                child: Image(
                  height: 10.0,
                  width: 10.0,
                  semanticLabel: 'Logo',
                  alignment: Alignment.center,
                  image: AssetImage('assets/images/KidiMakoChapoChapIcon.png'),
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColour,
                ),
              ),
              ListTile(
                title: Text('How To Play ?', style: kTextStyle),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          clipBehavior: Clip.hardEdge,
                          backgroundColor: kSecondaryColour,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                              width: 25.0,
                              color: kBorderColour,
                            )),
                            height: 550.0,
                            width: 450.0,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('The game: ',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(height: 20),
                                  Text(
                                      bullet +
                                          'Press and Hold the button to play the game.',
                                      style: kHowtoPlayText),
                                  SizedBox(height: 20),
                                  Text(
                                    bullet +
                                        'The computer will start speaking \'KIDI MAKODO CHAPO CHAP\', when the computer stops speaking, release the button.',
                                    style: kHowtoPlayText,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    bullet +
                                        'If you release the button on time, you will be safe from the Upper hand, else, you will be caught!',
                                    style: kHowtoPlayText,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
              ListTile(
                title: Text('Settings', style: kTextStyle),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              )
            ],
          ),
        ),
      ),
      backgroundColor: kBodyColour,
      appBar: AppBar(
        title: Text('Kidi Makodo Chapo Chap',
            style: kTitleTextStyle.copyWith(color: kSecondaryColour)),
        backgroundColor: kAppbarColour,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: FlareActor(
                'assets/Hand 2d.flr',
                animation: handAnimation,
                alignment: Alignment.center,
                fit: BoxFit.fill,
              ),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(
                  color: kBorderColour,
                  width: 10,
                ),
                boxShadow: [
                  BoxShadow(
                    color: kFLashLight,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              height: 70,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(winLose, style: kTextStyle),
                  SizedBox(
                    width: 10,
                  ),
                  Text(timeStamp.toString() + ' ms', style: kTextStyle),
                ],
              ),
              decoration: BoxDecoration(
                  color: kSecondaryColour,
                  border: Border.all(
                    color: kBorderColour,
                    width: 6,
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: GestureDetector(
                onTapCancel: () {
                  onTapRelease();
                },
                onTapDown: (TapDownDetails details) {
                  setState(
                    () {
                      kButtonColour = kActiveButtonColour;
                      if (buttonStatus == textToShow.PressHold) {
                        musicBox();
                      } else {
                        timeStamp = 0;
                        winLose = 'Kidi Makodo Chapo Chap  -';
                      }
                    },
                  );
                },
                onTapUp: (TapUpDetails details) {
                  onTapRelease();
                },
                child: CircularButton(
                  colour: kButtonColour,
                  title: texts[buttonStatus.index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
