import 'package:flutter/material.dart';
import '../constants/colors.dart';

enum CheckboxVariant { defaultCheckbox, active, filled }

class Checkbox extends StatefulWidget {
  final ThemeMode themeMode;
  final CheckboxVariant variant;

  const Checkbox({
    super.key,
    this.themeMode = ThemeMode.light,
    this.variant = CheckboxVariant.defaultCheckbox,
  });

  @override
  State<Checkbox> createState() => _CheckboxState();
}

class _CheckboxState extends State<Checkbox> {
  bool _isChecked = false;
  late CheckboxVariant _currentVariant;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _currentVariant = widget.variant;
    _isChecked = _currentVariant == CheckboxVariant.filled;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _updateVariant();
    });
  }

  void _updateVariant() {
    if (_focusNode.hasFocus) {
      _currentVariant = CheckboxVariant.active;
    } else {
      _currentVariant =
          _isChecked ? CheckboxVariant.filled : CheckboxVariant.defaultCheckbox;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Colors based on themeMode
    final Color textColor =
        widget.themeMode == ThemeMode.light
            ? AppColors
                .black // Light mode: Black
            : AppColors.white; // Dark mode: White

    // Border for Active state
    final Border border =
        _currentVariant == CheckboxVariant.active
            ? Border.all(color: AppColors.primary, width: 1)
            : Border.all(color: Colors.transparent);

    return GestureDetector(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
          _updateVariant();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: border,
          color: Colors.transparent, // Transparent background
        ),
        padding: const EdgeInsets.all(4), // Padding for the border
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Checkbox Icon
            Icon(
              _isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              color: AppColors.primary, // Primary Blue 500
              size: 20,
            ),
            // Spacing: 16px
            const SizedBox(width: 16),
            // Text
            Text(
              _isChecked ? 'checked' : 'unchecked',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600, // Semibold
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
