import 'services/network.dart';

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

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = 'F6B91F46-BB75-4BA2-908C-28665744FD02';
const baseAPI = 'https://rest.coinapi.io/v1';

class CoinData {
  Future getExchangeRates(String currency) async {
      Map<String, String> rates = {};
      for (String crypto in cryptoList) {
        String url = '$baseAPI/exchangerate/$crypto/$currency?apikey=$apiKey';
        NetworkHelper networkHelper = NetworkHelper(url: url);
        var data = await networkHelper.getData();
        rates[crypto] = data['rate'].toStringAsFixed(0);
      }
      return rates;
  }
}
