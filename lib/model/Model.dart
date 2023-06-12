import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:progetto_cozza_del_gaudio/model/managers/RestManager.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/AuthenticationData.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/DettaglioMagazzino.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Farmacia.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Prodotto.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Cliente.dart';
import 'package:progetto_cozza_del_gaudio/model/support/Constants.dart';
import 'package:progetto_cozza_del_gaudio/model/support/LogInResult.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'objects/Appuntamento.dart';
import 'objects/Visita.dart';


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

  Future<String> addCliente(Cliente cliente) async {
    try {
      String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_ADD_CLIENTE, cliente);
      if ( rawResult.contains(Constants.RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS) ) {
        return Constants.RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS;
      }
      else if(rawResult.contains(Constants.MESSAGE_CONNECTION_ERROR)){
        return Constants.MESSAGE_CONNECTION_ERROR;
      }
      else
        return Cliente.fromJson(jsonDecode(rawResult)).codiceFiscale;
    }
    catch (e) {
      return Constants.MESSAGE_CONNECTION_ERROR;
    }
  }

  Future<String> addFarmacia(Farmacia farmacia) async {
    try {
      String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_ADD_FARMACIA, farmacia);
      if ( rawResult.contains(Constants.RESPONSE_ERROR_MAIL_PHARMACY_ALREADY_EXISTS) )
        return Constants.RESPONSE_ERROR_MAIL_PHARMACY_ALREADY_EXISTS;
      else if(rawResult.contains(Constants.MESSAGE_CONNECTION_ERROR))
        return Constants.MESSAGE_CONNECTION_ERROR;
      else
        return Farmacia.fromJson(jsonDecode(rawResult)).partitaIva;
    }
    catch (e) {
      return Constants.MESSAGE_CONNECTION_ERROR;
    }
  }

  Future<List<DettaglioMagazzino>?>? visualizzaMagazzino() async {
    try {
      return List<DettaglioMagazzino>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_VIEW_MAGAZZINO)).map((i) => DettaglioMagazzino.fromJson(i)).toList());
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<List<DettaglioMagazzino>?>? visualizzaMagazzinoByCliente(int id) async {
    try {
      return List<DettaglioMagazzino>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_VIEW_FARMACIE+"/"+id.toString()+ Constants.REQUEST_VIEW_MAGAZZINO_BY_CLIENTE)).map((i) => DettaglioMagazzino.fromJson(i)).toList());
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<List<Visita>?>? visualizzaVisiteByCliente(int id) async {
    try {
      return List<Visita>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_VIEW_FARMACIE+"/"+id.toString()+ Constants.REQUEST_VIEW_VISITE_BY_CLIENTE)).map((i) => Visita.fromJson(i)).toList());
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<List<String?>?> visualizzaOrariPerVisita(int idFarmacia, int idVisita,String data) async{
    List<String> ret=List.empty(growable: true);
    try {
      String rawResult =  await _restManager.makeGetRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_VIEW_FARMACIE+"/"+idFarmacia.toString()+Constants.REQUEST_VIEW_VISITE_BY_CLIENTE+"/"+idVisita.toString()+"/"+data+Constants.REQUEST_VIEW_AVAILABLE_TIME);

      if(rawResult==Constants.MESSAGE_CONNECTION_ERROR) {
        ret.add(Constants.MESSAGE_CONNECTION_ERROR);
        return ret;
      }
      else if(rawResult==Constants.ERROR_DATE_INVALID) {
        ret.add(Constants.ERROR_DATE_INVALID);
        return ret;
      }
      return List<String>.from(json.decode(rawResult).map((i) => (i)).toList());
    }
    catch (e) {
      ret.add(Constants.MESSAGE_CONNECTION_ERROR);
      return ret;
    }
  }

  Future<String>? prenotaVisita(int idFarmacia,int idVisita,String data,String orario) async{
    try{
      print(orario);
      String rawResult = await _restManager.makePutRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_VIEW_FARMACIE+"/"+idFarmacia.toString()+Constants.REQUEST_VIEW_VISITE_BY_CLIENTE+"/"+idVisita.toString()+"/"+data+"/"+orario+Constants.REQUEST_VIEW_BOOK);
      if(rawResult==Constants.MESSAGE_CONNECTION_ERROR) {
        return Constants.MESSAGE_CONNECTION_ERROR;
      }
      else if(rawResult==Constants.ERROR_BOOKING_UNAVAILABLE) {
        return Constants.ERROR_BOOKING_UNAVAILABLE;
      }
      return "";
    }catch (e) {
      return Constants.MESSAGE_CONNECTION_ERROR;
    }
  }

  Future<List<Appuntamento>?>? visualizzaPrenotazioniByCliente() async {
    try {
      return List<Appuntamento>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_VIEW_CLIENTE+Constants.REQUEST_VIEW_BOOKINGS_BY_CLIENTE)).map((i) => Appuntamento.fromJson(i)).toList());
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<Cliente?>? trovaCliente() async {
    try{
      String rawResult = await _restManager.makeGetRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_VIEW_CLIENTE);
      return Cliente.fromJson(jsonDecode(rawResult));
    }catch (e) {
      return null; // not the best solution
    }
  }

  Future<Farmacia?>? trovaFarmacia() async {
    try{
      String rawResult = await _restManager.makeGetRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_VIEW_FARMACIA);
      return Farmacia.fromJson(jsonDecode(rawResult));
    }catch (e) {
      return null; // not the best solution
    }
  }

  Future<Cliente?>? modificaCitta(String citta) async {
    Map<String, String> params = Map();
    params["citta"] = citta;
    try{
      String rawResult = await _restManager.makePutRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_MODIFY_CLIENTE_CITTA, params);
      return Cliente.fromJson(jsonDecode(rawResult));
    }catch (e) {
      return null; // not the best solution
    }
  }

  Future<Cliente?>? modificaIndirizzoCliente(String indirizzo) async {
    Map<String, String> params = Map();
    params["indirizzo"] = indirizzo;
    try{
      String rawResult = await _restManager.makePutRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_MODIFY_CLIENTE_INDIRIZZO,params);
      return Cliente.fromJson(jsonDecode(rawResult));
    }catch (e) {
      return null; // not the best solution
    }
  }

  Future<String?>? disdiciAppuntamento(int id) async {
    Map<String, String> params = Map();
    params["id"] = id.toString();
    try{
      String rawResult = await _restManager.makeDeleteRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_VIEW_CLIENTE+Constants.REQUEST_VIEW_BOOKINGS_BY_CLIENTE,params);
      print(rawResult+"ciao");
      return rawResult;
    }catch (e) {
      return Constants.MESSAGE_CONNECTION_ERROR; // not the best solution
    }
  }

  Future<Farmacia?>? modificaNome(String nome) async {
    Map<String, String> params = Map();
    params["nome"] = nome;
    try{
      String rawResult = await _restManager.makePutRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_MODIFY_FARMACIA_NOME, params);
      return Farmacia.fromJson(jsonDecode(rawResult));
    }catch (e) {
      return null; // not the best solution
    }
  }

  Future<Farmacia?>? modificaIndirizzoFarmacia(String indirizzo) async {
    Map<String, String> params = Map();
    params["indirizzo"] = indirizzo;
    try{
      String rawResult = await _restManager.makePutRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_MODIFY_FARMACIA_INDIRIZZO, params);
      return Farmacia.fromJson(jsonDecode(rawResult));
    }catch (e) {
      return null; // not the best solution
    }
  }

  Future<List<Farmacia>?>? visualizzaFarmacie(int pageNumber) async {
    Map<String, String> params = Map();
    params["pageNumber"] =pageNumber.toString();
    try {
      return List<Farmacia>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_VIEW_FARMACIE, params)).map((i) => Farmacia.fromJson(i)).toList());
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<List<Farmacia>?>? visualizzaFarmaciePerCitta(String citta) async {
    try {
      return List<Farmacia>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_SF_SERVER, Constants.REQUEST_VIEW_FARMACIE+"/"+citta)).map((i) => Farmacia.fromJson(i)).toList());
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  // verifica ruolo utente

  List<dynamic> _getListaRuoli(){
    Map<String, dynamic> decodedToken = JwtDecoder.decode(_authenticationData!.accessToken!);
    List<dynamic> listaRuoli= decodedToken["resource_access"][Constants.CLIENT_ID]["roles"];
    return listaRuoli;
  }

  bool eCliente(){
    if(_authenticationData!.accessToken==null)
      return false;
    List<dynamic> listaRuoli= _getListaRuoli();
    if(listaRuoli.contains(Constants.RUOLO_CLIENTE))
      return true;
    return false;
  }

  bool eFarmacia(){
    if(_authenticationData!.accessToken==null)
      return false;
    List<dynamic> listaRuoli= _getListaRuoli();
    if(listaRuoli.contains(Constants.RUOLO_FARMACIA))
      return true;
    return false;
  }

  bool eGestore(){
    if(_authenticationData!.accessToken==null)
      return false;
    List<dynamic> listaRuoli= _getListaRuoli();
    if(listaRuoli.contains(Constants.RUOLO_GESTORE))
      return true;
    return false;
  }

  bool eAdmin(){
    if(_authenticationData!.accessToken==null)
      return false;
    List<dynamic> listaRuoli= _getListaRuoli();
    if(listaRuoli.contains(Constants.RUOLO_ADMIN))
      return true;
    return false;
  }





}
