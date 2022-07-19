import 'package:crypto_app/models/currency.dart';
import 'package:crypto_app/screens/details/details.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';

class CryptoTile extends StatelessWidget {
  final Currency _data;
  CryptoTile(this._data);

  @override
  Widget build(BuildContext context) {
    Image? image;
    try {
      image = Image.network(
        _data.icon,
        errorBuilder: ((context, error, stackTrace) {
          return Image.asset("assets/no_image.png");
        }),
      );
    } catch (e) {
      print(e);
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => Details(_data))));
      },
      child: Card(
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: ListTile(
          leading: image,
          title: Text(_data.id),
          subtitle: Text(_data.name),
          trailing: SizedBox(
              width: MediaQuery.of(context).size.width * 0.38,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        CurrencyFormatter()
                            .format(_data.exchangeRate, CurrencyFormatter.usd),
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          if (!_data.change.isNegative)
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
                            "${_data.change.abs().toStringAsFixed(3)}%",
                            style: TextStyle(
                                color: _data.change.isNegative
                                    ? const Color(0xFFF15950)
                                    : const Color(0xFF10DC78)),
                          )
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_outline),
                    onPressed: () {},
                  )
                ],
              )),
        ),
      ),
    );
  }
}
