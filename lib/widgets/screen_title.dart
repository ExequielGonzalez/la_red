import 'package:flutter/material.dart';

import '../constants.dart';

class ScreenTitle extends StatelessWidget {
  final double height;
  final double width;
  final String title;


  ScreenTitle({this.title, this.width, this.height});



  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.081,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: height * 0.08,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  title.toUpperCase(),
                  style: kTextStyleBold.copyWith(fontSize: width*0.10, height: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
