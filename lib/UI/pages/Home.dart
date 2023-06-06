import 'package:progetto_cozza_del_gaudio/UI/behaviors/AppLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Farmacia.dart';
import 'package:progetto_cozza_del_gaudio/services/get_information_personal.dart';

class Home extends StatefulWidget {
  Home() : super();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Image.asset('assets/images/schermataIniziale.jpg'),
                ),
            ),
          ],
        ),
      ),
    );
  }


}