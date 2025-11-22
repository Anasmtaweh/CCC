import 'package:flutter/material.dart';
import 'car_care_data.dart';
import 'page3.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  // checkboxes
  bool _oil = false;
  bool _battery = false;
  bool _tire = false;
  bool _brakes = false;
  bool _airFilter = false;
  bool _spark = false;

  // text fields controllers (mileage/time)
  final TextEditingController _oilController = TextEditingController();
  final TextEditingController _tireController = TextEditingController();
  final TextEditingController _brakesController = TextEditingController();
  final TextEditingController _airFilterController = TextEditingController();
  final TextEditingController _sparkController = TextEditingController();

  // battery dropdown selection
  final List<String> _batteryOptions = [
    'Less than 1 week',
    '1 week to 6 months',
    'More than 6 months'
  ];
  String? _batterySelection;

  @override
  void dispose() {
    _oilController.dispose();
    _tireController.dispose();
    _brakesController.dispose();
    _airFilterController.dispose();
    _sparkController.dispose();
    super.dispose();
  }

  // helper to convert a numeric text into recommendation with icons
  String _oilMessageFromText(String text) {
    if (text.trim() == '') {
      return '⚠️ No mileage entered.';
    }
    try {
      double km = double.parse(text);
      if (km < 5000) {
        return '✔️ Oil change is recent.\n   (Mileage since last change: $km km)';
      } else if (km < 8000) {
        return '⚠️ Consider changing oil soon.\n   (Mileage since last change: $km km)';
      } else {
        return '❌ Oil change overdue, please service.\n   (Mileage since last change: $km km)';
      }
    } catch (e) {
      return '⚠️ Invalid number for oil mileage.';
    }
  }

  String _genericMessageFromText(String label, String text) {
    if (text.trim() == '') {
      return '⚠️ No value entered for $label.';
    }
    return '✔️ $label value entered: $text';
  }

  