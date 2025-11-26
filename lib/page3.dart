import 'package:flutter/material.dart';
import 'car_care_data.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is! CarCareData) {
      return Scaffold(
        appBar: AppBar(title: const Text('Car Care Summary')),
        body: const Center(child: Text('No summary data provided.')),
      );
    }
    final data = args;

    return Scaffold(
      appBar: AppBar(
        title: Text('Car Care Summary - ${data.brand}'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _tile('Oil change', data.oil),
          _tile('Battery', data.battery),
          _tile('Tire pressure', data.tire),
          _tile('Brake pads', data.brakes),
          _tile('Air filter', data.airFilter),
          _tile('Spark plugs', data.spark),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Icon(Icons.navigate_before, size: 40),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Icon(Icons.refresh, size: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tile(String title, String body) {
    return Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(body),
      ),
    );
  }
}
