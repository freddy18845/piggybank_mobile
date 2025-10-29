import 'package:flutter/material.dart';
import 'package:piggy_bank/constant.dart';

class FadedDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double width;
  final EdgeInsetsGeometry margin;

  const FadedDivider({
    super.key,
    this.height = 1.0,
    this.color = SECONDARY_COLOR,
    this.width = double.infinity,
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.0),  // Transparent at start
            color.withOpacity(0.7),  // Semi-transparent
            color,                  // Full color in middle
            color.withOpacity(0.7),  // Semi-transparent
            color.withOpacity(0.0),  // Transparent at end
          ],
          stops: const [0.0, 0.2, 0.5, 0.8, 1.0], // Control gradient points
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}

// Example usage:
class FadedDividerExample extends StatelessWidget {
  const FadedDividerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faded Divider Example'),
      ),
      body: const Column(
        children: [
          SizedBox(height: 20),
          Text('Above Divider'),
          FadedDivider(
            height: 2.0,
            color: Colors.blue,
            margin: EdgeInsets.symmetric(horizontal: 20.0),
          ),
          SizedBox(height: 20),
          Text('Below Divider'),
          FadedDivider(
            height: 1.5,
            color: Colors.red,
          ),
          SizedBox(height: 20),
          Text('Another Section'),
          FadedDivider(), // Using default values
        ],
      ),
    );
  }
}