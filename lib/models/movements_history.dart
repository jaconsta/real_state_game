class MovementRecord {
  // print('HISTORY - Money - Operation - $amount');
  String source;
  String type;
  dynamic amount;
  DateTime date;

  MovementRecord({this.source, this.type, this.amount, this.date});
}

class _MovementsHistory {
  List<MovementRecord> history = [];

  add({String source, String type, amount}) {
    var now = new DateTime.now();
    MovementRecord newMovement = MovementRecord(source: source, type: type, amount: amount, date: now);
    history.insert(0, newMovement);
  }
}

_MovementsHistory movements = _MovementsHistory();