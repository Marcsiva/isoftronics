import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isoftronics_interview/model/product_model.dart';

class ProductController {
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection("PRODUCT");

  Future<void> createProductData(ProductModel model) async {
    await productCollection.doc(model.id).set(model.toJson());
  }

  Future<List<ProductModel>> fetchProductData() async {
    try {
      QuerySnapshot<Object?> querySnapshot = await productCollection.get();
      List<ProductModel> productList =
          querySnapshot.docs.map((e) => ProductModel.fromJson(e)).toList();
      return productList;
    } catch (e) {
      //ignore:avoid_print
      print("Fetching Error: $e");
      return [];
    }
  }

  Future<void> updateProductData(ProductModel model) async {
    try {
      DocumentReference product = productCollection.doc(model.id);
      await product.update(model.toJson());
    } catch (e) {
      //ignore:avoid_print
      print("Error updating product data : $e");
    }
  }

  Future<void> deleteProductData(String id) async {
    await productCollection.doc(id).delete();
  }
}
