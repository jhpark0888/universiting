import 'dart:convert';

class Univ {
  String email;
  String schoolname;
  int id;
  Univ({required this.email, required this.schoolname, required this.id});

  factory Univ.fromJson(Map<String, dynamic> json) =>
      Univ(id : json['id'],email: json['email'], schoolname: json['schoolname']);
}

List<Univ> univParsed(String responsebody) {
  List parse = jsonDecode(responsebody);
  return parse.map<Univ>((e) => Univ.fromJson(e)).toList();
}

class Depart {
  int id;
  int schoolId;
  String depName;
  String schoolName;

  Depart(
      {required this.id,
      required this.schoolId,
      required this.depName,
      required this.schoolName});

  factory Depart.fromJson(Map<String, dynamic> json) {
    return Depart(
        id: json['id'],
        schoolId: json['university_id'],
        depName: json['dep_name'],
        schoolName: json['schoolname']);
  }
}

List<Depart> departParsed(String responsebody) {
  List parse = jsonDecode(responsebody);
  return parse.map<Depart>((e) => Depart.fromJson(e)).toList();
}
