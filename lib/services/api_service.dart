import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fx_app/models/data.dart';

class Services {

  static Future<CurrencyModel> fetchdata() async {
    final url = "https://api.exchangeratesapi.io/latest";
    var response =  await http.get(url);
    if(response.statusCode == 200) {
      CurrencyModel currencyModel = CurrencyModel.fromJson(json.decode(response.body));
      return currencyModel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}

