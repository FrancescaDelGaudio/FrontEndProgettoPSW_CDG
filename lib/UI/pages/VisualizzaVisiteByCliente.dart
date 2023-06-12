
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Visita.dart';
import 'package:progetto_cozza_del_gaudio/model/support/Constants.dart';

import '../../model/Model.dart';
import '../behaviors/AppLocalizations.dart';
import '../widgets/InputField.dart';
import '../widgets/buttons/CircularIconButton.dart';
import '../widgets/dialogs/DettaglioMagazzinoCard.dart';
import '../widgets/dialogs/MessageDialog.dart';
import '../widgets/dialogs/VisitaCard.dart';

class VisualizzaVisiteByCliente extends StatefulWidget {
  int id;
  List<Visita> visite;
  String nome;

  VisualizzaVisiteByCliente({required this.id,required this.visite,required this.nome}) : super();

  @override
  _VisualizzaVisiteByClienteState createState() => _VisualizzaVisiteByClienteState(id,visite,nome);
}

class _VisualizzaVisiteByClienteState extends State<VisualizzaVisiteByCliente> {
  late List<Visita> listaVisite;
  late int id;
  late String nome;
  bool loading=false;

  _VisualizzaVisiteByClienteState(int id, List<Visita> visite, String nome) {
    this.listaVisite = visite;
    this.id=id;
    this.nome=nome;
  }
  TextEditingController _dateFiledController = TextEditingController();


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              loading == true ?
              CircularProgressIndicator() :
              Text(
                "Visite di "+nome,
                style: TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                itemCount: listaVisite?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                      children: [
                        VisitaCard(
                        visita: listaVisite![index]
                        ),
                        Expanded(
                          child:
                          Column(
                            children: [
                              InputField(
                                controller: _dateFiledController,
                                labelText: AppLocalizations.of(context)!.translate("booking_date").toUpperCase(),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(), //get today's date
                                      firstDate:DateTime.now(), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2024)
                                  );
                                  if(pickedDate != null ){
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                    setState(() {
                                      _dateFiledController.text = formattedDate; //set foratted date to TextField value.
                                    });
                                  }
                                },
                              ),
                              RawMaterialButton(
                                fillColor: Colors.blueAccent,
                                onPressed:(){ _prenota( id,listaVisite![index].id! ); },
                                shape: CircleBorder(),
                                elevation: 2.0,
                                child: Icon(
                                  Icons.bookmark,
                                ),
                                padding: EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  ),
              ],
          ),
        ),
      ),
    );
  }

  void _prenota(int idFarmacia,int idVisita) async{
    if(_dateFiledController.text.isEmpty){
      showDialog(
          context: context,
          builder: (context) => MessageDialog(
            titleText: AppLocalizations.of(context)!.translate("oops").toUpperCase(),
            bodyText: AppLocalizations.of(context)!.translate("all_fields_required"),
          )
      );
      return;
    }
    setState(() {
      loading = true;
    });
    String data = _dateFiledController.text;
    String dataFormattata= data.split("-")[2]+"-"+data.split("-")[1]+"-"+data.split("-")[0];
    Model.sharedInstance.visualizzaOrariPerVisita(idFarmacia,idVisita,dataFormattata)?.then((result) {
      setState(() {
        loading=false;
      });
      result!.first==Constants.MESSAGE_CONNECTION_ERROR ?
      showDialog(
        context: context,
        builder: (context) => MessageDialog(
          titleText: AppLocalizations.of(context)!.translate("oops").toUpperCase(),
          bodyText: AppLocalizations.of(context)!.translate("internal_server_error"),
        ),
      ) :
      result!.first==Constants.ERROR_DATE_INVALID ?
      showDialog(
        context: context,
        builder: (context) => MessageDialog(
          titleText: AppLocalizations.of(context)!.translate("oops").toUpperCase(),
          bodyText: AppLocalizations.of(context)!.translate("error_invalid_date"),
        ),
      ) :
      showDialog<String>(context: context, builder: (BuildContext context) => Dialog(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.builder(
                    itemCount: result?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                              result![index].toString()+"",
                          ),
                          RawMaterialButton(
                            fillColor: Colors.blueAccent,
                            onPressed:(){ _prenotaDef( id,idVisita,dataFormattata,result![index].toString()); },
                            shape: CircleBorder(),
                            elevation: 2.0,
                            child: Icon(
                              Icons.bookmark,
                            ),
                            padding: EdgeInsets.all(10),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            )
        )
        );
      });
    }

    void _prenotaDef(int idFarmacia, int idVisita, String data, String orario) async {
      setState(() {
        loading = true;
      });
      Model.sharedInstance.prenotaVisita(idFarmacia,idVisita,data,orario)?.then((result) {
        print(result+"aaaa");
        setState(() {
          loading=false;
        });
        result==Constants.MESSAGE_CONNECTION_ERROR ?
        showDialog(
          context: context,
          builder: (context) => MessageDialog(
            titleText: AppLocalizations.of(context)!.translate("oops").toUpperCase(),
            bodyText: AppLocalizations.of(context)!.translate("internal_server_error"),
          ),
        ) :
            result==Constants.ERROR_BOOKING_UNAVAILABLE ?
            showDialog(
              context: context,
              builder: (context) => MessageDialog(
                titleText: AppLocalizations.of(context)!.translate("oops").toUpperCase(),
                bodyText: AppLocalizations.of(context)!.translate("booking_unavailable"),
              ),
            ) :
            showDialog(
              context: context,
              builder: (context) => MessageDialog(
                titleText: AppLocalizations.of(context)!.translate("ok").toUpperCase(),
                bodyText: AppLocalizations.of(context)!.translate("booking_successfully_completed"),
              ),
            );
        });
    }
  }



