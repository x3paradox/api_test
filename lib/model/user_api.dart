class UserAPIModel {
  final int id;
  final String name;
  final String email;
  final String gender;
  final String status;

  UserAPIModel({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  UserAPIModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        gender = json['gender'],
        status = json['status'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['status'] = status;
    return data;
  }
}
