import 'package:progetto_cozza_del_gaudio/UI/behaviors/AppLocalizations.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/InputField.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/buttons/CircularIconButton.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/dialogs/FarmaciaCard.dart';
import 'package:progetto_cozza_del_gaudio/model/Model.dart';
import 'package:flutter/material.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Farmacia.dart';


class ViewPharmacies extends StatefulWidget {
  ViewPharmacies() : super();

  @override
  _ViewPharmaciesState createState() => _ViewPharmaciesState();
}

class _ViewPharmaciesState extends State<ViewPharmacies> {
  bool _loading = true;
  bool _cercaXcitta=false;
  int _numberPage=0;
  List<Farmacia>? _farmacie;

  TextEditingController _cityFiledController = TextEditingController();

  void initState() {  super.initState();
  WidgetsBinding.instance.addPostFrameCallback(    (timeStamp) {
      _recuperaFarmacia();
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
                _loading==true ?
                  CircularProgressIndicator() :
                _farmacie==null ?
                  Text(
                    AppLocalizations.of(context)!.translate("interal_server_error").toUpperCase(),
                  ) :
                  Row(
                    children: [
                      Flexible(
                        child:
                          InputField(
                            controller: _cityFiledController,
                            labelText: AppLocalizations.of(context)!.translate("find_by_city").toUpperCase(),
                          ),
                      ),
                      CircularIconButton(
                        icon: Icons.search,
                        onPressed: () {_cercaConCitta();},
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    itemCount: _farmacie?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return FarmaciaCard(
                          farmacia: _farmacie![index]
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _cercaXcitta==false ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RawMaterialButton(
                        fillColor: Colors.blueAccent,
                        onPressed:(){ _retrocediDiPagina(); },
                        shape: LinearBorder(),
                        elevation: 2.0,
                        child: Icon(
                            Icons.arrow_back_ios
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                      RawMaterialButton(
                        fillColor: Colors.blueAccent,
                        onPressed:(){ _avanzaDiPagina(); },
                        shape: LinearBorder(),
                        elevation: 2.0,
                        child: Icon(
                          Icons.arrow_forward_ios,
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ],
                  ) :
                  RawMaterialButton(
                      fillColor: Colors.blueAccent,
                      onPressed:(){ _recuperaFarmacia(); },
                      shape: LinearBorder(),
                      elevation: 2.0,
                      child: Icon(
                      Icons.reply_all
                      ),
                      padding: EdgeInsets.all(10),
                  ),

            ]
          )
        )
      )
    );
  }

  void _recuperaFarmacia() async{
    Model.sharedInstance.visualizzaFarmacie(_numberPage)?.then((result) {
      setState(() {
        _loading = false;
        _farmacie = result;
        _cercaXcitta=false;
      });
    });
  }

  void _avanzaDiPagina() async{
    setState(() {
      _numberPage+=1;
      _loading=true;
    });
    Model.sharedInstance.visualizzaFarmacie(_numberPage)?.then((result) {
      setState(() {
        _loading = false;
        _farmacie = result;
      });
    });
  }

  void _retrocediDiPagina() async {
    if(_numberPage==0)
      return;
    setState(() {
      _numberPage-=1;
      _loading=true;
    });
    Model.sharedInstance.visualizzaFarmacie(_numberPage)?.then((result) {
      setState(() {
        _loading = false;
        _farmacie = result;
      });
    });
  }

  void _cercaConCitta() async{
    if(_cityFiledController.text==null || _cityFiledController.text.isEmpty)
      return;

      setState(() {
        _loading=true;
        _cercaXcitta=true;
      });

      Model.sharedInstance.visualizzaFarmaciePerCitta(_cityFiledController.text)?.then((result) {
        setState(() {
          _loading = false;
          _farmacie = result;
          _cityFiledController.clear();
        });
      });

  }
}