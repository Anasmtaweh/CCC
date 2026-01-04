import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'car_care_data.dart';
import 'history_page.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  String _saveMessage = '';

  Future<void> saveToDatabase(CarCareData data) async {
    // PUT YOUR AWARDSPACE URL HERE
    final url = Uri.parse('http://carecarecheck.atwebpages.com/save_car.php');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'plate': data.plate,
          'brand': data.brand,
          'oil': data.oil,
          'battery': data.battery,
          'tire': data.tire,
          'brakes': data.brakes,
          'air_filter': data.airFilter,
          'spark': data.spark,
        }),
      );

      final result = jsonDecode(response.body);
      setState(() {
        _saveMessage = result['message'];
      });
    } catch (e) {
      setState(() {
        _saveMessage = 'Failed to save: $e';
      });
    }
  }

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
          ElevatedButton(
            onPressed: () => saveToDatabase(data),
            child: const Text('Save to Database'),
          ),
          const SizedBox(height: 10),
          Text(
            _saveMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _saveMessage.contains('success') ? Colors.green : Colors.red,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HistoryPage(plate: data.plate),
                ),
              );
            },
            child: const Text('View History for this Car'),
          ),
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
