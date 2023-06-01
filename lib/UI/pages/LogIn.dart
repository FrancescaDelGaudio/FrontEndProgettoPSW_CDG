import 'package:progetto_cozza_del_gaudio/UI/pages/Home.dart';
import 'package:progetto_cozza_del_gaudio/model/Model.dart';
import 'package:progetto_cozza_del_gaudio/model/support/extensions/StringCapitalization.dart';
import 'package:progetto_cozza_del_gaudio/UI/behaviors/AppLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/support/Constants.dart';
import '../../model/support/LogInResult.dart';
import '../widgets/buttons/ExpandableLoginButton.dart';
import '../widgets/dialogs/MessageDialog.dart';


class LogIn extends StatefulWidget {
  LogIn() : super();

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  void refreshState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _isLoading ?
          Center(
            child: CircularProgressIndicator(),
          ) :
          Padding(padding: EdgeInsets.all(0)),
          SingleChildScrollView(
            child: IgnorePointer(
              ignoring: _isLoading,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                      child: Text(
                          AppLocalizations.of(context)!.translate("log_in"),
                          textAlign: TextAlign.center,
                          textScaleFactor: 3,
                          selectionColor: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ExpandableLogInButton(
                      textOuterButton: AppLocalizations.of(context)!.translate("log_in"),
                      onSubmit: (String email, String password) async {
                        setState(() {
                          _isLoading = true;
                        });
                        if ( email == null || email == "" || password == null || password == "" ) {
                          showDialog(
                            context: context,
                            builder: (context) => MessageDialog(
                              titleText: AppLocalizations.of(context)!.translate("oops").capitalize,
                              bodyText: AppLocalizations.of(context)!.translate("all_fields_required").capitalize,
                            ),
                          );
                          setState(() {
                            _isLoading = false;
                          });
                          return;
                        }
                        LogInResult result = await Model.sharedInstance.logIn(email, password);
                        setState(() {
                          _isLoading = false;
                        });
                        if ( result == LogInResult.logged ) {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                                opaque: false,
                                transitionDuration: Duration(milliseconds: 700),
                                pageBuilder: (BuildContext context, _, __) => Home()
                            ),
                          );
                        }
                        else if ( result == LogInResult.error_wrong_credentials ) {
                          showDialog(
                            context: context,
                            builder: (context) => MessageDialog(
                              titleText: AppLocalizations.of(context)!.translate("oops").capitalize,
                              bodyText: AppLocalizations.of(context)!.translate("user_or_password_wrong"),
                            ),
                          );
                        }
                        else if ( result == LogInResult.error_not_fully_setupped ) {
                          await launch(Constants.LINK_FIRST_SETUP_PASSWORD);
                        }
                        else {
                          showDialog(
                            context: context,
                            builder: (context) => MessageDialog(
                              titleText: AppLocalizations.of(context)!.translate("oops").capitalize,
                              bodyText: AppLocalizations.of(context)!.translate("unknown_error"),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
