import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Repository/customer_DB.dart';
import '../constant.dart';

import '../utils/screen_size.dart';
import '../view_models/store_view_model.dart';
import '../widgets/inputFeild.dart';

class PasswordResetDialog extends StatefulWidget {

  const PasswordResetDialog({Key? key,})
      : super(key: key);

  @override
  State<PasswordResetDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<PasswordResetDialog> {
  CustomerDBServices instance = CustomerDBServices();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: width * 0.8,
        height: height * 0.4,
        padding: EdgeInsets.symmetric(
            horizontal: ScreenSize().getScreenWidth(6)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Consumer<StoreViewModel>(
          // 👈 wrap with Consumer (or CustomersViewModel if needed)
          builder: (context, storeViewModel, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: ScreenSize().getScreenHeight(2),
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: SECONDARY_COLOR, width: 1.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Password Reset".toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize:
                        width * 0.038 ,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.03),
                    child: Text(
                      "Enter Sign Up Email Address To Reset",
                      style: TextStyle(
                        fontSize:
                        width * 0.03,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: height * 0.005),
                  child: InputFeild(
                    isOptional: false,
                    isNum: false,
                    icon: Icons.email_outlined,
                    inputLimit: 100,
                    placeholder: 'eg. johnDoe@gmail.com',
                    inputFeild: () {},
                    inputLabel: 'Email',
                    controller:
                        storeViewModel.controllers['password_reset_email'],
                  ),
                ),
               InkWell(
                    onTap: () {
                      storeViewModel.reset(context);
                    },
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                        color: SECONDARY_COLOR,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: storeViewModel.isProcessing
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
                                'Send',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: height * 0.014,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                  ),

              ],
            );
          },
        ),
      ),
    );
  }
}
