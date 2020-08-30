import 'package:flutter/material.dart';

class RateCard extends StatelessWidget {
  final String currency;
  final String cryptoCurrency;
  final String rate;
  RateCard({@required this.currency, @required this.cryptoCurrency, @required this.rate});

        @override
        Widget build(BuildContext context) {
      return Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $cryptoCurrency = $rate $currency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
