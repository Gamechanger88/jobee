import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import '../constants/colors.dart';

class UserTypeSelector extends StatefulWidget {
  final Function(int) onTabChanged; // Callback to notify parent of tab change

  const UserTypeSelector({super.key, required this.onTabChanged});

  @override
  State<UserTypeSelector> createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<UserTypeSelector> {
  int activeIndex = 0; // Default active tab is Nurse (index 0)
  bool isSearchActive = false; // Track Search active state
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List of icons and labels for the 6 boxes
    final List<Map<String, dynamic>> boxItems = [
      {'icon': 'assets/icons/nurse_male.svg', 'label': 'Nurse'},
      {'icon': 'assets/icons/attendant.svg', 'label': 'Attendant'},
      {'icon': 'assets/icons/physio.svg', 'label': 'Physio'},
      {'icon': 'assets/icons/doctor.svg', 'label': 'Doctor'},
      {'icon': 'assets/icons/devices2.svg', 'label': 'Equipment'},
      {'icon': 'assets/icons/search.svg', 'label': 'Search'},
    ];

    // Get screen width dynamically
    final double screenWidth =
        MediaQuery.of(context).size.width -
        48; // Subtract 24px left + 24px right padding
    // Calculate shift offset: screen width + 24px spacer
    final double shiftOffset = isSearchActive ? -(screenWidth + 24.0) : 0.0;

    // Manage keyboard focus
    if (isSearchActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _searchFocusNode.requestFocus();
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _searchFocusNode.unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      });
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(shiftOffset, 0.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // First half: 6 icons
            SizedBox(
              width: screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: List.generate(
                  boxItems.length,
                  (index) => Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (index == 5) {
                            isSearchActive = !isSearchActive;
                          } else {
                            activeIndex = index;
                            isSearchActive = false;
                            widget.onTabChanged(index); // Notify parent
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon Holder (40x40)
                            Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:
                                    index == activeIndex && index != 5
                                        ? AppColors.primary
                                        : AppColors.white,
                                border: Border.all(
                                  color:
                                      index == activeIndex && index != 5
                                          ? AppColors.primary
                                          : AppColors.grey100,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: svg.SvgPicture.asset(
                                boxItems[index]['icon'],
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                  index == activeIndex && index != 5
                                      ? AppColors.white
                                      : AppColors.grey600,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            // Spacing
                            const SizedBox(height: 6),
                            // Label
                            Text(
                              boxItems[index]['label'],
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    index == activeIndex && index != 5
                                        ? AppColors.primary
                                        : AppColors.grey600,
                                fontWeight:
                                    index == activeIndex && index != 5
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Spacer between halves
            const SizedBox(width: 24),
            // Second half: Search active field
            Container(
              width: screenWidth,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey100),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Back Arrow
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.grey600,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        isSearchActive = false;
                        activeIndex = 0;
                        _searchController.clear();
                        widget.onTabChanged(0); // Reset to Nurse
                      });
                    },
                    padding: const EdgeInsets.all(0),
                    constraints: const BoxConstraints(),
                  ),
                  // Spacer
                  const SizedBox(width: 12),
                  // Search Entry Field
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: TextField(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        decoration: const InputDecoration(
                          hintText: 'Search by name, city...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 12,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.grey600,
                        ),
                      ),
                    ),
                  ),
                  // Spacer
                  const SizedBox(width: 12),
                  // Close Icon
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.grey600,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchFocusNode.requestFocus();
                      });
                    },
                    padding: const EdgeInsets.all(0),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
