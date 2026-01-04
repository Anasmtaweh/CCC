import 'package:flutter/material.dart';
import 'page1.dart';
import 'car_care_data.dart';

class PlateLoginPage extends StatefulWidget {
  const PlateLoginPage({super.key});

  @override
  State<PlateLoginPage> createState() => _PlateLoginPageState();
}

class _PlateLoginPageState extends State<PlateLoginPage> {
  final TextEditingController _plateController = TextEditingController();
  String _message = '';

  void _continue() {
    final plate = _plateController.text.trim();
    if (plate.isEmpty) {
      setState(() {
        _message = 'Please enter a plate number';
      });
      return;
    }

    // Create initial CarCareData with plate only (you already have this class)
    final data = CarCareData(
      plate: plate,
      brand: '',
      oil: '',
      battery: '',
      tire: '',
      brakes: '',
      airFilter: '',
      spark: '',
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Page1(),
        settings: RouteSettings(arguments: data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Car Plate Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter car plate number'),
            const SizedBox(height: 16),
            TextField(
              controller: _plateController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Plate (e.g. ABC123)',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _continue,
              child: const Text('Continue'),
            ),
            const SizedBox(height: 8),
            Text(
              _message,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
