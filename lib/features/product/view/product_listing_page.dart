import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/features/product/controller/product_listing_controller.dart';
import 'package:ecommerce_app/features/product/model/filter_query_params.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../core/widgets/error_view.dart';

class ProductListingPage extends StatefulWidget {

  const ProductListingPage({Key? key, }) : super(key: key);

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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kGreen600,
          elevation: 0,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 340,
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
                          Center(child: Icon(CupertinoIcons.bag_badge_minus,size: 100,color: Colors.orangeAccent,)),
                          Center(child: Text('No Product Is Here For Now',style: TextStyle(color: Colors.orangeAccent,fontSize: 20,fontWeight: FontWeight.w500),))
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
                                onTap: (){
                                  Get.toNamed(AppRoutes.productDetails,arguments: FilterQueryParams(sku: productList[index].sku));

                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  color: Colors.white70,
                                  height: 300,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Image.network("${productList[index].image}",

                                            ),
                                      ),
                                      Text(
                                        "${productList[index].name}",
                                        style: const TextStyle(color: kGreen600),
                                      ),
                                      Text(
                                        "Rs:${double.parse("${productList[index].price}")}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.redAccent),
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
