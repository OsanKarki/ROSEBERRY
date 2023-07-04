import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/features/checkout/model/order_response.dart';
import 'package:ecommerce_app/features/checkout/view/controller/checkout_controller.dart';
import 'package:ecommerce_app/features/checkout/view/controller/get_payment_controller.dart';
import 'package:ecommerce_app/features/checkout/view/controller/initiate_transaction_ontroller.dart';
import 'package:ecommerce_app/features/checkout/view/controller/place_order_controller.dart';
import 'package:ecommerce_app/features/checkout/view/controller/set_payment_controller.dart';
import 'package:ecommerce_app/features/checkout/view/controller/shipping_controller.dart';
import 'package:ecommerce_app/features/checkout/view/widgets/payment_screen.dart';
import 'package:ecommerce_app/features/checkout/view/widgets/summary_screen.dart';
import 'package:ecommerce_app/features/checkout/view/widgets/shipping_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/shipping_info_params.dart';
import '../model/transaction_params.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: Text(""),
          label: Text(
            "Shipping",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          content: ShippingScreen(),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: Text(""),
          label: Text(
            "Payment",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          content: AddressScreen(),
        ),
        Step(
          state: _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: Text(
            "",
          ),
          label: Text(
            "Summary",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          content: ConfirmScreen(),
        ),
      ];
  int _activeStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    final customColor = MaterialColor(
      kGreen600.value,
      <int, Color>{
        50: kGreen600,
        100: kGreen600,
        200: kGreen600,
        300: kGreen600,
        400: kGreen600,
        500: kGreen600,
        600: kGreen600,
        700: kGreen600,
        800: kGreen600,
        900: kGreen600,
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreen600,
        title: Text("Checkout "),
        centerTitle: true,
      ),
      body: Theme(
        data: ThemeData(
          primarySwatch: customColor, // Use the custom color
          primaryColor: kGreen600, // Use the custom color for the app bar
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Stepper(
                  elevation: 0,
                  type: StepperType.horizontal,
                  steps: stepList(),
                  currentStep: _activeStepIndex,
                  onStepContinue: () async {
                    if (_activeStepIndex == 0) {
                      final shippingId = int.tryParse(
                          "${Get.find<CheckoutController>().selectedBillingAddress?.id}");
                      final billingId = int.tryParse(
                          "${Get.find<CheckoutController>().selectedShippingAddress?.id}");

                      if (shippingId != null && billingId != null) {
                        await Get.find<ShippingController>().setShipping(
                            context,
                            ShippingParams(
                              billingAddressId: billingId,
                              shippingAddressId: shippingId,
                              shippingMethod: "freeshipping_freeshipping",
                            ));

                        if (Get.find<ShippingController>().result?.isRight() ??
                            false) {
                          _activeStepIndex += 1;
                          setState(() {
                            // Move to the next step
                          });
                        }
                      } else {
                        final snackBar = GetSnackBar(
                            message: "Your address is missing ",
                            backgroundColor: Colors.red,
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 3),
                            isDismissible: true);
                        Get.showSnackbar(snackBar);
                      }
                    } else if (_activeStepIndex == 1) {
                      final payment = Get.find<PaymentController>()
                          .result
                          ?.fold((l) => null, (r) => r.value);
                      if (payment != null) {
                        Get.find<SetPaymentController>()
                            .setPayment(context, payment);
                        _activeStepIndex += 1;
                        setState(() {});
                      }
                    } else {
                      Get.find<PlaceOrderController>().placeOrder(context);
                    }
                  },
                  onStepCancel: () {
                    if (_activeStepIndex == 0) {
                      return;
                    }
                    _activeStepIndex -= 1;
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
