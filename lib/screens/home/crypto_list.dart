import 'package:crypto_app/models/currency.dart';
import 'package:crypto_app/screens/home/crypto_tile.dart';
import 'package:crypto_app/screens/home/loading.dart';
import 'package:crypto_app/screens/home/no_connection.dart';
import 'package:crypto_app/services/api/coinapi/coinapi.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class CryptoList extends StatefulWidget {
  const CryptoList({Key? key}) : super(key: key);

  @override
  State<CryptoList> createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoList> {
  @override
  Stream<List<Currency>>? _stream;
  @override
  void initState() {
    super.initState();
    _stream = CoinAPI.watchCryptos();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (context, AsyncSnapshot<List<Currency>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Loading();
        }
        if (snapshot.data!.isEmpty) {
          return NoConnection(_refresh);
        }
        List<Currency> data = snapshot.data!;
        return LiquidPullToRefresh(
          color: Colors.white,
          backgroundColor: Colors.black,
          height: MediaQuery.of(context).size.height / 12,
          showChildOpacityTransition: false,
          onRefresh: _refresh,
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
                primary: false,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return CryptoTile(data[index]);
                }),
          ),
        );
      },
    );
  }

  Future<void> _refresh() async {
    final temp = CoinAPI.watchCryptos();
    setState(() {
      _stream = temp;
    });
  }
}
