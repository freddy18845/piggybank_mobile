import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../dailog/pin_reset.dart';
import '../utils/nav.dart';
import '../utils/route_memory.dart';
import '../utils/screen_size.dart';
import '../utils/utils.dart';
import '../view_models/lock_pin_view_model.dart';
import '../widgets/numpad.dart';


class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  String pin = '';
  String correctPin = '';
  String newPinOne = '';
  String newPinTwo = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final lockViewModel = context.read<LockPinViewModel>();
      correctPin = await lockViewModel.getLockPin();
      if(correctPin.isEmpty){
        showCustomSnackBar(context, "Create A New Pin",
            isSuccess: true);
      }
      setState(() {}); // ✅ refresh UI once PIN is loaded
    });
  }

  void _handlePinInput(String value, LockPinViewModel pinStore) async {
    setState(() => pin = value);
    if(pin.length==6){
      if ( pin == correctPin) {
        final lastRoute = RouteMemory.lastRoute;

        if (lastRoute != null) {
          RouteMemory.clear();
          Navigator.pushNamedAndRemoveUntil(context, lastRoute, (route) => false);
        } else {
          AppNavigator.toHome(context);
        }

      } else {
        showCustomSnackBar(context, "Incorrect PIN, try again!",
            isSuccess: false);
        await Future.delayed(const Duration(milliseconds: 300));
        setState(() => pin = '');
      }
    }





  }

  @override
  Widget build(BuildContext context) {
    final size = ScreenSize();
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: size.getScreenWidth(3),
              vertical: size.getScreenHeight(8),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/${IMAGES[2]}'),
                fit: BoxFit.fill,
              ),
            ),
            child: Consumer<LockPinViewModel>(
              builder: (context, pinStore, child) {
                return Column(
                  children: [
                    Icon(Icons.lock_clock,
                        color: SECONDARY_COLOR,
                        size: size.getScreenHeight(4.5)),
                    SizedBox(height: size.getScreenHeight(1)),
                    Text(
                       "Enter PIN to Unlock App",

                      style: TextStyle(
                        fontSize: size.getScreenWidth(4),
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: size.getScreenHeight(3)),

                    // 🔹 PIN indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        bool filled = index < pin.length;
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.getScreenWidth(2)),
                          height: size.getScreenHeight(2),
                          width: size.getScreenHeight(2),
                          decoration: BoxDecoration(
                            color: filled ? SECONDARY_COLOR : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: SECONDARY_COLOR, width: 1.5),
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: size.getScreenHeight(3)),

                    InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) => const PinResetDialog(),
                      ),
                      child: Text(
                        correctPin.isEmpty? "Create New PIN":"Change PIN",
                        style: TextStyle(
                          fontSize: size.getScreenWidth(3),
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: size.getScreenHeight(1)),
                   

                    // 🔹 NumPad
                   Expanded(child:  NumPad(
                     shuffle: false,
                     limit: 6,
                     onInput: (value) => _handlePinInput(value, pinStore),
                   ),)
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
