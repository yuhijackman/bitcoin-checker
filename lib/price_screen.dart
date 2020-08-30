import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'components/rate_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String exchangeRate = '?';
  Map<String, String> cryptoValues = {};
  bool isWaiting = false;

  List<RateCard> rateCards = [];

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> newItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      newItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: newItems,
      onChanged: (String newValue) {
        setState(() async {
          selectedCurrency = newValue;
          updateExchangeRate();
        });
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    List<Text> newPickerItems = [];
    for (String currency in currenciesList) {
      newPickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          updateExchangeRate();
        });
      },
      children: newPickerItems,
    );
  }

  void updateExchangeRate() async {
    isWaiting = true;
    try {
      rateCards = [];
      var data = await CoinData().getExchangeRates(selectedCurrency);
      isWaiting = false;
      setState(() {
        cryptoValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    updateExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RateCard(
                  currency: selectedCurrency,
                  cryptoCurrency: 'BTC',
                  rate: isWaiting ? '?' : cryptoValues['BTC'],
                ),
                RateCard(
                  currency: selectedCurrency,
                  cryptoCurrency: 'ETH',
                  rate: isWaiting ? '?' : cryptoValues['ETH'],
                ),
                RateCard(
                  currency: selectedCurrency,
                  cryptoCurrency: 'LTC',
                  rate: isWaiting ? '?' : cryptoValues['LTC'],
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getCupertinoPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}
//
//DropdownButton<String>(
//value: selectedCurrency,
//items: getDropdownItems(),
//onChanged: (String newValue) {
//setState(() {
//selectedCurrency = newValue;
//});
//},
//),
