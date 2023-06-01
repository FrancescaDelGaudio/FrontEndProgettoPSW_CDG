import 'package:flutter/material.dart';


class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const CircularIconButton({required this.icon, this.onPressed}) : super();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: RawMaterialButton(
        fillColor: Colors.blueAccent,
        onPressed: onPressed,
        shape: CircleBorder(),
        elevation: 2.0,
        child: Icon(
          icon,
        ),
        padding: EdgeInsets.all(15),
      ),
    );
  }


}