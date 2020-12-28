import 'package:flutter/material.dart';
import 'package:la_red/constants.dart';

class HomeButton extends StatelessWidget {
  final double width;
  final double height;

  final Function onTap;

  final String title;

  HomeButton({this.width, this.height, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkResponse(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: kBordo,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //0.151 el icono
            children: [
              Container(
                width: width * 0.36,
                height: width * 0.36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.06),
                  child: Image.asset(
                    "assets/images/$title.png",
                    width: width * 0.37,
                    height: width * 0.37,
                  ),
                ),
              ),
              Text(
                title.toUpperCase(),
                style: kTextStyleBold.copyWith(fontSize: height * 0.18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
