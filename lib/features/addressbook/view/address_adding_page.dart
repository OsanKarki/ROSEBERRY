import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/core/widgets/primary_button.dart';
import 'package:ecommerce_app/core/widgets/primary_textfield.dart';
import 'package:ecommerce_app/features/addressbook/view/controller/non_default_address_adding_controller.dart';
import 'package:ecommerce_app/features/addressbook/view/controller/country_province_listing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/address_params_model.dart';
import '../model/country_model.dart';
import 'controller/country_listing_controller.dart';

class AddressAddingPage extends StatefulWidget {
  const AddressAddingPage({Key? key}) : super(key: key);

  @override
  State<AddressAddingPage> createState() => _AddressAddingPageState();
}

class _AddressAddingPageState extends State<AddressAddingPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final telephoneNoController = TextEditingController();
  final provinceController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final streetController = TextEditingController();
  final companyController = TextEditingController();
  final postalCodeController = TextEditingController();
  final provinceIdController = TextEditingController();

  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreen600,
        title: Text("Add Address"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PrimaryTextField(
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "This field is required";
                      }
                    },
                    prefixIcon: Icons.person,
                    label: "First name",
                    controller: firstNameController,
                  ),
                  PrimaryTextField(
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "This field is required";
                      }
                    },
                    prefixIcon: Icons.person,
                    label: "Last name",
                    controller: lastNameController,
                  ),
                  PrimaryTextField(
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "This field is required";
                      }
                    },
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.phone,
                    label: "Telephone no",
                    controller: telephoneNoController,
                  ),
                  DropdownButtonFormField<CountryModel>(
                    decoration: InputDecoration(
                      labelText: 'Country',
                      prefixIcon: Icon(Icons.location_city_sharp),
                    ),
                    items: Get.find<CountryListingController>()
                        .countryList
                        .map<DropdownMenuItem<CountryModel>>(
                            (CountryModel country) {
                          return DropdownMenuItem<CountryModel>(
                            key: ValueKey(country),
                            value: country,
                            child: Text(country.fullName ?? 'null'),
                          );
                        }).toList(),
                    onChanged: (CountryModel? value) {
                      print("@@@@@@@@@@@@@@@@@@@@@@@@@@22");
                      print(value?.code);
                      countryController.text = value?.code ?? '';
                      Get.find<ProvinceListingController>()
                          .getProvinceInfo("${value?.code}");
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a country';
                      }
                      return null;
                    },
                  ),
                  PrimaryTextField(
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "This field is required";
                      }
                    },
                    label: "City",
                    prefixIcon: Icons.location_city,
                    controller: cityController,
                  ),
                  buildProvinceWidget(),
                  PrimaryTextField(
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "This field is required";
                      }
                    },
                    label: "Street",
                    prefixIcon: Icons.add_road,
                    controller: streetController,
                  ),
                  PrimaryTextField(
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "This field is required";
                      }
                    },
                    prefixIcon: Icons.local_post_office,
                    label: "Company",
                    controller: companyController,
                  ),
                  PrimaryTextField(
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "This field is required";
                      }
                    },
                    label: "Postal code",
                    prefixIcon: Icons.post_add,
                    controller: postalCodeController,
                    keyboardType: TextInputType.number ,
                  ),
                  PrimaryButton(
                    text: "Continue",
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        Get.find<AddNonDefaultAddressController>()
                            .addingAddress(
                          context,
                          AddressAddingParams(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            city: cityController.text,
                            company: companyController.text,
                            country: countryController.text,
                            postalCode: postalCodeController.text,
                            province: provinceController.text,
                            provinceId: provinceIdController.text,
                            street: streetController.text,
                            telephoneNo: telephoneNoController.text,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProvinceWidget() {
    return GetBuilder<ProvinceListingController>(
      builder: (controller) {
        final provinceList = controller.provinceList;

        if (provinceList.isEmpty) {
          return PrimaryTextField(
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                return null;
              } else {
                return "This field is required";
              }
            },
            label: "Province",
            prefixIcon: Icons.location_on,
            controller: provinceController,
          );
        } else {
          return DropdownButtonFormField<CountryProvinceModel>(
            decoration: InputDecoration(
              labelText: 'Province',
            ),
            items: provinceList
                .map<DropdownMenuItem<CountryProvinceModel>>(
                  (CountryProvinceModel province) {
                return DropdownMenuItem<CountryProvinceModel>(
                  key: ValueKey(province),
                  value: province,
                  child: Text(province.name ?? ''),
                );
              },
            ).toList(),
            onChanged: (CountryProvinceModel? value) {
              provinceController.text = value?.name ?? '';
              provinceIdController.text = value?.code ?? '';

            },
            validator: (value) {
              if (value == null) {
                return 'Please select a province';
              }
              return null;
            },
          );
        }
      },
    );

    }
  }


