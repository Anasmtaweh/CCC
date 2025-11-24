import 'package:flutter/material.dart';
import 'car_care_data.dart';
import 'page3.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  bool _oil = false;
  bool _battery = false;
  bool _tire = false;
  bool _brakes = false;
  bool _airFilter = false;
  bool _spark = false;

  final TextEditingController _oilController = TextEditingController();
  final TextEditingController _tireController = TextEditingController();
  final TextEditingController _brakesController = TextEditingController();
  final TextEditingController _airFilterController = TextEditingController();
  final TextEditingController _sparkController = TextEditingController();

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
        return '✔️ Oil change is recent.\n   (Mileage until next change: ${5000 - km} km)';
      } else if (km < 8000) {
        return '⚠️ Consider changing oil soon.\n   (Mileage until next change: ${5000 - km} km)';
      } else {
        return '❌ Oil change overdue, please service.\n   (Mileage until next change: ${5000 - km} km)';
      }
    } catch (e) {
      return '⚠️ Invalid number for oil mileage.';
    }
  }

  String _tireMessage(String text) {
    if (text.trim().isEmpty) return '⚠️ No tire pressure value entered.';
    final psi = double.tryParse(text);
    if (psi == null) return '⚠️ Invalid number for tire pressure.';
    if (psi < 30) return '❌ Tire pressure low; inflate soon.';
    if (psi <= 35) return '✔️ Tire pressure in normal range.';
    return '⚠️ Tire pressure a bit high; recheck when cool.';
  }

  String _brakeMessage(String text) {
    if (text.trim().isEmpty) return '⚠️ No brake service mileage entered.';
    final km = double.tryParse(text);
    if (km == null) return '⚠️ Invalid number for brake mileage.';
    if (km < 10000) return '✔️ Brakes recently serviced.';
    if (km < 20000) return '⚠️ Brakes okay; monitor wear.';
    return '❌ Brakes likely due for service.';
  }

  String _airFilterMessage(String text) {
    if (text.trim().isEmpty) return '⚠️ No air filter mileage entered.';
    final km = double.tryParse(text);
    if (km == null) return '⚠️ Invalid number for air filter mileage.';
    if (km < 8000) return '✔️ Air filter recently changed.';
    if (km < 15000) return '⚠️ Consider changing air filter soon.';
    return '❌ Air filter overdue; replace.';
  }

  String _sparkMessage(String text) {
    if (text.trim().isEmpty) return '⚠️ No spark plug mileage entered.';
    final km = double.tryParse(text);
    if (km == null) return '⚠️ Invalid number for spark plug mileage.';
    if (km < 20000) return '✔️ Spark plugs recently changed.';
    if (km < 40000) return '⚠️ Plan a spark plug change soon.';
    return '❌ Spark plugs overdue; service needed.';
  }

  String _batteryMessage() {
    if (!_battery) return 'ℹ️ Battery not checked in this session.';
    if (_batterySelection == null) return '⚠️ Please choose a battery option.';
    if (_batterySelection == 'Less than 1 week') {
      return '✔️ Battery recently changed.';
    }
    if (_batterySelection == '1 week to 6 months') {
      return '⚠️ Battery is OK, just keep an eye on it.';
    }
    return '❌ Battery might be old, consider checking/ replacing it.';
  }

 