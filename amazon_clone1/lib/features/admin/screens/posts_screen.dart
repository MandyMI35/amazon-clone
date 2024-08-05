import 'package:amazon_clone1/common/widgets/loader.dart';
import 'package:amazon_clone1/features/account/widgets/single_product.dart';
import 'package:amazon_clone1/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone1/features/admin/services/admin_services.dart';
import 'package:amazon_clone1/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(
        context,
        AddProductScreen.routeName); // routeName = '/add-product'; ,, router.dart
  }

  void deleteProduct(Product product, int index){
    adminServices.deleteProduct(
      context: context, 
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      }, 
      product: product
    );
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {  // to create the individual cells in the grid.
                final productData = products![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(image: productData.images[0]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            productData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                            onPressed: () => deleteProduct(productData, index),
                            icon: const Icon(Icons.delete_outline)),
                      ],
                    )
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: navigateToAddProduct,
              tooltip: 'Add a Product',
              backgroundColor: Colors.cyan[800],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
