
class ApiDefinition {

  static Map<String, String> header = {
    "Authorization": null,
    "Cache-Control": "no-cache",
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive",
    'Content-Type': 'application/json; charset=UTF-8',
  };

  static Map<String, String> headerWithoutAuthorization = {
    "Cache-Control": "no-cache",
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive",
    'Content-Type': 'application/json; charset=UTF-8',
  };

  static String url = "localhost:8082";

}