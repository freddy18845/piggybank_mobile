import 'dart:io';
import 'package:flutter/material.dart';
import 'package:piggy_bank/dailog/add_customer_modal.dart';
import 'package:piggy_bank/widgets/button.dart';
import 'package:piggy_bank/widgets/inputFeild.dart';
import '../constant.dart';
import '../models/customerData.dart';
import '../utils/fonts_style.dart';
import '../utils/screen_size.dart';
import '../view_models/customers_view_model.dart';
import '../widgets/header.dart';
 // Import your CustomersViewModel here

class AddCustomersScreen extends StatefulWidget {
  const AddCustomersScreen({super.key});

  @override
  State<AddCustomersScreen> createState() => _AddCustomersScreenState();
}

class _AddCustomersScreenState extends State<AddCustomersScreen> {
  int selectedValue = 0;
  String caption = 'Personal Data';
  String? _selectedRadioValue;
  File? image;
  CustomerData customerData = CustomerData();

  // Create controllers
  late TextEditingController firstNameController;
  late TextEditingController middleNameController;
  late TextEditingController lastNameController;
  late TextEditingController dobController;
  late TextEditingController nationalIdController;
  late TextEditingController idNumberController;
  late TextEditingController contactController;
  late TextEditingController whatsappController;
  late TextEditingController emailController;
  late TextEditingController occupationController;
  late TextEditingController locationController;
  late TextEditingController nextOfKinNameController;
  late TextEditingController nextOfKinRelationController;
  late TextEditingController nextOfKinOccupationController;
  late TextEditingController nextOfKinContactController;
  late TextEditingController gpsAddressController;

  @override
  void initState() {
    super.initState();


    firstNameController = TextEditingController();
    middleNameController = TextEditingController();
    lastNameController = TextEditingController();
    dobController = TextEditingController();
    nationalIdController = TextEditingController();
    idNumberController = TextEditingController();
    contactController = TextEditingController();
    whatsappController = TextEditingController();
    emailController = TextEditingController();
    occupationController = TextEditingController();
    locationController = TextEditingController();
    nextOfKinNameController = TextEditingController();
    nextOfKinRelationController = TextEditingController();
    nextOfKinOccupationController = TextEditingController();
    nextOfKinContactController = TextEditingController();
    gpsAddressController = TextEditingController();
  }



