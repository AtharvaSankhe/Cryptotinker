import 'package:flutter/material.dart';
import 'coin_dart.dart';
import 'networking.dart';
const key= 'F7861F19-87A9-4185-BB0F-056346FE3D5F';
final FocusNode _focusNode = FocusNode();

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String coin = 'USD' ;
  String crypto = 'BTC' ;
  String url ='';
  dynamic value = '?';
  List<DropdownMenuEntry<String>> coins=[];
  List<DropdownMenuEntry<String>> cryptos=[];
  List<DropdownMenuEntry<String>> createList(){
    for (String c in currenciesList){
      var item = DropdownMenuEntry(value: c,label: c);
      coins.add(item);
    }
    return coins;
  }
  List<DropdownMenuEntry<String>> createListCrypto(){
    for (String c in cryptoList){
      var item = DropdownMenuEntry(value: c,label: c);
      cryptos.add(item);
    }
    return cryptos;
  }
  void get() async{
    try {
      NetworkHelper networkHelper = NetworkHelper(
          'https://rest.coinapi.io/v1/exchangerate/${crypto}/${coin}?apikey=${key}');
      var code = await networkHelper.getData();
      setState(() {
        value = code['rate'].toStringAsFixed(4);
      });
    }
    catch (e){
      print(e);
    }
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
          Padding(
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
                  '1 ${crypto} = ${value} ${coin}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: GestureDetector(
              onTap: (){
                // FocusScopeNode currentFocus = FocusScope.of(context);
                FocusScope.of(context).unfocus();
                // _focusNode.unfocus();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownMenu(
                    // focusNode: _focusNode,
                    initialSelection: 'BTC',
                    dropdownMenuEntries: createListCrypto(),
                    onSelected: (sel_coin){
                      setState(() {
                        crypto = sel_coin!;
                        print(crypto);
                        print('itna hogaya');
                        get();
                      });
                    },
                  ),
                  DropdownMenu(
                    // focusNode: _focusNode,
                    initialSelection: 'USD',
                    dropdownMenuEntries: createList(),
                    onSelected: (sel_coin){
                      setState(() {
                        coin = sel_coin!;
                        print(coin);
                        print('itna hogaya');
                        get();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


