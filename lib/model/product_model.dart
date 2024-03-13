
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  String? id;
  String productName;
  String productSubName;
  String productDescription;
  String productPrice;
  String productQuantity;

  ProductModel({
    this.id,
    required this.productName,
    required this.productSubName,
    required this.productDescription,
    required this.productPrice,
    required this.productQuantity,
});

  factory ProductModel.fromJson(QueryDocumentSnapshot doc){
    Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
    return ProductModel(
      id:doc.id,
        productName: data["productName"],
        productSubName: data["productSubName"],
        productDescription: data["productDescription"],
        productPrice: data["productPrice"],
        productQuantity: data["productQuantity"]);
  }

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'productName':productName,
      'productSubName':productSubName,
      'productDescription':productDescription,
      'productPrice':productPrice,
      'productQuantity':productQuantity
    };
  }
}