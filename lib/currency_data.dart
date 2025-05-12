import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

class CurrencyData {
  Future<dynamic> getData(String toCurrency) async {
    Map<String, String> allData = {};
    for (String item in cryptoList) {
      Uri url = Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$item/$toCurrency?apikey=42a3d7cb-4f6c-4890-a23d-6f355c53f04a');
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      final double rate = data['rate'];
      allData[item] = rate.toStringAsFixed(0);
    }
    return allData;
  }
}
