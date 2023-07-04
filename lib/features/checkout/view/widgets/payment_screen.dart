import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/features/checkout/view/controller/get_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Shipping Methods"),
          SizedBox(
            height: 10,
          ),
          GetBuilder<PaymentController>(builder: (controller) {
            final result = controller.result;
            if (result != null) {
              return result.fold((l) => SizedBox.shrink(), (paymentDetail) {
                return Container(
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: kGreen600),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: kGreen600,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("${paymentDetail.label}"),
                      ],
                    ));
              });
            } else {
              return CircularProgressIndicator();
            }
          })
        ],
      ),
    );
  }
}
