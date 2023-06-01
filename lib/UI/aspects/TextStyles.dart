import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BigBoldTitleStyle extends TextStyle {

  @override
  FontWeight get fontWeight => FontWeight.bold;
  @override
  double get fontSize => 30;

}

class BigTitleStyle extends TextStyle {

  @override
  FontWeight get fontWeight => FontWeight.w300;

}

class TitleStyle extends TextStyle {

  @override
  FontWeight get fontWeight => FontWeight.w200;

}

class ParagraphStyle extends TextStyle {

  @override
  FontWeight get fontWeight => FontWeight.w300;
  @override
  Color get color => Colors.grey;

}
