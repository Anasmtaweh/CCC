import 'package:flutter/material.dart';
import 'page2.dart';
import 'car_care_data.dart';  // NEW

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String _brand = 'BMW';

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
    // get existing CarCareData (which already has plate set)
    final args = ModalRoute.of(context)?.settings.arguments;
    CarCareData data;

    if (args is CarCareData) {
      data = args;
    } else {
      // fallback if nothing was passed
      data = CarCareData(
        plate: '',
        brand: '',
        oil: '',
        battery: '',
        tire: '',
        brakes: '',
        airFilter: '',
        spark: '',
      );
    }

    // update brand only, keep plate and others
    data = CarCareData(
      plate: data.plate,
      brand: _brand,
      oil: data.oil,
      battery: data.battery,
      tire: data.tire,
      brakes: data.brakes,
      airFilter: data.airFilter,
      spark: data.spark,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Page2(),
        settings: RouteSettings(arguments: data),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('BMW', style: TextStyle(fontSize: 18.0)),
                Radio(
                  value: 'BMW',
                  groupValue: _brand,
                  onChanged: (val) => _setBrand(val as String),
                ),
                const Text('Toyota', style: TextStyle(fontSize: 18.0)),
                Radio(
                  value: 'Toyota',
                  groupValue: _brand,
                  onChanged: (val) => _setBrand(val as String),
                ),
                const Text('Suzuki', style: TextStyle(fontSize: 18.0)),
                Radio(
                  value: 'Suzuki',
                  groupValue: _brand,
                  onChanged: (val) => _setBrand(val as String),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
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
