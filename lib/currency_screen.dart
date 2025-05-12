import 'package:flutter/material.dart';

import 'currency_data.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final object = CurrencyData();
  var selectedCurrency = 'CNY';
  Map<String, String> data = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUi();
  }

  void updateUi() async {
    var myData = await object.getData(selectedCurrency);

    setState(() {
      data = myData;
    });
  }

  DropdownButton<String> dropDownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          updateUi();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XffDCB37B).withOpacity(0.6),
        title: const Text('Coin Ticker'),
      ),
      body: Stack(
        children: [
          Image.network(
            'https://st4.depositphotos.com/1017228/27659/i/450/depositphotos_276592546-stock-photo-beautiful-young-woman-wearing-sweater.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...cryptoList.map((item) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        color: const Color(0XffDCB37B),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            '1 $item = ${data[item] ?? '?'} $selectedCurrency',
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white60),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                color: const Color(0XffDCB37B),
                child: Center(child: dropDownButton()),
              ),
            ],
          )
        ],
      ),
    );
  }
}
