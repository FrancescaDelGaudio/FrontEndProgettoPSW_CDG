import 'package:intl/intl.dart';
import 'package:progetto_cozza_del_gaudio/UI/behaviors/AppLocalizations.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/buttons/CircularIconButton.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/InputField.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/dialogs/MessageDialog.dart';
import 'package:progetto_cozza_del_gaudio/model/Model.dart';
import 'package:flutter/material.dart';

import '../../model/objects/Farmacia.dart';


class FarmaciaRegistration extends StatefulWidget {
  FarmaciaRegistration() : super();


  @override
  _FarmaciaRegistrationState createState() => _FarmaciaRegistrationState();
}

class _FarmaciaRegistrationState extends State<FarmaciaRegistration> {
  bool _adding = false;
  Farmacia? _justAddedUser;

  TextEditingController _nameFiledController = TextEditingController();
  TextEditingController _vatNumberFiledController = TextEditingController();
  TextEditingController _cityFiledController = TextEditingController();
  TextEditingController _addressFiledController = TextEditingController();
  TextEditingController _budgetFiledController = TextEditingController();
  TextEditingController _numberOfEmployeesFiledController = TextEditingController();
  TextEditingController _timeStartingVisitsFiledController= TextEditingController();
  TextEditingController _timeEndingVisitsFiledController= TextEditingController();
  TextEditingController _passwordFiledController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                AppLocalizations.of(context)!.translate("register").toUpperCase(),
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                children: [
                  InputField(
                    labelText: AppLocalizations.of(context)!.translate("name").toUpperCase(),
                    controller: _nameFiledController,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    labelText: AppLocalizations.of(context)!.translate("partitaIva").toUpperCase(),
                    controller: _vatNumberFiledController,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    labelText: AppLocalizations.of(context)!.translate("password").toUpperCase(),
                    controller: _passwordFiledController,
                    isPassword: true,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    labelText: AppLocalizations.of(context)!.translate("city").toUpperCase(),
                    controller: _cityFiledController,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    labelText: AppLocalizations.of(context)!.translate("address").toUpperCase(),
                    controller: _addressFiledController,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    labelText: AppLocalizations.of(context)!.translate("budget").toUpperCase(),
                    controller: _budgetFiledController,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    labelText: AppLocalizations.of(context)!.translate("number_of_employees").toUpperCase(),
                    controller: _numberOfEmployeesFiledController,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    controller: _timeStartingVisitsFiledController,
                    labelText: AppLocalizations.of(context)!.translate("time_starting_visits").toUpperCase(),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                      );
                      if(pickedTime != null ){
                        print(pickedTime);  //get the picked date in the format => 2022-07-04 00:00:00.000
                        String formattedTime;
                        String ora=pickedTime.hour.toString();
                        String minuti=pickedTime.minute.toString();
                        formattedTime=ora+":"+minuti;
                        print(formattedTime);
                        setState(() {
                          _timeStartingVisitsFiledController.text = formattedTime; //set foratted date to TextField value.
                        });
                      }else{
                        print("Date is not selected");
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    controller: _timeEndingVisitsFiledController,
                    labelText: AppLocalizations.of(context)!.translate("time_ending_visits").toUpperCase(),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if(pickedTime != null ){
                        print(pickedTime);  //get the picked date in the format => 2022-07-04 00:00:00.000
                        String formattedTime;
                        String ora=pickedTime.hour.toString();
                        String minuti=pickedTime.minute.toString();
                        formattedTime=ora+":"+minuti;
                        print(formattedTime);
                        setState(() {
                          _timeEndingVisitsFiledController.text = formattedTime; //set foratted date to TextField value.
                        });
                      }else{
                        print("Date is not selected");
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  CircularIconButton(
                    icon: Icons.person_rounded,
                    onPressed: () {
                      if(_vatNumberFiledController.text.isEmpty || _budgetFiledController.text.isEmpty || _numberOfEmployeesFiledController.text.isEmpty
                      || _timeStartingVisitsFiledController.text.isEmpty || _timeEndingVisitsFiledController.text.isEmpty
                      || _passwordFiledController.text.isEmpty || _nameFiledController.text.isEmpty ) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              MessageDialog(
                                titleText: AppLocalizations.of(context)!
                                    .translate("oops")
                                    .toUpperCase(),
                                bodyText: AppLocalizations.of(context)!.translate(
                                    "all_star_field_required").toUpperCase(),
                              ),
                        );
                        setState(() {
                          _adding = false;
                          _justAddedUser = null;
                        });
                      }
                      else {
                        _register();
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: _adding ?
                      CircularProgressIndicator() :
                      _justAddedUser != null ?
                      Text(
                          AppLocalizations.of(context)!.translate("just_added") + ":" + _justAddedUser!.partitaIva + "!"
                      ):
                      Text(
                          AppLocalizations.of(context)!.translate("pharmacy_already_exists")
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _register() {
    setState(() {
      _adding = true;
      _justAddedUser = null;
    });

    Farmacia farmacia = Farmacia(
      nome: _nameFiledController.text,
      partitaIva : _vatNumberFiledController.text,
      citta: _cityFiledController.text,
      indirizzo: _addressFiledController.text,
      budget: double.parse(_budgetFiledController.text),
      numDipendenti:int.parse(_numberOfEmployeesFiledController.text),
      orarioFineVisite:TimeOfDay(hour:int.parse(_timeEndingVisitsFiledController.text.split(":")[0]),minute: int.parse(_timeEndingVisitsFiledController.text.split(":")[1])),
      orarioInizioVisite:TimeOfDay(hour:int.parse(_timeStartingVisitsFiledController.text.split(":")[0]),minute: int.parse(_timeStartingVisitsFiledController.text.split(":")[1])),
      password: _passwordFiledController.text,
    );
    Model.sharedInstance.addFarmacia(farmacia)?.then((result) {
      setState(() {
        _adding = false;
        _justAddedUser = result;
      });
    });
  }

}