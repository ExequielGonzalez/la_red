import 'package:flutter/material.dart';
import 'package:la_red/widgets/screen_banner.dart';
import 'package:la_red/widgets/screen_title.dart';

import '../constants.dart';
import 'background.dart';

class BackgroundTemplate extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final Widget child;

  BackgroundTemplate({this.width, this.height, this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              ScreenBanner(
                height: height,
                width: width,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: kBordo,
                    border: Border.all(color: Colors.blueGrey),
                  ),
                  child: Column(
                    children: [
                      ScreenTitle(
                        width: width,
                        height: height,
                        title: title,
                      ),
                      SizedBox(
                        height: 1,
                        child: Container(
                          color: Colors.blueGrey,
                        ),
                      ),
                      child ?? Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
