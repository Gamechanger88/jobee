import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppKeys extends StatelessWidget {
  final bool isNumeric;

  const AppKeys({super.key, this.isNumeric = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: AppColors.grey900,
      child: GridView.count(
        crossAxisCount: isNumeric ? 3 : 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children:
            isNumeric
                ? List.generate(12, (index) {
                  if (index == 9) {
                    return const SizedBox.shrink();
                  } else if (index == 10) {
                    return _buildKey('0');
                  } else if (index == 11) {
                    return _buildKey('⌫', icon: Icons.backspace);
                  } else {
                    return _buildKey('${index + 1}');
                  }
                })
                : List.generate(12, (index) {
                  final keys = [
                    'Q',
                    'W',
                    'E',
                    'R',
                    'A',
                    'S',
                    'D',
                    'F',
                    'Z',
                    'X',
                    'C',
                    'V',
                  ];
                  return _buildKey(keys[index]);
                }),
      ),
    );
  }

  Widget _buildKey(String label, {IconData? icon}) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.grey700,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child:
            icon != null
                ? Icon(icon, color: AppColors.white)
                : Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
      ),
    );
  }
}
