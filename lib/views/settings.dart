import 'package:flutter/material.dart';
import 'package:piggy_bank/widgets/footer.dart';

import '../constant.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GRAY_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            
            //for the footer
            Footer(btnIndex: 2),
          ],
        ),
      ),
    );
  }
}
