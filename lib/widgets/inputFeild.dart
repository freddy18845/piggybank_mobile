import 'package:piggy_bank/constant.dart';
import 'package:piggy_bank/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InputFeild extends StatefulWidget {
  final bool isNum;
  final bool isOptional;
  final IconData icon;
  final int inputLimit;
  final String placeholder;
  final String inputLabel;
  final Function inputFeild;
  final TextEditingController? controller;
  const InputFeild({
    super.key,
    required this.isNum,
    required this.icon,
    required this.inputLimit,
    required this.placeholder,
    required this.inputFeild,
    required this.inputLabel,
    required this.isOptional, this.controller,
  });

  @override
  State<InputFeild> createState() => _InputFeildState();
}

class _InputFeildState extends State<InputFeild> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Currency().format('23245')

      height: ScreenSize().getScreenHeight(8),
      width: double.infinity,
      child: TextFormField(
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        autofocus: false,
        controller: widget.controller,
        keyboardType:
            widget.isNum == false ? TextInputType.name : TextInputType.number,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: ScreenSize().getScreenHeight(1.6),
          decoration: TextDecoration.none,
          color: SECONDARY_COLOR,
          fontFamily: 'Poppins',
          letterSpacing: 0.2,
        ),
        inputFormatters: widget.isNum == false
            ? null
            : [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
        maxLength: widget.inputLimit,
        onChanged: (value) {

            widget.inputFeild(value);
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            label: Text(
              widget.inputLabel,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: ScreenSize().getScreenHeight(1.6),
                  fontWeight: FontWeight.w400,
                  color: SECONDARY_COLOR.withOpacity(0.8)),
            ),
            isDense: false,
            prefixIcon: Padding(
              padding: EdgeInsets.all(ScreenSize().getScreenHeight(1)),
              child: Icon(
                widget.icon,
                color: SECONDARY_COLOR.withOpacity(0.5),
                size: ScreenSize().getScreenHeight(3.2),
              ),
            ),
            contentPadding:
                EdgeInsets.only(left: ScreenSize().getScreenWidth(6)),
            hintText: widget.placeholder,
            hintStyle: TextStyle(
                decoration: TextDecoration.none,
                fontSize: ScreenSize().getScreenHeight(1.6),
                fontWeight: FontWeight.w400,
                color: SECONDARY_COLOR.withOpacity(0.5)),
            filled: true,
            fillColor: PRIMARY_COLOR,
            counterText: widget.isOptional == false ? '' : "Optional",
            counterStyle: TextStyle(
                decoration: TextDecoration.none,
                fontSize: ScreenSize().getScreenHeight(0.8),
                fontWeight: FontWeight.w400,
                color: SECONDARY_COLOR.withOpacity(0.5)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: SECONDARY_COLOR.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: SECONDARY_COLOR.withOpacity(0.8),
              ),
            )),
      ),
    );
  }
}

class EmailInputField extends StatefulWidget {
  final bool isOptional;
  final IconData icon;
  final int inputLimit;
  final String placeholder;
  final String inputLabel;
  final Function inputFeild;
  final TextEditingController? controller;

  const EmailInputField({
    super.key,
    required this.icon,
    required this.inputLimit,
    required this.placeholder,
    required this.inputFeild,
    required this.inputLabel,
    required this.isOptional,
    this.controller,
  });

  @override
  State<EmailInputField> createState() => _EmailInputFieldState();
}

