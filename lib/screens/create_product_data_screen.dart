import 'package:flutter/material.dart';
import 'package:isoftronics_interview/controller/product_controller.dart';
import 'package:isoftronics_interview/model/product_model.dart';

class CreateProductDataScreen extends StatefulWidget {
  final ProductModel? model;
  const CreateProductDataScreen({super.key, this.model});

  @override
  State<CreateProductDataScreen> createState() =>
      _CreateProductDataScreenState();
}

class _CreateProductDataScreenState extends State<CreateProductDataScreen> {
  final ProductController _controller = ProductController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productSubNameController =
      TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.model?.productName != null) {
      _productNameController.text = widget.model?.productName ?? "";
      _productSubNameController.text = widget.model?.productSubName ?? "";
      _productDescriptionController.text =
          widget.model?.productDescription ?? "";
      _productQuantityController.text = widget.model?.productQuantity ?? "";
      _productPriceController.text = widget.model?.productPrice ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Add Products",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            customTextformfield("Name", Icons.shopping_cart_rounded,
                "your product name", _productNameController),
            customTextformfield("SubName", Icons.shopping_bag_rounded,
                "your product sub name", _productSubNameController),
            customTextformfield("Description", Icons.description,
                "your product description", _productDescriptionController),
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: customTextformfield(
                        "Quantity",
                        Icons.production_quantity_limits,
                        "product quantity",
                        _productQuantityController)),
                Expanded(
                    flex: 2,
                    child: customTextformfield(
                        "Price",
                        Icons.price_change_rounded,
                        "product price",
                        _productPriceController)),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            UnconstrainedBox(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: (){
                    if(_globalKey.currentState!.validate()){
                      _addAndUpdateData();
                    }
                  },
                  child: const Text(
                    "Add Product",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget customTextformfield(String titel, IconData icon, String hintText,
      TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            titel,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(icon),
              filled: true,
              fillColor: Colors.grey.shade300,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.transparent)),
            ),
            validator: (value){
              if(value == null|| value.isEmpty){
                return "Please enter product $titel";
              }
              return null;
            },
          ),
        )
      ],
    );
  }

  void _addAndUpdateData() {
    ProductModel productModel = ProductModel(
        productName: _productNameController.text,
        productSubName: _productSubNameController.text,
        productDescription: _productDescriptionController.text,
        productPrice: _productPriceController.text,
        productQuantity: _productQuantityController.text);
    if (widget.model?.productName != null) {
      productModel.id = widget.model?.id;
      _controller.updateProductData(productModel);
    } else {
      _controller.createProductData(productModel);
    }
    Navigator.pop(context);
  }
}
