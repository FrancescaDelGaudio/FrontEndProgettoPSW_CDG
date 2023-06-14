import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progetto_cozza_del_gaudio/UI/behaviors/AppLocalizations.dart';
import 'package:progetto_cozza_del_gaudio/model/Model.dart';
import 'package:progetto_cozza_del_gaudio/model/support/Constants.dart';

import '../../../model/objects/Prodotto.dart';
import 'MessageDialog.dart';


class ProdottoCard extends StatefulWidget {
  final Prodotto prodotto;

  ProdottoCard({required this.prodotto}) : super();

  @override
  State<StatefulWidget> createState() => _ProdottoState(prodotto);

}
class _ProdottoState extends State<ProdottoCard> {
  late Prodotto prodotto;
  bool loading=false;
  int quantita=0;

  _ProdottoState(Prodotto prodotto) {
    this.prodotto=prodotto;
  }

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
              loading==true ?
                  CircularProgressIndicator()
              :
              Column(

              ),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.translate("name") + ": " +
                        prodotto!.nome!,
                    style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.translate("active_principle") + ": " +
                        prodotto!.principioAttivo!,
                    style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.translate("pharmaceutical_form") + ": " +
                        prodotto!.formaFarmaceutica!,
                    style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.translate(
                        "unit_price")+ " :"+
                        prodotto!.prezzoUnitario.toString()+" €",
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
                    onPressed: () {_aggiungiAlCarrello();},
                      child: Icon(Icons.shopping_cart),
                  ),
                  Text(
                    AppLocalizations.of(context)!.translate("add_to_chart")
                  ),
                  RawMaterialButton(
                    onPressed: () {_aumenta();},
                    child: Icon(Icons.add),
                  ),
                  RawMaterialButton(
                    onPressed: () {_diminuisci();},
                    child: Icon(Icons.minimize),
                  ),
                  Text(
                    quantita.toString(),
                  )
                ],
              )
            ],
          )
      ),
    );
  }

  void _aggiungiAlCarrello(){
    setState(() {
      loading=true;
    });
    Model.sharedInstance.aggiungiAlCarrello(prodotto.id!,quantita)?.then((result){
      setState(() {
        loading=false;
        quantita=0;
      });

      result==Constants.ERROR_QUANTITY_NOT_ENOUGH ?
      showDialog(
        context: context,
        builder: (context) => MessageDialog(
          titleText: AppLocalizations.of(context)!.translate("oops").toUpperCase(),
          bodyText: AppLocalizations.of(context)!.translate("product_unavailable"),
        ),
      ) :
          result==Constants.MESSAGE_CONNECTION_ERROR ?
          showDialog(
            context: context,
            builder: (context) => MessageDialog(
              titleText: AppLocalizations.of(context)!.translate("oops").toUpperCase(),
              bodyText: AppLocalizations.of(context)!.translate("internal_server_error"),
            ),
          )
              :
          showDialog(
            context: context,
            builder: (context) => MessageDialog(
              titleText: AppLocalizations.of(context)!.translate("ok").toUpperCase(),
              bodyText: AppLocalizations.of(context)!.translate("product_successfully_added"),
            ),
          );
    });
}

  void _aumenta(){
    setState(() {
      quantita++;
    });
  }
  void _diminuisci(){
    if(quantita==0)
      return;
    setState(() {
      quantita--;
    });
  }
}