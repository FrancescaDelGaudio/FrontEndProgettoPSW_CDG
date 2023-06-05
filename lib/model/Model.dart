import 'dart:async';
import 'dart:convert';
import 'package:progetto_cozza_del_gaudio/model/managers/RestManager.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/AuthenticationData.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/DettaglioMagazzino.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Farmacia.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Prodotto.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Cliente.dart';
import 'package:progetto_cozza_del_gaudio/model/support/Constants.dart';
import 'package:progetto_cozza_del_gaudio/model/support/LogInResult.dart';


class Model {
  static Model sharedInstance = Model();

  RestManager _restManager = RestManager();
  AuthenticationData? _authenticationData;


  Future<LogInResult> logIn(String email, String password) async {
    try{
      Map<String, String> params = Map();
      params["grant_type"] = "password";
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["username"] = email;
      params["password"] = password;
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if ( _authenticationData!.hasError() ) {
        if ( _authenticationData!.error == "Invalid user credentials" ) {
          return LogInResult.error_wrong_credentials;
        }
        else if ( _authenticationData!.error == "Account is not fully set up" ) {
          return LogInResult.error_not_fully_setupped;
        }
        else {
          return LogInResult.error_unknown;
        }
      }
      _restManager.token = _authenticationData!.accessToken;
      Timer.periodic(Duration(seconds: (_authenticationData!.expiresIn! - 50)), (Timer t) {
        _refreshToken();
      });
      return LogInResult.logged;
    }
    catch (e) {
      return LogInResult.error_unknown;
    }
  }

  Future<bool> _refreshToken() async {
    try {
      Map<String, String> params = Map();
      params["grant_type"] = "refresh_token";
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _authenticationData!.refreshToken!;
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if ( _authenticationData!.hasError() ) {
        return false;
      }
      _restManager.token = _authenticationData!.accessToken;
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<bool> logOut() async {
    try{
      Map<String, String> params = Map();
      _restManager.token = null;
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _authenticationData!.refreshToken!;
      await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGOUT, params, type: TypeHeader.urlencoded);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<List<Prodotto>?>? searchProdotto(String name) async {
    Map<String, String> params = Map();
    params["name"] = name;
    try {
      return List<Prodotto>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_VIEW_PRODOTTI, params)).map((i) => Prodotto.fromJson(i)).toList());
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<Cliente?>? addCliente(Cliente cliente) async {
    try {
      String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_ADD_CLIENTE, cliente);
      if ( rawResult.contains(Constants.RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS) ) {
        return null; // not the best solution
      }
      else {
        return Cliente.fromJson(jsonDecode(rawResult));
      }
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<Farmacia?>? addFarmacia(Farmacia farmacia) async {
    try {
      String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_ADD_FARMACIA, farmacia);
      if ( rawResult.contains(Constants.RESPONSE_ERROR_MAIL_PHARMACY_ALREADY_EXISTS) ) {
        return null; // not the best solution
      }
      else {
        return Farmacia.fromJson(jsonDecode(rawResult));
      }
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<List<DettaglioMagazzino>?>? visualizzaMagazzino() async {
    try {
      return List<DettaglioMagazzino>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_VIEW_MAGAZZINO)).map((i) => DettaglioMagazzino.fromJson(i)).toList());
    }
    catch (e) {
      print(e.toString());
      return null; // not the best solution
    }
  }


}
