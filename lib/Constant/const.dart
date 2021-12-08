class Const {
  static String baseUrl = 'https://vigenesia.herokuapp.com/api/v1';


  static var loginEndpoint = '$baseUrl/login';
  static var motivasiEndpoint = '$baseUrl/motivasi';

  static String motivasiByUser(var id) {
    return '$motivasiEndpoint/$id';

  }


}