class _EmailInputFieldState extends State<EmailInputField> {
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSize().getScreenHeight(8),
      width: double.infinity,
      child: TextFormField(
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        autofocus: false,
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress, // Adjusted for email input
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: ScreenSize().getScreenHeight(1.6),
          decoration: TextDecoration.none,
          color: SECONDARY_COLOR,
          fontFamily: 'Poppins',
          letterSpacing: 0.2,
        ),
        maxLength: widget.inputLimit,
        onChanged: (value) {
          widget.inputFeild(value);
        },
        textInputAction: TextInputAction.done,
        validator: (value) {
          // Validate the email format
          if (value != null && !emailRegExp.hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
        decoration: InputDecoration(
          label: Text(
            widget.inputLabel,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: ScreenSize().getScreenHeight(1.6),
              fontWeight: FontWeight.w400,
              color: SECONDARY_COLOR.withOpacity(0.8),
            ),
          ),
          isDense: false,
          prefixIcon: Padding(
            padding: EdgeInsets.all(ScreenSize().getScreenHeight(1)),
            child: Icon(
              widget.icon,
              color: SECONDARY_COLOR.withOpacity(0.5),
              size: ScreenSize().getScreenHeight(3.2),
            ),
          ),
          contentPadding: EdgeInsets.only(left: ScreenSize().getScreenWidth(6)),
          hintText: widget.placeholder,
          hintStyle: TextStyle(
            decoration: TextDecoration.none,
            fontSize: ScreenSize().getScreenHeight(1.6),
            fontWeight: FontWeight.w400,
            color: SECONDARY_COLOR.withOpacity(0.5),
          ),
          filled: true,
          fillColor: PRIMARY_COLOR,
          counterText: widget.isOptional == false ? '' : "Optional",
          counterStyle: TextStyle(
            decoration: TextDecoration.none,
            fontSize: ScreenSize().getScreenHeight(0.8),
            fontWeight: FontWeight.w400,
            color: SECONDARY_COLOR.withOpacity(0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: SECONDARY_COLOR.withOpacity(0.3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: SECONDARY_COLOR.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }
}



class PasswordInputField extends StatefulWidget {
  final IconData icon;
  final String placeholder;
  final String inputLabel;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;

  const PasswordInputField({
    super.key,
    required this.icon,
    required this.placeholder,
    required this.inputLabel,
    required this.onChanged,
    this.controller,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSize().getScreenHeight(8),
      width: double.infinity,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        obscuringCharacter: '*',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: ScreenSize().getScreenHeight(1.6),
          color: SECONDARY_COLOR,
          fontFamily: 'Poppins',
          letterSpacing: 0.2,
        ),
        onChanged: widget.onChanged,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          label: Text(
            widget.inputLabel,
            style: TextStyle(
              fontSize: ScreenSize().getScreenHeight(1.6),
              fontWeight: FontWeight.w400,
              color: SECONDARY_COLOR.withOpacity(0.8),
            ),
          ),
          hintText: widget.placeholder,
          hintStyle: TextStyle(
            fontSize: ScreenSize().getScreenHeight(1.6),
            fontWeight: FontWeight.w400,
            color: SECONDARY_COLOR.withOpacity(0.5),
          ),
          filled: true,
          fillColor: PRIMARY_COLOR,
          contentPadding: EdgeInsets.only(left: ScreenSize().getScreenWidth(6)),
          prefixIcon: Padding(
            padding: EdgeInsets.all(ScreenSize().getScreenHeight(1)),
            child: Icon(widget.icon, color: SECONDARY_COLOR.withOpacity(0.5), size: ScreenSize().getScreenHeight(3.2)),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
              color: Colors.black,
              size: 22,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: SECONDARY_COLOR.withOpacity(0.3), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: SECONDARY_COLOR.withOpacity(0.8), width: 1),
          ),
          counterText: " ",
        ),
      ),
    );
  }
}



class DateInputField extends StatefulWidget {
  final String placeholder;
  final String inputLabel;
  final Function(String) inputField; // Accepts the selected date
  final TextEditingController dateController;

