import 'package:crypto_app/models/currency.dart';
import 'package:crypto_app/screens/details/chart.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final Currency _currency;
  const Details(this._currency);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: Colors.black,
                onPressed: () => Navigator.pop(context),
              ),
              Text(
                _currency.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border_outlined),
                color: Colors.black,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          _buildCurrencyInfos(context),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          Chart(_currency),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          _buildStats(context),
        ],
      ),
    );
  }

  Widget _buildCurrencyInfos(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          height: MediaQuery.of(context).size.height / 12,
          child: Image.network(
            _currency.icon,
            errorBuilder: ((context, error, stackTrace) {
              return Image.asset("assets/no_image.png");
            }),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          CurrencyFormatter()
              .format(_currency.exchangeRate, CurrencyFormatter.usd),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Container(
          width: MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
              color: !_currency.change.isNegative
                  ? const Color.fromARGB(143, 164, 240, 166)
                  : const Color.fromARGB(143, 241, 154, 148),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_currency.change.isNegative)
                const Icon(
                  Icons.keyboard_arrow_up_outlined,
                  color: Color(0xFF10DC78),
                )
              else
                const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Color(0xFFF15950),
                ),
              Text(
                "${_currency.change.abs().toStringAsFixed(3)}%",
                style: TextStyle(
                    color: _currency.change.isNegative
                        ? const Color(0xFFF15950)
                        : const Color(0xFF10DC78)),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text(
            "Market Cap",
            style: TextStyle(color: Color.fromARGB(255, 68, 68, 68)),
          ),
          subtitle: Text(
            CurrencyFormatter()
                .format(_currency.marketCapacity, CurrencyFormatter.usd),
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        ListTile(
          title: const Text(
            "Supply",
            style: TextStyle(color: Color.fromARGB(255, 68, 68, 68)),
          ),
          subtitle: Text(
            CurrencyFormatter().format(_currency.supply, CurrencyFormatter.usd),
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        ListTile(
          title: const Text(
            "Max Supply",
            style: TextStyle(color: Color.fromARGB(255, 68, 68, 68)),
          ),
          subtitle: Text(
            _currency.maxSupply != 0
                ? CurrencyFormatter()
                    .format(_currency.maxSupply, CurrencyFormatter.usd)
                : CurrencyFormatter().format(0, CurrencyFormatter.usd),
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        ListTile(
          title: const Text(
            "Volume 24h",
            style: TextStyle(color: Color.fromARGB(255, 68, 68, 68)),
          ),
          subtitle: Text(
            CurrencyFormatter().format(_currency.volume, CurrencyFormatter.usd),
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        )
      ],
    );
  }
}
