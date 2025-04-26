import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';

enum SearchVariant { defaultSearch, active, filled }

class Search extends material.StatefulWidget {
  final material.ThemeMode themeMode;
  final String? initialValue; // Initial value for the text field
  final material.ValueChanged<String>? onChanged; // Callback for text changes
  final material.VoidCallback? onFilterPressed; // Callback for filter icon

  const Search({
    super.key,
    this.themeMode = material.ThemeMode.light,
    this.initialValue,
    this.onChanged,
    this.onFilterPressed,
  });

  @override
  material.State<Search> createState() => _SearchState();
}

class _SearchState extends material.State<Search> {
  late material.TextEditingController _controller;
  late material.FocusNode _focusNode;
  SearchVariant _currentVariant = SearchVariant.defaultSearch;

  @override
  void initState() {
    super.initState();
    _controller = material.TextEditingController(text: widget.initialValue);
    _focusNode = material.FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _updateVariant(); // Initial state
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _updateVariant();
    });
  }

  void _updateVariant() {
    if (_focusNode.hasFocus) {
      _currentVariant = SearchVariant.active;
    } else {
      _currentVariant =
          _controller.text.isNotEmpty
              ? SearchVariant.filled
              : SearchVariant.defaultSearch;
    }
  }

  @override
  material.Widget build(material.BuildContext context) {
    // Determine colors based on themeMode
    final material.Color backgroundColor =
        widget.themeMode == material.ThemeMode.light
            ? (_currentVariant == SearchVariant.active
                ? AppColors.primary.withOpacity(
                  0.08,
                ) // Light Active: Transparent Blue 8%
                : AppColors.grey100) // Light Default/Filled: Greyscale 100
            : AppColors
                .grey900; // Dark Default/Active/Filled: Dark2 (assumed as grey900)
    final material.Color searchIconColor =
        widget.themeMode == material.ThemeMode.light
            ? (_currentVariant == SearchVariant.active
                ? AppColors
                    .primary // Light Active: Primary Blue 500
                : AppColors.grey400) // Light Default/Filled: Greyscale 400
            : (_currentVariant == SearchVariant.active
                ? AppColors
                    .primary // Dark Active: Primary Blue 500
                : AppColors.grey600); // Dark Default/Filled: Greyscale 600
    final material.Color filterIconColor =
        AppColors.primary; // Always Primary Blue 500
    final material.Color placeholderColor =
        widget.themeMode == material.ThemeMode.light
            ? AppColors
                .grey400 // Light: Greyscale 400
            : AppColors.grey600; // Dark: Greyscale 600
    final material.Color textColor =
        widget.themeMode == material.ThemeMode.light
            ? (_currentVariant == SearchVariant.filled ||
                    _currentVariant == SearchVariant.active
                ? AppColors
                    .grey900 // Light Active/Filled: Greyscale 900
                : AppColors.black) // Light Default: Black
            : AppColors
                .white; // Dark Active/Filled: White (Default placeholder handles it)

    // Border based on variant
    final material.Border border = material.Border.all(
      color:
          _currentVariant == SearchVariant.active
              ? AppColors
                  .primary // Active: Primary Blue 500 border
              : material.Colors.transparent,
      width: 2,
    );

    // Font weight for text
    final material.FontWeight textWeight =
        _currentVariant == SearchVariant.filled ||
                _currentVariant == SearchVariant.active
            ? material
                .FontWeight
                .w600 // Active/Filled: Semibold
            : material.FontWeight.w400; // Default: Regular

    return material.Container(
      height: 58,
      decoration: material.BoxDecoration(
        color: backgroundColor,
        borderRadius: material.BorderRadius.circular(16),
        border: border,
      ),
      padding: const material.EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: material.Center(
        child: material.Row(
          mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
          children: [
            // First Child: Search Icon (20x20)
            material.Icon(
              material.Icons.search,
              color: searchIconColor,
              size: 20,
            ),
            // Spacing: 12px
            const material.SizedBox(width: 12),
            // Second Child: Text Field (Expanded)
            material.Expanded(
              child: material.TextField(
                focusNode: _focusNode,
                decoration: material.InputDecoration(
                  hintText: 'Search',
                  hintStyle: material.Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(
                    color: placeholderColor,
                    fontWeight: material.FontWeight.w400, // Regular
                  ),
                  border: material.InputBorder.none,
                  isCollapsed: true, // Reduces extra padding
                ),
                style: material.Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: textColor,
                  fontWeight: textWeight,
                ),
                controller: _controller,
                onChanged: (value) {
                  widget.onChanged?.call(value);
                  setState(() {
                    _updateVariant();
                  });
                },
                enabled: true,
              ),
            ),
            // Spacing: 12px
            const material.SizedBox(width: 12),
            // Third Child: Filter Icon (20x20, right-oriented)
            material.IconButton(
              icon: material.Icon(
                material.Icons.filter_list,
                color: filterIconColor,
                size: 20,
              ),
              onPressed: widget.onFilterPressed,
              padding: material.EdgeInsets.zero,
              constraints: const material.BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
