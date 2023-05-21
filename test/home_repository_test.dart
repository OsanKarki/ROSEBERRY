import 'dart:convert';

import 'package:ecommerce_app/features/home/model/image_slider_model.dart';
import 'package:ecommerce_app/features/home/repository/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fixtures/fixture_reader.dart';


void main(){
  test("shall convert image slider json to list of dart model", ()async {
    final json = jsonDecode(fixture("image_slider_list.json"));
    final either = await HomeRepository().getImageSlider();
    var list = <ImageSliderModel>[];
    either.fold((l) {

    }, (r) {
      list= r;
    });
    expect(list.length,4);
  });
}