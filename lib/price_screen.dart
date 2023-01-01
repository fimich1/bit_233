import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State {
  String selectedCurrency = 'USD';
  var coinPrice = List.filled(cryptoList.length, '0');
  // DropdownButton androidDropdown() {
  //   List> dropdownItems = [];
  //   for (String currency in currenciesList) {
  //     var newItem = DropdownMenuItem(
  //       child: Text(currency),
  //       value: currency,
  //     );
  //     dropdownItems.add(newItem);
  //   }
  //
  //   return DropdownButton(
  //     value: selectedCurrency,
  //     items: dropdownItems,
  //     onChanged: (value) {
  //       setState(() {
  //         selectedCurrency = value;
  //         getData(coin: cryptoList, currency: selectedCurrency);
  //       });
  //     },
  //   );
  // }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData(coin: cryptoList, currency: selectedCurrency);
        });
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  //TODO: Create a method here called getData() to get the coin data from coin_data.dart
  void getData({required List coin, required String currency}) async {
    for (int i = 0; i < coin.length; i++) {
      try {
        CoinData currencyData = CoinData(coin[i], currency);
        var price = await currencyData.getCoinData();
        coinPrice[i] = price.toString();
      } catch (e) {
        print(e);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    //TODO: Call getData() when the screen loads up.
    getData(coin: cryptoList, currency: 'USD');
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
        children: [
          for (var iCoin = 0; iCoin < cryptoList.length; iCoin++)
            buildPadding(cryptoList[iCoin], iCoin),
          Expanded(
            child: SizedBox(
              height: 1,
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            //child: Platform.isIOS ? iOSPicker() : androidDropdown(),
            child: iOSPicker(),
          ),
        ],
      ),
    );
  }

  Padding buildPadding(String coinType, int index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            //TODO: Update the Text Widget with the live bitcoin data here.
            '1 $coinType = ${coinPrice[index]} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}