import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'RUB',
  'USD',
  'KZT',
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
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

//const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
//                  https://rest.coinapi.io/v1/exchangerate/RUB/BTC?apikey=CF77510E-5B52-45DA-8EE6-C54871353E8D
const apiKey = 'CF77510E-5B52-45DA-8EE6-C54871353E8D';
const coinAPIURL =
    'https://rest.coinapi.io/v1/exchangerate';


class CoinData {
  CoinData(this.coin, this.curr);

  final String coin;
  final String curr;

  //TODO: Create your getCoinData() method here.
  Future getCoinData() async {
    http.Response response =
    await http.get(Uri.parse('$coinAPIURL/$coin/$curr?apikey=$apiKey'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['rate'].toInt();
    } else {
      print(response.statusCode);
      print('Error getting price data');
    }
  }
}