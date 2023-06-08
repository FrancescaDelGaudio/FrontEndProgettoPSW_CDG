import 'package:flutter/material.dart';

import '../../../model/objects/DettaglioMagazzino.dart';


class DettaglioMagazzinoCard extends StatelessWidget {
  final DettaglioMagazzino dettaglioMagazzino;

  DettaglioMagazzinoCard({required this.dettaglioMagazzino}) : super();

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
                  "Nome: " + dettaglioMagazzino!.prodotto!.nome,
                  style: TextStyle(
                    fontFamily: "Pacifico",
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Prezzo: " +
                      dettaglioMagazzino!.prodotto!.prezzoUnitario.toString()+" €",
                  style: TextStyle(
                    fontFamily: "Pacifico",
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Quantità disponibile: " +
                      dettaglioMagazzino!.prodotto!.qtaInStock.toString(),
                  style: TextStyle(
                    fontFamily: "Pacifico",
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}