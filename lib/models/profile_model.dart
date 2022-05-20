import 'package:universiting/models/host_model.dart';

class Profile {
  int userId;
  String nickname;
  String profileImage;
  String gender;
  int age;
  String? university;
  String? department;
  String introduction;
  int? type;
  Profile(
      {required this.age,
      this.department,
      required this.gender,
      required this.introduction,
      required this.nickname,
      required this.profileImage,
      this.university,
      this.type,
      required this.userId});

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
      age: json['age'],
      department: json['department'] ?? '-',
      gender: json['gender'] == 'M' ? '남성' : '여성',
      introduction: json['introduction'] ?? '',
      nickname: json['nickname'],
      profileImage: json['profile_image'] ?? '',
      university: json['university'].toString(),
      type: json['type'],
      userId: json['user_id']);

  factory Profile.fromHost(Host host) => Profile(
      age: host.age ?? 0,
      department: '-',
      gender: host.gender ?? '남성',
      introduction: host.introduction ?? '',
      nickname: host.nickname ?? '',
      profileImage: host.profileImage,
      university: '',
      type: host.type,
      userId: host.userId);
}
