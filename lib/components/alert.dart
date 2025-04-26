import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';

enum AlertVariant { success, info, warning, error }

class Alert extends material.StatelessWidget {
  final String message; // Configurable alert message
  final AlertVariant variant; // Alert variant (success, info, warning, error)

  const Alert({
    super.key,
    this.message = 'Alert message', // Default message
    this.variant = AlertVariant.success, // Default to success
  });

  // Get colors based on variant
  material.Color _getColor() {
    switch (variant) {
      case AlertVariant.success:
        return AppColors.green;
      case AlertVariant.info:
        return AppColors.blue;
      case AlertVariant.warning:
        return AppColors.yellow;
      case AlertVariant.error:
        return AppColors.red;
    }
  }

  @override
  material.Widget build(material.BuildContext context) {
    final color = _getColor();

    return material.Container(
      width: double.infinity, // Full width
      padding: const material.EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: material.BoxDecoration(
        color: color.withOpacity(0.2), // Variant color with 20% transparency
        borderRadius: material.BorderRadius.circular(10), // Rounded border 10px
      ),
      child: material.Row(
        crossAxisAlignment:
            material.CrossAxisAlignment.center, // Vertically center children
        children: [
          // First Child: Icon Container
          material.Container(
            width: 18,
            height: 18,
            alignment: material.Alignment.center, // Center icon
            child: material.Icon(
              material.Icons.error, // Alert icon
              color: color, // Variant color
              size: 18,
            ),
          ),
          // Spacing: 6px
          const material.SizedBox(width: 6),
          // Second Child: Alert Message
          material.Expanded(
            child: material.Text(
              message,
              style: material.Theme.of(context).textTheme.labelLarge!.copyWith(
                color: color, // Variant color
                fontWeight: material.FontWeight.w400, // Regular
              ),
              textAlign: material.TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
