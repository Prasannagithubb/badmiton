const String addcoachcolumns = "addcoachcolumns";

class AddCoachColumns {
  static const String tableName = 'coach';
  static const String id = "id";
  static const String name = "name";
  static const String mobile = "mobile";
  static const String salary = "salary";
  static const String bankDetails = "bankDetails";
  static const String dateOfJoining = "dateOfJoining";
  static const String dateOfResignation = "dateOfResignation";
  static const String idCardPath = "idCardPath";
  static const String bankPassbookPath = "bankPassbookPath";
}

class Coach {
  int? id;
  String name;
  String mobile;
  String salary;
  String bankDetails;
  String dateOfJoining;
  String dateOfResignation;
  String idCardPath;
  String bankPassbookPath;

  Coach({
    this.id,
    required this.name,
    required this.mobile,
    required this.salary,
    required this.bankDetails,
    required this.dateOfJoining,
    required this.dateOfResignation,
    required this.idCardPath,
    required this.bankPassbookPath,
  });
  Map<String, Object?> toMap() => {
        AddCoachColumns.id:  id,
        AddCoachColumns.name: name,
        AddCoachColumns.mobile: mobile,
        AddCoachColumns.salary: salary,
        AddCoachColumns.bankDetails: bankDetails,
        AddCoachColumns.dateOfJoining: dateOfJoining,
        AddCoachColumns.dateOfResignation: dateOfResignation,
        AddCoachColumns.idCardPath: idCardPath,
        AddCoachColumns.bankPassbookPath: bankPassbookPath,
      };
}
