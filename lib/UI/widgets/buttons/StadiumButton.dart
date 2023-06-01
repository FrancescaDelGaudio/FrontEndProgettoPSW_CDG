import 'package:flutter/material.dart';


class StadiumButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;
  final bool disabled;
  final double padding;
  final double minWidth;

  const StadiumButton({required this.title, required this.icon, required this.onPressed, this.disabled = false, this.padding = 10, this.minWidth = 150}) : super();


  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: EdgeInsets.all(padding),
      child: ButtonTheme(
        minWidth: minWidth,
        height: 25.0,
        child: ElevatedButton.icon(
          onPressed: () {
            if ( !disabled ) {
              onPressed();
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          icon: Icon(icon),
          label: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }


}
