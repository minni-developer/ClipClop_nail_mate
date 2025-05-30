import 'package:flutter/material.dart';
import 'package:clip_clop/services/storage_service.dart';
import 'package:clip_clop/models/nail_record.dart';

class StatsScreen extends StatelessWidget {
  final StorageService _storage = StorageService();

  StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trim History'),
      ),
      body: FutureBuilder<List<NailRecord>>(
        future: _storage.getRecords(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final records = snapshot.data ?? [];
          final trimmedRecords = records.where((r) => r.didTrim).toList();
          
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Trims: ${trimmedRecords.length}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: trimmedRecords.length,
                    itemBuilder: (context, index) {
                      final record = trimmedRecords[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.content_cut, color: Colors.pink),
                          title: const Text('Nail Trim'),
                          subtitle: Text('${record.trimDate.day}/${record.trimDate.month}/${record.trimDate.year}'),
                          trailing: Text('${record.trimDate.hour}:${record.trimDate.minute.toString().padLeft(2, '0')}'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}