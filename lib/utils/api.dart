class Api {
  static const String _domain =
      "https://uat.protean-health.com/proteanid/verifier/v1";
  static const String _bppUrl =
      "https://proteanrc.centralindia.cloudapp.azure.com/dsep-bpp-1";
  static const String fetchScheme = _domain + "fetchScheme";
  static const String signUp = _bppUrl + "/api/signup";

  static const String getSchemeList = _bppUrl + "/api/scheme/list";

  static const String listAllProviderScheme =
      _bppUrl + "/api/scheme/provider/list";

  static const String createScheme = _bppUrl + '/api/scheme/create';
  // static const String updateScheme =
  //     _bppUrl + '/api/scheme/update/SCM_00420068';
  static const String signin = _bppUrl + "/api/token";
  static const String publish = _bppUrl + "/api/scheme/publish/";
  static const String unpublish = _bppUrl + "/api/scheme/unpublish/";
  static const String delete = _bppUrl + "/api/scheme/delete/";
}
