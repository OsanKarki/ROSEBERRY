import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/presentation/routes/routes.dart';
import '../model/filter_query_params.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({Key? key}) : super(key: key);

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  late String searchQuery;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10), child: SizedBox.shrink(),
        ),
        backgroundColor: kGreen600,
        flexibleSpace: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.only(top: 28),
                child: Container(
                  height: 45,
                  width: 300,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search products',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                if (searchQuery.isNotEmpty) {
                  Get.toNamed(
                    AppRoutes.productListingPage,
                    arguments: FilterQueryParams(searchQuery: searchQuery),
                  );
                }
              },
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}
