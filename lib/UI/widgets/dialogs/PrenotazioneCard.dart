import 'package:flutter/material.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/dialogs/FarmaciaCard.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Appuntamento.dart';

import '../../../model/objects/DettaglioMagazzino.dart';
import '../../behaviors/AppLocalizations.dart';


class PrenotazioneCard extends StatelessWidget {
  final Appuntamento prenotazione;

  PrenotazioneCard({required this.prenotazione}) : super();

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Farmacia: " + prenotazione!.farmacia.nome!,
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Data: " + prenotazione.data.toString().split(" ")[0],
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Orario: " +
                          prenotazione.orario.toString().split("(")[1].split(
                              ")")[0],
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            )
        ),
      );
    }
  }