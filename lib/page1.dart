import 'package:flutter/material.dart';
import 'page2.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  // selected brand text
  String _brand = 'BMW';

  // we map brand -> image asset
  String get _brandImage {
    if (_brand == 'BMW') {
      return 'assets/bmw.png';
    } else if (_brand == 'Toyota') {
      return 'assets/toyota.png';
    } else {
      return 'assets/suzuki.png';
    }
  }

  void _setBrand(String brand) {
    setState(() {
      _brand = brand;
    });
  }

  void _openPage2() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Page2(),
        // we send the selected brand using RouteSettings
        settings: RouteSettings(arguments: _brand),
      ),
    );
  }

 