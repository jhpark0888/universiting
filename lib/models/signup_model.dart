import 'dart:convert';

class Univ {
  String link;
  String school;

  Univ({required this.link, required this.school});

  factory Univ.fromJson(Map<String, dynamic> json) =>
      Univ(link: json['link'], school: json['school']);
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
        schoolId: json['school_id'],
        depName: json['dep_name'],
        schoolName: json['school_name']);
  }
}

List<Depart> departParsed(String responsebody) {
  List parse = jsonDecode(responsebody);
  return parse.map<Depart>((e) => Depart.fromJson(e)).toList();
}
