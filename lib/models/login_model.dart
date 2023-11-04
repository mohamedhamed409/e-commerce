class ShopLoginModel
{
  late bool status;
   String? message;// if we put ? there will be an error in shop_login_screen in this part >>>   msg: (state.modelLogin.message),
  UserData ?data;//complete the line above >> but using ? is the best because late make a lot of error like Null is not subtype of String ,and another problems late make
  ShopLoginModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
    data=json['data']!=null?UserData.fromJson(json['data']):null;
   
  }
}
class UserData
{

   int? id;
   String? name;
   String? email;
   String? phone;
   String? image;
   int? points;
   int? credit;
   String? token;

  // UserData({
  //   this.id,
  //   this.name,
  //   this.email,
  //   this.phone,
  //   this.image,
  //   this.points,
  //   this.credit,
  //   this.token,
  // });
   UserData.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];
  }



}