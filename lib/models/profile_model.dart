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
      department: json['department'] ?? '',
      gender: json['gender'] == 'M' ? '남성' : '여성',
      introduction: json['introduction'] ?? '',
      nickname: json['nickname'],
      profileImage: json['profile_image'] ?? '',
      university: json['university'].toString(),
      type: json['type'],
      userId: json['user_id']);
}
