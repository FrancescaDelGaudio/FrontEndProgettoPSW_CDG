import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progetto_cozza_del_gaudio/UI/behaviors/AppLocalizations.dart';
import 'package:progetto_cozza_del_gaudio/UI/pages/VisualizzaMagazzinoByCliente.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/dialogs/MessageDialog.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/DettaglioMagazzino.dart';
import 'package:progetto_cozza_del_gaudio/model/support/Constants.dart';

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
                      AppLocalizations.of(context)!.translate("name")+": " +farmacia!.nome!,
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.translate("city")+": " +farmacia!.citta!,
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.translate("address") +": "+farmacia!.indirizzo!,
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.translate("time_starting_visits")+": "+farmacia!.orarioInizioVisite.toString().split("(")[1].split(")")[0],
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                        AppLocalizations.of(context)!.translate("time_ending_visits")+": "+farmacia!.orarioFineVisite.toString().split("(")[1].split(")")[0],
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
                      AppLocalizations.of(context)!.translate("store"),
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
                      AppLocalizations.of(context)!.translate("visits"),
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
      try {
        Navigator.of(context).push(
            PageRouteBuilder(
                opaque: false,
                transitionDuration: Duration(milliseconds: 700),
                pageBuilder: (BuildContext context, _, __) =>
                    VisualizzaMagazzinoByCliente(id: farmacia.id!,
                        magazzino: result!,
                        nome: farmacia.nome!)
            )
        );
      }catch(e){
        showDialog(
          context: context,
          builder: (context) => MessageDialog(
            titleText: AppLocalizations.of(context)!.translate("oops").toUpperCase(),
            bodyText: AppLocalizations.of(context)!.translate("internal_server_error"),
          ),
        );
      }
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