class CaravanModel {
  int? id;
  String? image;
  String? productName;

  CaravanModel({this.id, this.image, this.productName});

  CaravanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    productName = json['productName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['productName'] = this.productName;
    return data;
  }
}
