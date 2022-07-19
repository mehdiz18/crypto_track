import 'package:crypto_app/screens/home/crypto_list.dart';
import 'package:crypto_app/screens/home/favorite.dart';
import 'package:crypto_app/services/search_delegate.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  @override
  final List<Widget> _screens = [
    const CryptoList(),
    const Favorite(),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: const Color.fromARGB(255, 24, 20, 20),
              child: const Icon(Icons.search),
              onPressed: () => showSearch(
                  context: context, delegate: CustomSearchDelegate())),
          bottomNavigationBar: FluidNavBar(
            onChange: _handleChange,
            defaultIndex: _currentIndex,
            style: const FluidNavBarStyle(
                iconUnselectedForegroundColor: Colors.black),
            icons: [
              FluidNavBarIcon(icon: Icons.home),
              FluidNavBarIcon(icon: Icons.favorite)
            ],
          ),
          body: IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
        ),
      ),
    );
  }

  void _handleChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
