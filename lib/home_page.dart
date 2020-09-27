import 'package:flutter/material.dart';
import 'package:fx_app/models/data.dart';
import 'services/api_service.dart';
import 'widgets/top_container.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  CurrencyModel _currencyModel;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    initData();
  }

  Future<void> initData() async {
    CurrencyModel currencyModel = await Services.fetchdata();
    setState(() {
      _currencyModel = currencyModel;
      currencyData('');
      _isLoading = false;
    });
  }

  List<String> currencyData([String convertPrice = '']) {
    List<String> rates = (convertPrice == '' ||
            double.tryParse(convertPrice) < 0)
        ? _currencyModel.rates
            .map((key, value) => MapEntry(key, key + ' : ' + value.toString()))
            .values
            .toList()
        : _currencyModel.rates
            .map((key, value) => MapEntry(key,
                key + ' : ' + (value * double.parse(convertPrice)).toString()))
            .values
            .toList();
    return rates;
  }

  void onPageRefresh() {
    _controller.text = '';
    setState(() {
      currencyData(_controller.text);
      date = DateTime.now();
      time = TimeOfDay.now();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Column(
                children: [
                  TopContainer(
                    currencyType: _currencyModel.base,
                    date: date,
                    time: time,
                    onRefresh: onPageRefresh,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 10,
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(labelText: 'Enter amount'),
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) {
                        setState(() {
                          currencyData(value);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    width: 150,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          currencyData(_controller.text);
                        });
                      },
                      child: Text('Convert'),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Divider(),
                  Expanded(
                    child: Container(
                      width: 250,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: _currencyModel.rates.length,
                        itemBuilder: (ctx, index) {
                          List<String> data = currencyData(_controller.text);
                          return ListTile(
                            title: Text(data[index]),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
