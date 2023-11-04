class SearchModel {
  bool? status;
  String? message;
  Data? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data']!=null?Data.fromJson(json['data']):null;
  }
}

class Data {
  int? currentPage;
  List<Product> data2=[];


  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data2 = <Product>[];
      json['data'].forEach((v) {
        data2.add( Product.fromJson(v));
      });
    }
  }

}






class Product {

  int? id;
  dynamic price;

  String? image;
  String name = '';
  String? description;
  dynamic oldPrice;
  dynamic discount;
  List<String>?images;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}





