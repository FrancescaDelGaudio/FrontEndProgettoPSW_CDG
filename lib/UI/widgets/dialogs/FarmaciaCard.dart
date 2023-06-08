import 'package:flutter/material.dart';
import 'package:progetto_cozza_del_gaudio/UI/pages/VisualizzaMagazzinoByCliente.dart';

import '../../../model/Model.dart';
import '../../../model/objects/Farmacia.dart';
import 'package:progetto_cozza_del_gaudio/UI/pages/VisualizzaMagazzinoByCliente.dart';


class FarmaciaCard extends StatelessWidget {
  final Farmacia farmacia;

  FarmaciaCard({required this.farmacia}) : super();

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
                      "Nome: "+farmacia!.nome!,
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Citta: "+farmacia!.citta!,
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Indirizzo: "+farmacia!.indirizzo!,
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Orario di inizio visite: "+farmacia!.orarioInizioVisite.toString().split("(")[1].split(")")[0],
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Orario di inizio visite: "+farmacia!.orarioFineVisite.toString().split("(")[1].split(")")[0],
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    RawMaterialButton(
                      fillColor: Colors.blueAccent,
                      onPressed:(){ _visualizzaMagazzino(context); },
                      shape: LinearBorder(),
                      elevation: 2.0,
                      child: Icon(
                        Icons.storage,
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      "magazzino",
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    RawMaterialButton(
                      fillColor: Colors.blueAccent,
                      onPressed:(){ /*_visualizzaVisite(context); */ },
                      shape: LinearBorder(),
                      elevation: 2.0,
                      child: Icon(
                        Icons.local_hospital,
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      "visite",
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 15,
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

  void _visualizzaMagazzino(BuildContext context) {
    Model.sharedInstance.visualizzaMagazzinoByCliente(farmacia.id!)?.then((result) {
      Navigator.of(context).push(
          PageRouteBuilder(
          opaque: false,
          transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (BuildContext context, _, __) => VisualizzaMagazzinoByCliente(id: farmacia.id!, magazzino: result!, nome: farmacia.nome!)
          )
      );
    });
  }
/*
  void _visualizzaVisite(BuildContext context) {
    Model.sharedInstance.visualizzaVisiteByCliente(farmacia!.id!)?.then((result) {
      Navigator.of(context).push(
          PageRouteBuilder(
          opaque: false,
          transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (BuildContext context, _, __) => VisualizzaVisite(farmacia!.id!,result,farmacia!.nome!));
      });
    });
  }

 */

}