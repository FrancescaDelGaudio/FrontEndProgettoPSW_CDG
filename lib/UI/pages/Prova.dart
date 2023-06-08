import 'package:flutter/material.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/buttons/CircularIconButton.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/DettaglioMagazzino.dart';
import 'package:progetto_cozza_del_gaudio/model/Model.dart';

class Prova extends StatefulWidget {
  Prova() : super();

  @override
  _ProvaState createState() => _ProvaState();
}

class _ProvaState extends State<Prova> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            CircularIconButton(
              icon: Icons.accessible,
              onPressed: () async{
                List<DettaglioMagazzino>? result = await Model.sharedInstance.visualizzaMagazzino();
                print(result);
              },
            )
          ],
        ),
      ),
    );
  }



}