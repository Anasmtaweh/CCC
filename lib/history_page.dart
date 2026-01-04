import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  final String plate;

  const HistoryPage({super.key, required this.plate});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<Map<String, dynamic>>> _futureHistory;

  @override
  void initState() {
    super.initState();
    _futureHistory = _fetchHistory();
  }

  Future<List<Map<String, dynamic>>> _fetchHistory() async {
    final url = Uri.parse(
      'http://carecarecheck.atwebpages.com/get_history.php?plate=${Uri.encodeQueryComponent(widget.plate)}',
    );

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    if (data['success'] == true && data['records'] is List) {
      return List<Map<String, dynamic>>.from(data['records']);
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History - ${widget.plate}'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final records = snapshot.data ?? [];

          if (records.isEmpty) {
            return const Center(child: Text('No history for this plate yet.'));
          }

          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final r = records[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(r['brand'] ?? 'Unknown brand'),
                  subtitle: Text(
                    'Date: ${r['created_at']}\n'
                    'Oil: ${r['oil']}\n'
                    'Battery: ${r['battery']}\n'
                    'Tire: ${r['tire']}\n'
                    'Brakes: ${r['brakes']}\n'
                    'Air filter: ${r['air_filter']}\n'
                    'Spark: ${r['spark']}',
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
