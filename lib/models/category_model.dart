class CategoryModel
{
   bool? status;
   CategoryDataModel? data;
  CategoryModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    data=CategoryDataModel.fromJson(json['data']);
  }
}
class CategoryDataModel
{
  late int currentPage;
  List<CategoryData>myData=[];
  CategoryDataModel.fromJson(Map<String,dynamic> json)
  {
    currentPage=json['current_page'];
    json['data'].forEach((element)
    {
      myData.add(CategoryData.fromJson(element));
    });
  }

}
class CategoryData
{
   int? id;
   String? name;
   String? image;

  CategoryData.fromJson(Map<String,dynamic>json)
  {
     id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}