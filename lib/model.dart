class Model {
  final String? fullName;
  final String? image;
  final String? nickname;

  Model({
    this.fullName,
    this.image,
    this.nickname,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      fullName: json['fullName'],
      image: json['image'],
      nickname: json['nickname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'image': image,
      'nickname': nickname,
    };
  }
}