import 'package:aara/model/response.dart';

class Category {
  int responseCode;
  ResponseData responseData;
  String comments;
  bool status;
  String env;

  Category(
      {this.responseCode,
      this.responseData,
      this.comments,
      this.status,
      this.env});

  Category.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseData = json['response_data'] != null
        ? new ResponseData.fromJson(json['response_data'])
        : null;
    comments = json['comments'];
    status = json['status'];
    env = json['env'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    if (this.responseData != null) {
      data['response_data'] = this.responseData.toJson();
    }
    data['comments'] = this.comments;
    data['status'] = this.status;
    data['env'] = this.env;
    return data;
  }
}