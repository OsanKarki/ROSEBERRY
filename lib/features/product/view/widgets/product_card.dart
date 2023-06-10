import 'package:ecommerce_app/features/product/model/filter_query_params.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/presentation/resources/app_colors.dart';
import '../../../../core/presentation/routes/routes.dart';
import '../../model/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.productDetails, arguments: FilterQueryParams(sku: product.sku));
        },
        child: Column(
          children: [
            SizedBox(
              height: 90,
              width: 110,
              child: Image.network("${product.image}", fit: BoxFit.fill),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 20,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                child: Text(
                  textAlign: TextAlign.center,
                  "${product.description}",
                  style:  Theme.of(context).textTheme.bodyLarge?.apply(color: Colors.white,)
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text("Rs ${double.parse("${product.price}")}"),
          ],
        ),
      ),
    );
  }
}
