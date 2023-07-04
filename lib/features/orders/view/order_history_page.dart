import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/features/orders/view/controller/get_orders_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/error_view.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(backgroundColor: kGreen600, title: Text("Order History")),
        body: GetBuilder<GetOrdersInfoController>(builder: (controller) {
          final result = controller.result;
          if (result != null) {
            return result.fold((l) => ErrorView(l.value), (orderList) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: orderList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,

                            borderRadius: BorderRadius.circular(10)
                        ),
                        height: 80,
                        padding: EdgeInsets.all(5),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order NO: ${orderList[index].referenceId}",style: Theme.of(context).textTheme.titleSmall,),
                              Text("${orderList[index].status}",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: orderList[index].status=="pending"?Colors.orangeAccent:kGreen400),),
                            ],
                          ),
                            Text("Nrs: ${double.parse("${orderList[index].total}")}",style: Theme.of(context).textTheme.titleSmall,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Ordered by ${orderList[index].shippingName}"),
                                Text("Purchased on ${orderList[index].createdAt}"),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }));
  }
}
