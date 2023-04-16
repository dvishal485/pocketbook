import 'package:isar/isar.dart';

part 'transaction.g.dart';

@Collection()
class Transaction {
  Id id = Isar.autoIncrement;
  late String receiver;
  late int amount;
  late String time;
}
