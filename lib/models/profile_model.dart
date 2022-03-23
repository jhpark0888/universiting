class Profile {
  int userId;
  String nickname;
  String profileImage;
  String gender;
  int age;
  String? university;
  String? department;
  String introduction;
  Profile(
      {required this.age,
     this.department,
      required this.gender,
      required this.introduction,
      required this.nickname,
      required this.profileImage,
       this.university,
      required this.userId});

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
      age: json['age'],
      department: json['department'].toString(),
      gender: json['gender'] == 'M' ? '남자' : '여자',
      introduction: json['introduction'] == null ? '' : json['introduction'],
      nickname: json['nickname'],
      profileImage: json['profile_image'] == null ? '' : json['profile_image'],
      university: json['university'].toString(),
      userId: json['user_id']);
}
