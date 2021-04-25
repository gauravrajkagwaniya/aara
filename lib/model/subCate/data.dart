class Data {
  String subcatId;
  String catId;
  String subcategory;
  String status;
  String title;
  Null description;
  String imagePath;
  String unicode;
  Null height;
  Null width;
  Null createdBy;
  String createdAt;

  Data(
      {this.subcatId,
      this.catId,
      this.subcategory,
      this.status,
      this.title,
      this.description,
      this.imagePath,
      this.unicode,
      this.height,
      this.width,
      this.createdBy,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    subcatId = json['subcat_id'];
    catId = json['cat_id'];
    subcategory = json['subcategory'];
    status = json['status'];
    title = json['title'];
    description = json['description'];
    imagePath = json['image_path'];
    unicode = json['unicode'];
    height = json['height'];
    width = json['width'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subcat_id'] = this.subcatId;
    data['cat_id'] = this.catId;
    data['subcategory'] = this.subcategory;
    data['status'] = this.status;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image_path'] = this.imagePath;
    data['unicode'] = this.unicode;
    data['height'] = this.height;
    data['width'] = this.width;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    return data;
  }
}