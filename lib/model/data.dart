class Data {
  String catId;
  String megaCatId;
  String megaTypeId;
  String title;
  String status;
  String category;
  String description;
  String imagePath;
  String unicode;
  String height;
  String width;
  String createdBy;
  String createdAt;

  Data(
      {this.catId,
      this.megaCatId,
      this.megaTypeId,
      this.title,
      this.status,
      this.category,
      this.description,
      this.imagePath,
      this.unicode,
      this.height,
      this.width,
      this.createdBy,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    megaCatId = json['mega_cat_id'];
    megaTypeId = json['mega_type_id'];
    title = json['title'];
    status = json['status'];
    category = json['category'];
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
    data['cat_id'] = this.catId;
    data['mega_cat_id'] = this.megaCatId;
    data['mega_type_id'] = this.megaTypeId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['category'] = this.category;
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