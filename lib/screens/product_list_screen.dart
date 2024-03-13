import 'package:flutter/material.dart';
import 'package:isoftronics_interview/controller/product_controller.dart';
import 'package:isoftronics_interview/model/product_model.dart';
import 'create_product_data_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductController _controller = ProductController();

  Future<void> _refresh() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    setState(() {
      _controller.fetchProductData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product List",
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
          future: _controller.fetchProductData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No questions found'));
            } else {
              List<ProductModel> product = snapshot.data!;
              return RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                      ProductModel products = product[index];
                      return Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, bottom: 5, top: 5),
                          child: Card(
                            surfaceTintColor: Colors.white,
                            elevation: 2,
                            child: ListTile(
                              title: Text(
                                products.productName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(products.productSubName),
                              trailing: PopupMenuButton(onSelected: (value) {
                                setState(() {
                                  if (value == "edit") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateProductDataScreen(
                                                  model: products,
                                                ))).then((value) => _refresh());
                                  } else if (value == "delete") {
                                    _controller
                                        .deleteProductData(products.id ?? "");
                                  }
                                });
                              }, itemBuilder: (context) {
                                return [
                                  const PopupMenuItem(
                                      value: "edit",
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit),
                                          Text("Edit"),
                                        ],
                                      )),
                                  const PopupMenuItem(
                                      value: "delete",
                                      child: Row(children: [
                                        Icon(Icons.delete),
                                        Text("Delete")
                                      ]))
                                ];
                              }),
                            ),
                          ));
                    }),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateProductDataScreen()))
              .then((value) => _refresh());
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
