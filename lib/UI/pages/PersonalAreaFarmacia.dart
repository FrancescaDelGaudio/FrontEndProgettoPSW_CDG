import 'package:progetto_cozza_del_gaudio/UI/widgets/InputField.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/buttons/CircularIconButton.dart';
import 'package:progetto_cozza_del_gaudio/model/Model.dart';
import 'package:flutter/material.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Farmacia.dart';

import '../behaviors/AppLocalizations.dart';


class PersonalAreaFarmacia extends StatefulWidget {
  PersonalAreaFarmacia() : super();

  @override
  _PersonalAreaFarmaciaState createState() => _PersonalAreaFarmaciaState();
}

class _PersonalAreaFarmaciaState extends State<PersonalAreaFarmacia> {
  bool _loading = true;
  Farmacia? _farmacia;

  TextEditingController _nomeFiledController=TextEditingController();
  TextEditingController _indirizzoFiledController=TextEditingController();

  void initState() {  super.initState();
    WidgetsBinding.instance.addPostFrameCallback(    (timeStamp) {
      _recuperaFarmacia();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _loading==true ?
              CircularProgressIndicator():
              _farmacia==null ?
              Text(
                AppLocalizations.of(context)!.translate("internal_server_error").toUpperCase(),
              ):
              Text('Area Personale',
                style: TextStyle(
                    fontFamily: "Pacifico",
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child:
                Text('Nome: ',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: Text(
                    _farmacia?.nome ?? " ",
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              CircularIconButton(icon: Icons.mode, onPressed: () {_mostraModificaNome();},),
              const SizedBox(height: 40),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child:
                Text('Partita Iva: ',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.perm_identity,
                    color: Colors.black,
                  ),
                  title: Text(
                    _farmacia?.partitaIva ?? " ",
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child:
                Text('Citta: ',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.location_city,
                    color: Colors.black,
                  ),
                  title: Text(
                    _farmacia?.citta ?? " ",
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child:
                Text('Indirizzo: ',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.broadcast_on_personal_rounded,
                    color: Colors.black,
                  ),
                  title: Text(
                    _farmacia?.indirizzo ?? " ",
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              CircularIconButton(icon: Icons.mode, onPressed: () {_mostraModificaIndirizzo();},),
              const SizedBox(height: 40),

              Align(
                alignment: Alignment.centerLeft,
                child:
                Text('Budget: ',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.monetization_on,
                    color: Colors.black,
                  ),
                  title: Text(
                    _farmacia?.budget.toString() ?? "0.0",
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child:
                Text('Numero di Dipendenti: ',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.people_alt,
                    color: Colors.black,
                  ),
                  title: Text(
                    _farmacia?.budget.toString() ?? "",
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child:
                Text('Orario Inizio Visite: ',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.timelapse,
                    color: Colors.black,
                  ),
                  title: Text(
                    _farmacia?.orarioInizioVisite.toString().split("(")[1].split(")")[0] ?? " ",
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child:
                Text('Orario Fine Visite: ',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.timelapse_rounded,
                    color: Colors.black,
                  ),
                  title: Text(
                    _farmacia?.orarioFineVisite.toString().split("(")[1].split(")")[0] ?? " ",
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _recuperaFarmacia() async  {
    Model.sharedInstance.trovaFarmacia()?.then((result) {
      setState(() {
        _loading = false;
        _farmacia = result;
      });
    });
  }

  void _mostraModificaNome(){
    showDialog<String>(context: context, builder: (BuildContext context) => Dialog(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputField(
                labelText: "Modifica nome",
                controller: _nomeFiledController,
              ),
              CircularIconButton(
                icon: Icons.check,
                onPressed:() { _cambiaNome(_nomeFiledController.text); },
              ),
              const SizedBox(height:15),
            ],
          ),
        )
    )
    );
  }

  void _mostraModificaIndirizzo(){
    showDialog<String>(context: context, builder: (BuildContext context) => Dialog(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputField(
                labelText: "Modifica indirizzo",
                controller: _indirizzoFiledController,
              ),
              CircularIconButton(
                icon: Icons.check,
                onPressed:() { _cambiaIndirizzo(_indirizzoFiledController.text); },
              ),
              const SizedBox(height:15),
            ],
          ),
        )
    )
    );
  }

  void _cambiaNome(String citta) {
    Model.sharedInstance.modificaNome(citta)?.then((result) {
      setState(() {
        _farmacia = result;
        print(_farmacia!.citta);
      });
    });
  }


  void _cambiaIndirizzo(String indirizzo) {
    Model.sharedInstance.modificaIndirizzoFarmacia(indirizzo)?.then((result) {
      setState(() {
        _farmacia = result;
      });
    });
  }
}