  const DateInputField({
    super.key,
    required this.placeholder,
    required this.inputLabel,
    required this.inputField,
    required this.dateController,
  });

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSize().getScreenHeight(8),
      width: double.infinity,
      child: TextField(
        controller: widget.dateController,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: ScreenSize().getScreenHeight(1.6),
          decoration: TextDecoration.none,
          color: SECONDARY_COLOR,
          fontFamily: 'Poppins',
          letterSpacing: 0.2,
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1880),
            lastDate: DateTime(5000),
          );

          if (pickedDate != null) {
            String formattedDate = DateFormat("yyyy-MM-dd").format(pickedDate);
            setState(() {
              widget.dateController.text = formattedDate;
            });
            widget.inputField(formattedDate); // Send the picked date
          } else {
            print("Not Selected");
          }
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          label: Text(
            widget.inputLabel,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: ScreenSize().getScreenHeight(1.6),
              fontWeight: FontWeight.w400,
              color: SECONDARY_COLOR.withOpacity(0.8),
            ),
          ),
          isDense: false,
          prefixIcon: Padding(
            padding: EdgeInsets.all(ScreenSize().getScreenHeight(1)),
            child: Icon(
              Icons.date_range,
              color: SECONDARY_COLOR.withOpacity(0.5),
              size: ScreenSize().getScreenHeight(3.2),
            ),
          ),
          contentPadding: EdgeInsets.only(left: ScreenSize().getScreenWidth(6)),
          hintText: widget.placeholder,
          hintStyle: TextStyle(
            decoration: TextDecoration.none,
            fontSize: ScreenSize().getScreenHeight(1.6),
            fontWeight: FontWeight.w400,
            color: SECONDARY_COLOR.withOpacity(0.5),
          ),
          filled: true,
          fillColor: PRIMARY_COLOR,
          counterText: " ",
          counterStyle: TextStyle(
            decoration: TextDecoration.none,
            fontSize: ScreenSize().getScreenHeight(0.8),
            fontWeight: FontWeight.w400,
            color: SECONDARY_COLOR.withOpacity(0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: SECONDARY_COLOR.withOpacity(0.3),
            ),

          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: SECONDARY_COLOR.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }
}

class PinInputFeild extends StatefulWidget {
  final IconData icon;
  final String placeholder;
  final String inputLabel;
  final Function inputFeild;
  final TextEditingController? controller;

  const PinInputFeild({
    super.key,
    required this.icon,
    required this.placeholder,
    required this.inputFeild,
    required this.inputLabel, this.controller,

  });

  @override
  State<PinInputFeild> createState() => _PinInputFeildState();
}

class _PinInputFeildState extends State<PinInputFeild> {


  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   textController.text = '';
  // }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSize().getScreenHeight(8),
      width: double.infinity,
      child: TextFormField(
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        autofocus: false,
        controller: widget.controller,
        keyboardType:TextInputType.number,
        obscureText: true,
        obscuringCharacter: '*',
        maxLength:6,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: ScreenSize().getScreenHeight(1.6),
          decoration: TextDecoration.none,
          color: SECONDARY_COLOR,
          fontFamily: 'Poppins',
          letterSpacing: 0.2,
        ),
        onChanged: (value) {
          widget.inputFeild(value);



        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            label: Text(
              widget.inputLabel,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: ScreenSize().getScreenHeight(1.6),
                  fontWeight: FontWeight.w400,
                  color: SECONDARY_COLOR.withOpacity(0.8)),
            ),
            isDense: false,
            prefixIcon: Padding(
              padding: EdgeInsets.all(ScreenSize().getScreenHeight(1)),
              child: Icon(
                widget.icon,
                color: SECONDARY_COLOR.withOpacity(0.5),
                size: ScreenSize().getScreenHeight(2.8),
              ),
            ),
            contentPadding:
            EdgeInsets.only(left: ScreenSize().getScreenWidth(6)),
            hintText: widget.placeholder,
            hintStyle: TextStyle(
                decoration: TextDecoration.none,
                fontSize: ScreenSize().getScreenHeight(1.3),
                fontWeight: FontWeight.w400,
                color: SECONDARY_COLOR.withOpacity(0.5)),
            filled: true,
            fillColor: PRIMARY_COLOR,
            counterText: " ",

            counterStyle: TextStyle(
                decoration: TextDecoration.none,
                fontSize: ScreenSize().getScreenHeight(0.8),
                fontWeight: FontWeight.w400,
                color: SECONDARY_COLOR.withOpacity(0.5)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: SECONDARY_COLOR.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: SECONDARY_COLOR.withOpacity(0.8),
              ),
            )),
      ),
    );
  }
}

