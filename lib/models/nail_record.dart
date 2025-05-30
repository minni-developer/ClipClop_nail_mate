class NailRecord {
  final DateTime trimDate;
  final bool didTrim;

  NailRecord({required this.trimDate, required this.didTrim});

  Map<String, dynamic> toMap() {
    return {
      'trimDate': trimDate.toIso8601String(),
      'didTrim': didTrim,
    };
  }

  factory NailRecord.fromMap(Map<String, dynamic> map) {
    return NailRecord(
      trimDate: DateTime.parse(map['trimDate']),
      didTrim: map['didTrim'],
    );
  }
}