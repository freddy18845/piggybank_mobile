import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:piggy_bank/constant.dart';
import 'package:piggy_bank/utils/fonts_style.dart';
import 'package:piggy_bank/utils/screen_size.dart';
import 'package:piggy_bank/view_models/customers_view_model.dart';
import '../models/customerData.dart';
import 'package:piggy_bank/widgets/button.dart';

class NewCustomerDataModal extends StatefulWidget {
  final CustomerData customerData;
  final BuildContext parentContext;

  const NewCustomerDataModal({
    Key? key,
    required this.customerData,
    required this.parentContext,
  }) : super(key: key);

  static Future<void> show(BuildContext context, CustomerData customerData) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => NewCustomerDataModal(
        customerData: customerData,
        parentContext: context,
      ),
    );
  }

  @override
  State<NewCustomerDataModal> createState() => _NewCustomerDataModalState();
}

class _NewCustomerDataModalState extends State<NewCustomerDataModal> {
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final customerData = widget.customerData;

    return AlertDialog(
      alignment: Alignment.topCenter,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.only(top: ScreenSize().getScreenHeight(20)),
      content: Container(
        height: ScreenSize().getScreenHeight(62),
        width: ScreenSize().getScreenWidth(90),
        padding: EdgeInsets.symmetric(
          vertical: ScreenSize().getScreenHeight(2),
          horizontal: ScreenSize().getScreenWidth(4),
        ),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Customer Data"),
            _dataRow("First Name:", customerData.firstName),
            _dataRow("Middle Name:", customerData.middleName ?? "N/A"),
            _dataRow("Last Name:", customerData.lastName),
            _dataRow("National ID:", customerData.idCardType),
            _dataRow("National ID No.:", customerData.idNumber ?? "N/A"),
            _dataRow("Contact:", customerData.contact),
            _dataRow("Other Contact:", customerData.whatsappNo ?? "N/A"),
            _dataRow("Email:", customerData.email ?? "N/A"),
            _dataRow("Occupation:", customerData.occupation),
            _dataRow("Date Of Birth:", customerData.dob),
            _dataRow("Location:", customerData.location),
            _dataRow("GPS Address:", customerData.gpsAddress ?? "N/A"),
            const Divider(thickness: 1),
            _sectionTitle("Next Of Kin Data"),
            _dataRow("Full Name:", customerData.nextOfKinName),
            _dataRow("Relation:", customerData.relation),
            _dataRow("Occupation:", customerData.nextOfKinOccupation),
            _dataRow("Contact:", customerData.nextOfKinContact),
            const Spacer(),
            const Divider(thickness: 1),
            Row(
              children: [
                Expanded(
                  child: Btn(
                    btn: RED_COLOR,
                    btnText: 'Close',
                    btnAction: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: ScreenSize().getScreenWidth(4)),
                Expanded(
                  child: Btn(
                    btn: SECONDARY_COLOR,
                    btnText: 'Submit',
                    btnAction: () async {
                      setState(() => isProcessing = true);

                      try {
                        await Provider.of<CustomersViewModel>(
                                widget.parentContext,
                                listen: false)
                            .createCustomer(widget.parentContext,
                                widget.customerData.toJson());

                        if (mounted) Navigator.pop(context);
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Form submission failed: $e"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } finally {
                        if (mounted) setState(() => isProcessing = false);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Column(
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: ScreenSize().getScreenHeight(1.6),
              fontWeight: FontWeight.w800,
              color: SECONDARY_COLOR,
            ),
          ),
        ),
        const Divider(thickness: 1),
      ],
    );
  }

  Widget _dataRow(String label, String? value) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: ScreenSize().getScreenHeight(0.1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: FontsStyle().newCustomerTitle()),
          Flexible(
            child: Text(
              value ?? "N/A",
              textAlign: TextAlign.end,
              style: FontsStyle().newCustomerText(),
            ),
          ),
        ],
      ),
    );
  }
}
