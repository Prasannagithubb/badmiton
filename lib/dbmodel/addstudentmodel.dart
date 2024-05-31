const String addstudentName = "AddstudentName";

class AddstudentColumns {
  static const String id = "id";
  static const String batchname = "batchname";
  static const String studentname = "studentname";
  static const String studentmobilenumber = "studentmobilenumber";
  static const String fathername = "fathername";
  static const String fathermobilenumber = "fathermobilenumber";
  static const String mothername = "mothername";
  static const String mothermobilenumber = "mothermobilenumber";
  static const String fees = "fees";
  static const String currenttime = "currenttime";
  static const String dateOfBirth = "dateOfBirth";
  static const String isActive = "isActive";
  static const String isPresent = "isPresent"; // Add this line
}

class Addstudent {
  int? id;
  String batchname;
  String studentname;
  int studentmobilenumber;
  String fathername;
  int fathermobilenumber;
  String mothername;
  int mothermobilenumber;
  double fees;
  String? currenttime;
  String dateOfBirth;
  String? isActive;
  bool? isPresent;

  Addstudent({
    this.id,
    required this.batchname,
    required this.dateOfBirth,
    required this.studentname,
    required this.studentmobilenumber,
    required this.fathername,
    required this.fathermobilenumber,
    required this.mothername,
    required this.mothermobilenumber,
    this.currenttime,
    required this.fees,
    this.isActive,
    this.isPresent, // Default to false
  });

  Map<String, Object?> toMap() => {
        AddstudentColumns.id: id,
        AddstudentColumns.batchname: batchname,
        AddstudentColumns.dateOfBirth: dateOfBirth,
        AddstudentColumns.studentname: studentname,
        AddstudentColumns.studentmobilenumber: studentmobilenumber,
        AddstudentColumns.fathername: fathername,
        AddstudentColumns.fathermobilenumber: fathermobilenumber,
        AddstudentColumns.mothername: mothername,
        AddstudentColumns.mothermobilenumber: mothermobilenumber,
        AddstudentColumns.currenttime: currenttime,
        AddstudentColumns.fees: fees,
        AddstudentColumns.isActive: isActive,
        AddstudentColumns.isPresent: isPresent,
      };

  static Addstudent fromMap(Map<String, dynamic> map) => Addstudent(
        id: map[AddstudentColumns.id],
        batchname: map[AddstudentColumns.batchname],
        dateOfBirth: map[AddstudentColumns.dateOfBirth],
        studentname: map[AddstudentColumns.studentname],
        studentmobilenumber:
            int.parse(map[AddstudentColumns.studentmobilenumber].toString()),
        fathername: map[AddstudentColumns.fathername],
        fathermobilenumber:
            int.parse(map[AddstudentColumns.fathermobilenumber].toString()),
        mothername: map[AddstudentColumns.mothername],
        mothermobilenumber:
            int.parse(map[AddstudentColumns.mothermobilenumber].toString()),
        currenttime: map[AddstudentColumns.currenttime],
        fees: double.parse(map[AddstudentColumns.fees]),
        isActive: map[AddstudentColumns.isActive],
        isPresent: map[AddstudentColumns.isPresent] == 1,
      );
}
