const String batchtablename = "BatchTableName";

class AddBatchColumns {
    static const String tableName = 'batch';
  static const String id = "id";
  static const String name = "name";
  static const String description = "description";
  static const String fees = "fees";
  static const String batchDays = "batchDays";
  static const String studentIntake = "studentIntake";
  static const String time = "time";
  static const String isActive = "isActive";
}

class Batchs {
  int? id;
  final String name;
  final String description;
  final double fees;
  final List<bool> batchDays;
  final int studentIntake;
  final String time;
  bool isActive;

  Batchs({
    this.id,
    required this.name,
    required this.description,
    required this.fees,
    required this.batchDays,
    required this.studentIntake,
    required this.time,
    required this.isActive,
  });

  Map<String, Object?> toMap() => {
        AddBatchColumns.id: id,
        AddBatchColumns.name: name,
        AddBatchColumns.description: description,
        AddBatchColumns.fees: fees,
        AddBatchColumns.batchDays: batchDays.join(','),
        AddBatchColumns.studentIntake: studentIntake,
        AddBatchColumns.time: time,
        AddBatchColumns.isActive: isActive,
      };
}
