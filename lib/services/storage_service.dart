import 'package:shared_preferences/shared_preferences.dart';
import '../models/nail_record.dart';
import 'dart:convert';

class StorageService {
  static const _recordsKey = 'nailRecords';

  Future<void> saveRecord(NailRecord record) async {
    final prefs = await SharedPreferences.getInstance();
    final records = await getRecords();
    records.add(record);
    
    final encodedData = jsonEncode(records.map((r) => r.toMap()).toList());
    await prefs.setString(_recordsKey, encodedData);
  }

  Future<List<NailRecord>> getRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_recordsKey);
    
    if (data == null) return [];
    
    final decodedData = jsonDecode(data) as List;
    return decodedData.map((item) => NailRecord.fromMap(item)).toList();
  }

  Future<DateTime?> getLastTrimDate() async {
    final records = await getRecords();
    if (records.isEmpty) return null;
    
    final trimmedRecords = records.where((r) => r.didTrim).toList();
    if (trimmedRecords.isEmpty) return null;
    
    trimmedRecords.sort((a, b) => b.trimDate.compareTo(a.trimDate));
    return trimmedRecords.first.trimDate;
  }
}