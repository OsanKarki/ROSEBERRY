import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/features/product/controller/product_listing_controller.dart';
import 'package:ecommerce_app/features/product/model/filter_query_params.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../core/widgets/error_view.dart';
import '../../auth/view/controller/auth_status_checker_controller.dart';
import '../../cart/model/add_to_cart_params.dart';
import '../../cart/view/controller/add_cart_controller.dart';

class ProductListingPage extends StatefulWidget {
  const ProductListingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductListingPage> createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<ProductListingController>().getProductInfo(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    final AuthStatusController _authStatusController =
        Get.put(AuthStatusController());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kGreen600,
          elevation: 0,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(19),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 50,
                      width: 310,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey.shade700,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Search products',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.notifications_none,
                      size: 25,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade200,
        body: GetBuilder<ProductListingController>(
          builder: (controller) {
            final result = controller.result;

            if (result != null) {
              return result.fold((l) => ErrorView(l.value), (productList) {
                return productList.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Center(
                              child: Icon(
                            CupertinoIcons.bag_badge_minus,
                            size: 100,
                            color: Colors.orangeAccent,
                          )),
                          Center(
                              child: Text(
                            'No Product Is Here For Now',
                            style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ))
                        ],
                      )
                    : MasonryGridView.builder(
                        itemCount: productList.length,
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.productDetails,
                                      arguments: FilterQueryParams(
                                          sku: productList[index].sku));
                                },
                                child: Container(
                                  height: 250,
                                  padding: const EdgeInsets.all(5),
                                  decoration:  BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: kGreen400.withOpacity(0.2),
                                    width: 2.0,
                                  ),
                                ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Image.network(
                                          "${productList[index].image}",
                                          height: 150,
                                        ),
                                      ),
                                      Text(
                                        "${productList[index].name}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.apply(color: kGreen600),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rs:${double.parse("${productList[index].price}")}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.apply(
                                                  color: Colors.red,
                                                ),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                if (productList[index]
                                                        .availability ==
                                                    "IN STOCK") {
                                                  bool isAuthenticated =
                                                      _authStatusController
                                                          .isAuthenticated
                                                          .value;
                                                  if (isAuthenticated) {
                                                    Get.find<CartController>()
                                                        .cartAdd(
                                                            context,
                                                            AddToCartParams(
                                                              sku: productList[
                                                                      index]
                                                                  .sku,
                                                              quantity:
                                                                  productList[
                                                                          index]
                                                                      .quantity,
                                                            ));
                                                  } else {
                                                    Get.toNamed(
                                                        AppRoutes.loginPage);
                                                  }
                                                  ;
                                                }
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: productList[index]
                                                                  .availability ==
                                                              "IN STOCK"
                                                          ? kGreen400
                                                          : Colors.grey,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Container(
                                                  child: Icon(
                                                    productList[index]
                                                                .availability ==
                                                            "IN STOCK"
                                                        ? Icons
                                                            .shopping_cart_outlined
                                                        : Icons
                                                            .remove_shopping_cart_outlined,
                                                    color: productList[index]
                                                                .availability ==
                                                            "IN STOCK"
                                                        ? kGreen400
                                                        : Colors.grey,
                                                    size: 18,
                                                  ),
                                                ),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ));
              });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
