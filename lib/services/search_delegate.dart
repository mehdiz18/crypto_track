import 'package:crypto_app/models/currency.dart';
import 'package:crypto_app/screens/details/details.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/services/api/coinapi/coinapi.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Recherche';
  List<Currency> _suggestions = [];
  CustomSearchDelegate() {
    CoinAPI.watchCryptos().listen((event) {
      _suggestions = event;
    });
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
      children: _suggestions.where((element) {
        return element.name.toLowerCase().contains(query.toLowerCase());
      }).map((e) {
        return ListTile(
          title: Text(e.name),
          onTap: () {
            close(context, null);
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => Details(e))));
          },
        );
      }).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return ListView(
        children: _suggestions.map((e) {
          return ListTile(
            title: Text(e.name),
            onTap: () {
              close(context, null);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => Details(e))));
            },
          );
        }).toList(),
      );
    }
    return ListView(
      children: _suggestions.where((element) {
        return element.name.toLowerCase().contains(query.toLowerCase());
      }).map((e) {
        return ListTile(
          title: Text(e.name),
          onTap: () {
            close(context, null);
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => Details(e))));
          },
        );
      }).toList(),
    );
  }
}
