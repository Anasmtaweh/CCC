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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Care Check - Step 1'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            const Text(
              'Select Car Brand',
              style: TextStyle(fontSize: 22.0),
            ),
            const SizedBox(height: 20.0),
            // Radio group for brand
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('BMW', style: TextStyle(fontSize: 18.0)),
                Radio(
                  value: 'BMW',
                  groupValue: _brand,
                  onChanged: (val) {
                    _setBrand(val as String);
                  },
                ),
                const Text('Toyota', style: TextStyle(fontSize: 18.0)),
                Radio(
                  value: 'Toyota',
                  groupValue: _brand,
                  onChanged: (val) {
                    _setBrand(val as String);
                  },
                ),
                const Text('Suzuki', style: TextStyle(fontSize: 18.0)),
                Radio(
                  value: 'Suzuki',
                  groupValue: _brand,
                  onChanged: (val) {
                    _setBrand(val as String);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            // Image that changes instantly with selected brand
            Image.asset(
              _brandImage,
              width: 250.0,
              height: 250.0,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _openPage2,
              child: const Icon(Icons.navigate_next, size: 40),
            ),
          ],
        ),
      ),
    );
  }
}
