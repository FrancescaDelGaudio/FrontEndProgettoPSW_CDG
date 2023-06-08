class Constants {
  // app info
  static final String APP_VERSION = "0.0.1";
  static final String APP_NAME = "SISTEMA FARMACEUTICO";

  // addresses
  static final String ADDRESS_SF_SERVER = "localhost:8081";
  static final String ADDRESS_AUTHENTICATION_SERVER = "localhost:8080";

  // authentication
  static final String REALM = "sistemaFarmaceutico-realm";
  static final String CLIENT_ID = "admin-client";
  static final String CLIENT_SECRET = "7F2SaVRzPa0g2Oezue0OXVe4l5kj3s4r";
  static final String REQUEST_LOGIN = "/realms/" + REALM + "/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT = "/realms/" + REALM + "/protocol/openid-connect/logout";
  static final String RUOLO_FARMACIA="farmacia";
  static final String RUOLO_CLIENTE="cliente";
  static final String RUOLO_GESTORE="gestore";
  static final String RUOLO_ADMIN="admin";

  // requests
  static final String REQUEST_VIEW_CLIENTE= "/cliente";
  static final String REQUEST_VIEW_FARMACIA="/farmacia";
  static final String REQUEST_VIEW_FARMACIE="/farmacie";
  static final String REQUEST_VIEW_MAGAZZINO_BY_CLIENTE="/magazzino";
  static final String REQUEST_VIEW_VISITE_BY_CLIENTE="/visite";
  static final String REQUEST_MODIFY_CLIENTE_CITTA="/cliente/modificaCitta";
  static final String REQUEST_MODIFY_CLIENTE_INDIRIZZO="/cliente/modificaIndirizzo";
  static final String REQUEST_MODIFY_FARMACIA_NOME="/farmacia/modificaNome";
  static final String REQUEST_MODIFY_FARMACIA_INDIRIZZO="/farmacia/modificaIndirizzo";
  static final String REQUEST_VIEW_PRODOTTI = "/prodotti";
  static final String REQUEST_VIEW_MAGAZZINO = "/farmacia/magazzino";
  static final String REGISTRAZIONE="/registrazione";
  static final String REQUEST_ADD_CLIENTE = REGISTRAZIONE+"/cliente";
  static final String REQUEST_ADD_FARMACIA = REGISTRAZIONE+"/farmacia";
  //static final String REQUEST_ADD_GESTORE = "/gestore";

  // states
  static final String STATE_CLUB = "club";

  // responses
  static final String RESPONSE_ERROR_MAIL_PHARMACY_ALREADY_EXISTS = "ERROR_MAIL_PHARMACY_ALREADY_EXISTS";
  static final String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS = "ERROR_MAIL_USER_ALREADY_EXISTS";

  // messages
  static final String MESSAGE_CONNECTION_ERROR = "connection_error";

  // links
  static final String LINK_RESET_PASSWORD = "***";
  static final String LINK_FIRST_SETUP_PASSWORD = "***";

  static final String GET_INFORMATION_PHARMACY = '/farmacia';
}