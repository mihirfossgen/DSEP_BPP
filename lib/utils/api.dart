class Api {
  static const String _domain =
      "https://uat.protean-health.com/proteanid/verifier/v1";
  static const String _bppUrl =
      "https://proteanrc.centralindia.cloudapp.azure.com/dsep-bpp-1";
  static const String fetchScheme = _domain + "fetchScheme";
  static const String signUp = _bppUrl + "/api/signup";

  

  static const String listAllProviderScheme =
      _bppUrl + "/api/scheme/provider/list";

  static const String createScheme = _bppUrl + '/api/scheme/create';
  // static const String updateScheme =
  //     _bppUrl + '/api/scheme/update/SCM_00420068';
static const String signin = _bppUrl + "/api/token";
}
