class Crop {
  String name;
  String imgPath;

  Crop({this.name, this.imgPath});

  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      name: json['name'],
      imgPath: json['imgPath'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imgPath'] = this.imgPath;
    return data;
  }
}
