import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/features/checkout/model/initiate_transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayStackPaymentPage extends StatefulWidget {
  const PayStackPaymentPage({super.key});

  @override
  State<PayStackPaymentPage> createState() => _PayStackPaymentPage();
}

class _PayStackPaymentPage extends State<PayStackPaymentPage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    final InitiateTransactionModel initiateTransactionModel = Get.arguments;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse("${initiateTransactionModel.authorizationUrl}"));
  }

  // WebViewController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreen600,
        automaticallyImplyLeading: false,
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
              Get.until((route) =>route.settings.name==AppRoutes.bottomNavigationBar,
              );
              _showSuccessDialog();

            },
              child: Icon(Icons.clear)),
        )],
      ),
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Transaction successfully done!'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


