
import 'package:flutter/material.dart';
import 'package:progetto_cozza_del_gaudio/UI/behaviors/AppLocalizations.dart';

import '../../../model/Model.dart';
import '../../../model/objects/Farmacia.dart';
import '../../../model/objects/Visita.dart';


class VisitaCard extends StatelessWidget {
  final Visita visita;

  VisitaCard({required this.visita}) : super();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
          padding: EdgeInsets.all(10),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(

              ),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.translate("name") + ": " +
                        visita!.nome!,
                    style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.translate("duration") + ": " +
                        visita!.durata!.toString(),
                    style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.translate("description") + ": " +
                        visita!.descrizione!,
                    style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
                ],
              ),
          )
    );
  }
}