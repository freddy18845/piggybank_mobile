import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Repository/customer_DB.dart';
import '../constant.dart';
import '../utils/screen_size.dart';
import '../view_models/lock_pin_view_model.dart';
import '../widgets/inputFeild.dart';

class PinResetDialog extends StatefulWidget {

  const PinResetDialog({Key? key,})
      : super(key: key);

  @override
  State<PinResetDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<PinResetDialog> {
  CustomerDBServices instance = CustomerDBServices();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final lockViewModel = context.read<LockPinViewModel>();
       lockViewModel.emptyField();

    });
    super.initState();
  }








  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: width * 0.8,
        height: height * 0.45,
        padding: EdgeInsets.symmetric(
            horizontal: ScreenSize().getScreenWidth(6)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Consumer<LockPinViewModel>(
          // 👈 wrap with Consumer (or CustomersViewModel if needed)
          builder: (context, lockPinViewModel, child) {
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
                      "User Verification ".toUpperCase(),
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
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                    child: Text(
                      "Enter Details Reset Verification",
                      style: TextStyle(
                        fontSize:
                        width * 0.03,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: height * 0.001),
                  child: InputFeild(
                    isOptional: false,
                    isNum: false,
                    icon: Icons.email_outlined,
                    inputLimit: 100,
                    placeholder: 'eg. johnDoe@gmail.com',
                    inputFeild: () {},
                    inputLabel: 'Email',
                    controller:
                    lockPinViewModel.controllers['email'],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: height * 0.001),
                  child: PasswordInputField(
                    icon: Icons.lock_outline,
                    placeholder: 'eg. ***',

                    inputLabel: 'Password',
                    controller: lockPinViewModel.controllers[
                    'password'], onChanged: (String value) {  }, // Using provider's controller
                  ),




                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: height * 0.001),
                  child:Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: PinInputFeild(
                          icon: Icons.password,
                          placeholder: 'eg. *****',
                          inputFeild: () {},
                          inputLabel: 'New Pin',
                          controller: lockPinViewModel.controllers['pin'], // Using provider's controller
                        ),),
                      SizedBox(width: width * 0.015,),
                      Expanded(
                        flex: 1,
                        child: PinInputFeild(
                          icon: Icons.password,
                          placeholder: 'eg. *****',
                          inputFeild: () {},
                          inputLabel: 'confirm-Pin',
                          controller: lockPinViewModel.controllers['confirm_pin'], // Using provider's controller
                        ),
                          )
                    ],
                  )
                ),
                InkWell(
                  onTap: () {
                    lockPinViewModel.signInVerification(context);
                  },
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      color: SECONDARY_COLOR,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: lockPinViewModel.isProcessing
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white),
                        ),
                      )
                          : Text(
                        'Reset',
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
