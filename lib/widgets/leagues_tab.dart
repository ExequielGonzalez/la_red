import 'package:flutter/material.dart';
import 'package:la_red/constants.dart';

class LeaguesTab extends StatefulWidget {
  final String text;
  final bool selected;
  final Function onTap;
  final double width;

  LeaguesTab({this.text, this.selected = false, this.onTap,this.width});

  @override
  _LeaguesTabState createState() => _LeaguesTabState();
}

class _LeaguesTabState extends State<LeaguesTab> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
              color: widget.selected ? Colors.white : Colors.blueGrey,
              width: widget.selected ? 5 : 0,
            )),
          ),
          child: Center(
            child: Text(
              widget.text.toUpperCase(),
              style: kTextStyleBold.copyWith(fontSize: widget.width*0.047),
            ),
          ),
        ),
      ),
    );
  }
}
