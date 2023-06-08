import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'core/presentation/routes/routes.dart';
import 'package:device_preview/device_preview.dart';

import 'main_common.dart';

void main() {
  runApp( DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => EcommerceApp(), // Wrap your app
  ),);
}