  Widget handleSelected(BuildContext context) {
    Widget inputRow(List<Widget> children) {
      return Row(
        children: children
            .expand((child) => [
          Expanded(child: child),
          SizedBox(width: ScreenSize().getScreenWidth(1.5)),
        ])
            .toList()
          ..removeLast(),
      );
    }

    switch (selectedValue) {
      case 0:
        return Column(children: [
          inputRow([
            InputFeild(
              controller: firstNameController,
              isOptional: false,
              isNum: false,
              icon: Icons.verified_user_outlined,
              inputLimit: 12,
              placeholder: 'eg. John',
              inputFeild: (value) {
                customerData.firstName = value;
              },
              inputLabel: 'First Name',
            ),
            InputFeild(
              controller: middleNameController,
              isOptional: true,
              isNum: false,
              icon: Icons.verified_user_outlined,
              inputLimit: 20,
              placeholder: 'eg. Kwame',
              inputFeild: (value) {
                customerData.middleName = value;
              },
              inputLabel: 'Middle Name',
            ),

          ]),


            InputFeild(
              controller: lastNameController,
              isOptional: false,
              isNum: false,
              icon: Icons.verified_user_outlined,
              inputLimit: 20,
              placeholder: 'eg. Doe',
              inputFeild: (value) {
                customerData.lastName = value;
              },
              inputLabel: 'Last Name',
            ),

          inputRow(
            [
              DateInputField(
                dateController: dobController,
                placeholder: '',
                inputLabel: 'Date Of Birth',
                inputField: (value) { // <-- Correct spelling
                  customerData.dob = value;
                },
              ),

              InputFeild(
                controller: nationalIdController,
                isOptional: false,
                isNum: false,
                icon: Icons.card_membership_outlined,
                inputLimit: 20,
                placeholder: 'eg. Ghana Card',
                inputFeild: (value) {
                  customerData.idCardType = value;
                },
                inputLabel: 'National ID',
              ),
            ],
          ),
          inputRow([
            InputFeild(
              controller: idNumberController,
              isOptional: false,
              isNum: false,
              icon: Icons.pin_outlined,
              inputLimit: 20,
              placeholder: 'eg.GHA-000000000-1',
              inputFeild: (value) {
                customerData.idNumber = value;
              },
              inputLabel: 'ID Number',
            ),
            InputFeild(
              controller: gpsAddressController,
              isOptional: false,
              isNum: false,
              icon: Icons.pin_outlined,
              inputLimit: 20,
              placeholder: 'eg.GA-44-43-1',
              inputFeild: (value) {
                customerData.gpsAddress = value;
              },
              inputLabel: 'GPS Address',
            ),
          ]),
          inputRow([
            Btn(
              btn: RED_COLOR,
              btnText: 'Cancel',
              btnAction: () => setState(() => selectedValue = 0),
            ),
            Btn(
              btn: GREEN_COLOR,
              btnText: 'Proceed',
              btnAction: () => setState(() {
                selectedValue = 1;
                caption = "Contact Details";
              }),
            ),
          ]),
        ]);

      case 1:
        return Column(
          children: [
            InputFeild(
              controller: contactController,
              icon: Icons.contact_phone_outlined,
              placeholder: 'eg. 02400000011',
              inputFeild: (value) {
                customerData.contact = value;
              },
              inputLabel: 'Contact',
              isNum: true,
              inputLimit: 10,
              isOptional: false,
            ),
            InputFeild(
              controller: whatsappController,
              icon: Icons.perm_phone_msg_outlined,
              placeholder: 'Optional',
              inputFeild: (value) {
                customerData.whatsappNo = value;
              },
              inputLabel: 'WhatsApp No.',
              isNum: true,
              inputLimit: 10,
              isOptional: true,
            ),
            EmailInputField(
              controller: emailController,
              icon: Icons.email_outlined,
              placeholder: 'eg. johnDoe56@gmail.com',
              inputFeild: (value) {
                customerData.email = value;
              },
              inputLabel: 'Email',
              inputLimit: 40,
              isOptional: false,
            ),
            inputRow([
              InputFeild(
                controller: occupationController,
                isOptional: false,
                isNum: false,
                icon: Icons.work_outlined,
                inputLimit: 18,
                placeholder: 'eg. Trader',
                inputFeild: (value) {
                  customerData.occupation = value;
                },
                inputLabel: 'Occupation',
              ),
              InputFeild(
                controller: locationController,
                isOptional: false,
                isNum: false,
                icon: Icons.location_on_outlined,
                inputLimit: 18,
                placeholder: 'eg. Osu',
                inputFeild: (value) {
                  customerData.location = value;
                },
                inputLabel: 'Location',
              ),
            ]),
            inputRow([
              Btn(
                btn: RED_COLOR,
                btnText: 'Previous',
                btnAction: () => setState(() {
                  selectedValue = 0;
                  caption = "Personal Data";
                }),
              ),
              Btn(
                btn: GREEN_COLOR,
                btnText: 'Proceed',
                btnAction: () => setState(() {
                  selectedValue = 2;
                  caption = "Next of Kin Data";
                }),
              ),
            ]),
          ],
        );

      case 2:
        return Column(
          children: [
            InputFeild(
              controller: nextOfKinNameController,
              isOptional: false,
              isNum: false,
              icon: Icons.person_2_outlined,
              inputLimit: 12,
              placeholder: 'eg. Helen Doe',
              inputFeild: (value) {
                customerData.nextOfKinName = value;
              },
              inputLabel: 'Full Name',
            ),
            InputFeild(
              controller: nextOfKinRelationController,
              isOptional: false,
              isNum: false,
              icon: Icons.diversity_3_outlined,
              inputLimit: 50,
              placeholder: 'eg. Wife',
              inputFeild: (value) {
                customerData.relation = value;
              },
              inputLabel: 'Relation',
            ),
            InputFeild(
              controller: nextOfKinOccupationController,
              isOptional: false,
              isNum: false,
              icon: Icons.work_outline_outlined,
              inputLimit: 50,
              placeholder: 'eg. Trader',
              inputFeild: (value) {
                customerData.nextOfKinOccupation = value;
              },
              inputLabel: 'Occupation',
            ),
            inputRow([
              InputFeild(
                controller: nextOfKinContactController,
                isOptional: false,
                isNum: true,
                icon: Icons.contact_phone_outlined,
                inputLimit: 10,
                placeholder: 'eg. 02400000011',
                inputFeild: (value) {
                  customerData.nextOfKinContact = value;
                },
                inputLabel: 'Contact',
              ),

            ]),
            inputRow([
              Btn(
                btn: RED_COLOR,
                btnText: 'Previous',
                btnAction: () => setState(() {
                  selectedValue = 1;
                  caption = "Contact Details";
                }),
              ),
              Btn(
                  btn: GREEN_COLOR,
                  btnText: 'Done',
                  btnAction: () {
                    NewCustomerDataModal.show(context, customerData);
                    customerData = CustomerData();
                    setState(() {
                      selectedValue = 0;
                      caption = "Personal Data";
                    });
                  }),
            ]),
          ],
        );

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/${IMAGES[2]}',
                    ),
                    fit: BoxFit.fill)),
            child: Column(
              children: [
                const Header(
                  showHome: false,
                  showPrevious: true,
                  showLogo: false,
                  selectedBtn: 'Register',
                  show2Nav: true,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenSize().getScreenHeight(0.5)),
                  child: Text(
                    caption,
                    style: FontsStyle().subTitleTwo(),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize().getScreenWidth(6)),
                    child: handleSelected(context)),
              ],
            ),
          )),
    );
  }
}
