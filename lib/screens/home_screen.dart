import 'package:flutter/material.dart';
import 'package:clip_clop/services/storage_service.dart';
import 'package:clip_clop/services/notification_service.dart';
import 'package:clip_clop/widgets/nail_progress.dart';
import 'package:clip_clop/widgets/celebration.dart';
import 'package:clip_clop/screens/stats_screen.dart';
import 'package:clip_clop/models/nail_record.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StorageService _storage = StorageService();
  final NotificationService _notifications = NotificationService();
  DateTime? _lastTrimDate;
  bool _isCelebrating = false;

  @override
  void initState() {
    super.initState();
    _loadData();
    _notifications.init().then((_) => _notifications.scheduleBiweeklyReminder());
  }

  Future<void> _loadData() async {
    final lastDate = await _storage.getLastTrimDate();
    setState(() => _lastTrimDate = lastDate);
  }

  double get _progress {
    if (_lastTrimDate == null) return 0.0;
    final daysPassed = DateTime.now().difference(_lastTrimDate!).inDays;
    return (daysPassed / 14).clamp(0.0, 1.0);
  }

  String get _nailHealthEmoji {
    if (_progress < 0.3) return '👍';
    if (_progress < 0.6) return '🤔';
    if (_progress < 0.9) return '⚠️';
    return '🚨';
  }

  String get _nailHealthMessage {
    if (_progress < 0.3) return 'Looking sharp!';
    if (_progress < 0.6) return 'Time to consider a trim';
    if (_progress < 0.9) return 'Getting claw-like';
    return 'Emergency trim needed!';
  }

  Color get _progressColor {
    if (_progress < 0.3) return Colors.green;
    if (_progress < 0.6) return Colors.amber;
    if (_progress < 0.9) return Colors.orange;
    return Colors.red;
  }

  Future<void> _logTrim() async {
    await _storage.saveRecord(NailRecord(
      trimDate: DateTime.now(),
      didTrim: true,
    ));
    
    setState(() {
      _lastTrimDate = DateTime.now();
      _isCelebrating = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clip Clop',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1A2B3C),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.history, size: 28),
            color: Colors.white,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StatsScreen()),
            ),
            tooltip: 'Trim History',
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF0F2F5),
                  Color(0xFF4A6B8A).withOpacity(0.1),
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            'NAIL HEALTH',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A6B8A),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            _nailHealthEmoji,
                            style: TextStyle(fontSize: 50),
                          ),
                          SizedBox(height: 10),
                          Text(
                            _nailHealthMessage,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  if (_lastTrimDate != null) ...[
                    Text(
                      'Last trimmed:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '${_lastTrimDate!.day}/${_lastTrimDate!.month}/${_lastTrimDate!.year}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Days since last trim:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '${DateTime.now().difference(_lastTrimDate!).inDays}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ] else ...[
                    Text(
                      'No trim records yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                  SizedBox(height: 30),
                  NailProgress(
                    progress: _progress,
                    color: _progressColor,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _logTrim,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Color(0xFF1A2B3C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    ),
                    child: Text(
                      'LOG NAIL TRIM',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isCelebrating)
            CelebrationOverlay(
              onContinue: () {
                setState(() {
                  _isCelebrating = false;
                });
              },
            ),
        ],
      ),
    );
  }
}