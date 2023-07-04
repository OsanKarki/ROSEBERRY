import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/features/checkout/view/controller/get_order_summary_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/error_view.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({
    super.key,
  });

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: GetBuilder<GetOrderSummaryController>(
          init: GetOrderSummaryController(),builder: (controller) {
        final result = controller.result;
        if (result != null) {
          return result.fold((l) => ErrorView(l.value), (orderSummaryList) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your Order:"),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: orderSummaryList.items?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            height: 80,
                            color: Colors.white,
                            child: Row(
                              children: [
                                Container(
                                    height: 70,
                                    width: 70,
                                    child: Image.network(
                                        "${orderSummaryList.items?[index].image}")),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        width: 100,
                                        child: Text(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          "${orderSummaryList.items?[index].name}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(fontSize: 12),
                                        )),
                                    Row(
                                      children: [
                                        Text(
                                          "Quantity: ${double.parse("${orderSummaryList.items?[index].qty}")}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        SizedBox(
                                          width: 90,
                                        ),
                                        Text(
                                          "Rs: ${double.parse("${orderSummaryList.items?[index].price}")}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Sub Total: ",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "${double.parse("${orderSummaryList.subTotal}")} ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.orangeAccent),
                        ),
                      ],
                    ),
                    Text(
                      "Shipping Fee: ${double.parse("${orderSummaryList.shippingAmount}")}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Net Total: ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "${double.parse("${orderSummaryList.grandTotal}")} ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.orangeAccent),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.orangeAccent)),
                  child: Text("${orderSummaryList.shippingDescription}"),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Payment Method: ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "${orderSummaryList.paymentMethod} ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: kGreen600),
                    ),
                  ],
                ),
              ],
            );
          });
        } else {
          return SizedBox.shrink();
        }
      }),
    );
    Divider(
      thickness: 2,
    );
  }
}
