class Model {
  String? fullName;
  String? image;

  Model({required this.fullName, required this.image});

  Model.fromJson(Map<String, dynamic> json){
    fullName = json['fullName'];
    image = json['image'];
  }
}