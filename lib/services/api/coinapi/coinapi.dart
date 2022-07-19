import 'dart:convert';

import 'package:crypto_app/models/currency.dart';
import 'package:http/http.dart' as http;

class CoinAPI {
  static final Map<String, String> _header = {
    "Authorization": "Bearer 03ec6782-0f27-42df-a2cd-6b92c89f5d9e"
  };
  static Future<List<Currency>> _fetchCrypto() async {
    try {
      final result = await http
          .get(Uri.parse("https://api.coincap.io/v2/assets"), headers: _header);

      if (result.statusCode == 200) {
        List<dynamic> fetchedResult = json.decode(result.body)['data'];
        return fetchedResult.map((crypto) {
          return Currency.fromMap({
            "id": crypto["symbol"],
            "name": crypto["name"],
            "icon":
                "https://cryptologos.cc/logos/${crypto["name"].toLowerCase().replaceAll(" ", "-").replaceAll(".", "-")}-${crypto["symbol"].toLowerCase()}-logo.png?v=022",
            "rate": double.parse(crypto["priceUsd"]),
            "changePercent24Hr": double.parse(crypto["changePercent24Hr"]),
            "marketCapUsd": double.parse(crypto["marketCapUsd"]),
            "supply": double.parse(crypto["supply"]),
            "maxSupply": crypto["maxSupply"] == null
                ? 0.0
                : double.parse(crypto["maxSupply"]),
            "volume": double.parse(crypto["volumeUsd24Hr"]),
          });
        }).toList();
      }
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  static Stream<List<Currency>> watchCryptos() async* {
    yield await CoinAPI._fetchCrypto();
  }
}
