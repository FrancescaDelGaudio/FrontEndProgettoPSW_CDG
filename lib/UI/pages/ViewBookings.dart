import 'package:progetto_cozza_del_gaudio/UI/behaviors/AppLocalizations.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/InputField.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/buttons/CircularIconButton.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/dialogs/FarmaciaCard.dart';
import 'package:progetto_cozza_del_gaudio/model/Model.dart';
import 'package:flutter/material.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Farmacia.dart';
import 'package:progetto_cozza_del_gaudio/model/support/Constants.dart';

import '../../model/objects/Appuntamento.dart';
import '../widgets/dialogs/MessageDialog.dart';
import '../widgets/dialogs/PrenotazioneCard.dart';


class ViewBookings extends StatefulWidget {
  ViewBookings() : super();

  @override
  _ViewBookingsState createState() => _ViewBookingsState();
}

class _ViewBookingsState extends State<ViewBookings> {
  bool _loading = true;
  List<Appuntamento>? _app;

  void initState() {  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    _recuperaPrenotazioni();
  },
  );
  }

  Widget build(BuildContext context) {
     //così ricarica ad ogni disdici
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Center(
                child: Column(
                    children: [
                      _loading == true ?
                      CircularProgressIndicator() :
                      Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .translate("your_bookings")
                                .toUpperCase(),
                            style: TextStyle(
                              fontFamily: "Pacifico",
                              fontSize: 30,
                              color: Colors.lightGreen,
                            ),
                          ),
                          const SizedBox(height:15),
                          ListView.builder(
                            itemCount: _app?.length ?? 0,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(child:
                                    PrenotazioneCard(
                                      prenotazione: _app![index]
                                    ),
                                  ),
                                    Column(
                                      children: [
                                        RawMaterialButton(
                                          fillColor: Colors.blueAccent,
                                          onPressed:(){ _disdici( _app![index].id ); },
                                          shape: CircleBorder(),
                                          elevation: 2.0,
                                          child: Icon(
                                              Icons.highlight_remove_outlined
                                          ),
                                          padding: EdgeInsets.all(10),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .translate("cancel")
                                              .toUpperCase(),
                                          style: TextStyle(
                                            fontFamily: "Pacifico",
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),

                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ]
                )
            )
        )
    );
  }

  void _recuperaPrenotazioni() {
    Model.sharedInstance.visualizzaPrenotazioniByCliente()?.then((result) {
      print(result);
      setState(() {
        _loading = false;
        _app = result;
      });
    });
  }

  void _disdici(int id) {
    setState(() {
      _loading = true;
    });
    Model.sharedInstance.disdiciAppuntamento(id)?.then((result) {
      result!.isEmpty ?
        showDialog(
          context: context,
          builder: (context) => MessageDialog(
            titleText: AppLocalizations.of(context)!.translate("ok").toUpperCase(),
            bodyText: AppLocalizations.of(context)!.translate("operation_completed_successfully"),
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
          titleText: AppLocalizations.of(context)!.translate("oops").toUpperCase(),
          bodyText: AppLocalizations.of(context)!.translate("not_annullable"),
          ),
        );
      _recuperaPrenotazioni();
    });
  }
}