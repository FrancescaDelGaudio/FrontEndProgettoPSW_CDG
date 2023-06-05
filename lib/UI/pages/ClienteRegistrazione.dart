import 'package:intl/intl.dart';
import 'package:progetto_cozza_del_gaudio/UI/behaviors/AppLocalizations.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/buttons/CircularIconButton.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/InputField.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/dialogs/MessageDialog.dart';
import 'package:progetto_cozza_del_gaudio/model/Model.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Cliente.dart';
import 'package:flutter/material.dart';


class ClienteRegistration extends StatefulWidget {
  ClienteRegistration() : super();


  @override
  _ClienteRegistrationState createState() => _ClienteRegistrationState();
}

class _ClienteRegistrationState extends State<ClienteRegistration> {
  bool _adding = false;
  Cliente? _justAddedUser;

  TextEditingController _firstNameFiledController = TextEditingController();
  TextEditingController _lastNameFiledController = TextEditingController();
  TextEditingController _idCodeFiledController = TextEditingController();
  TextEditingController _addressFiledController = TextEditingController();
  TextEditingController _dateBirthFiledController = TextEditingController();
  TextEditingController _passwordFiledController = TextEditingController();


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
                    labelText: AppLocalizations.of(context)!.translate("firstName").toUpperCase(),
                    controller: _firstNameFiledController,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    labelText: AppLocalizations.of(context)!.translate("lastName").toUpperCase(),
                    controller: _lastNameFiledController,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    labelText: AppLocalizations.of(context)!.translate("codiceFiscale").toUpperCase(),
                    controller: _idCodeFiledController,
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context)!.translate("password").toUpperCase(),
                    controller: _passwordFiledController,
                    isPassword: true,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    labelText: AppLocalizations.of(context)!.translate("address").toUpperCase(),
                    controller: _addressFiledController,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    controller: _dateBirthFiledController,
                    labelText: AppLocalizations.of(context)!.translate("dateOfBirth").toUpperCase(),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate:DateTime(1950), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2024)
                      );
                      if(pickedDate != null ){
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                        setState(() {
                          _dateBirthFiledController.text = formattedDate; //set foratted date to TextField value.
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
                      if(_idCodeFiledController.text.isEmpty || _passwordFiledController.text.isEmpty ) {
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
                      else
                        _register();
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
                          AppLocalizations.of(context)!.translate("just_added") + ":" + _justAddedUser!.codiceFiscale + "!"
                      ) :
                      Text( AppLocalizations.of(context)!.translate("user_already_exists")),
                      //SizedBox.shrink(),
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

    Cliente cliente = Cliente(
      nome: _firstNameFiledController.text,
      cognome: _lastNameFiledController.text,
      codiceFiscale: _idCodeFiledController.text,
      indirizzo: _addressFiledController.text,
      dataNascita: _dateBirthFiledController.text=="" ? null : DateTime.parse(_dateBirthFiledController.text),
      password: _passwordFiledController.text,
    );
    Model.sharedInstance.addCliente(cliente)?.then((result) {
      setState(() {
        _adding = false;
        _justAddedUser = result;
      });
    });
  }
}
