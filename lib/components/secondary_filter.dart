import 'package:flutter/material.dart' as material;
import 'package:flutter_svg/flutter_svg.dart' as svg;
import '../constants/colors.dart';

class SecondaryFilter extends material.StatefulWidget {
  final int activeIndex; // From UserTypeSelector
  final material.ValueNotifier<int>
  selectedGender; // Current gender (0: none, 1: male, 2: both, 3: female)
  final material.ValueNotifier<int>
  selectedShift; // Current shift (0: none, 1: day, 2: night, 3: 24h, 4: custom)
  final material.ValueNotifier<int>
  selectedDistance; // Current distance (0: all, 1: 5 km, 2: 10 km, 3: 10+ km)
  final material.ValueNotifier<int>
  selectedConsultation; // Current consultation (0: none, 1: consult, 2: visit)
  final material.ValueNotifier<int>
  selectedFilter; // Current filter (0: none, 1: active)
  final Function(int) onGenderChanged; // Callback for gender filter
  final Function(int) onShiftChanged; // Callback for shift filter
  final Function(int) onDistanceChanged; // Callback for distance filter
  final Function(int) onConsultationChanged; // Callback for consultation filter
  final Function(int) onFilterChanged; // Callback for filter toggle

  const SecondaryFilter({
    super.key,
    required this.activeIndex,
    required this.selectedGender,
    required this.selectedShift,
    required this.selectedDistance,
    required this.selectedConsultation,
    required this.selectedFilter,
    required this.onGenderChanged,
    required this.onShiftChanged,
    required this.onDistanceChanged,
    required this.onConsultationChanged,
    required this.onFilterChanged,
  });

  @override
  SecondaryFilterState createState() => SecondaryFilterState();
}

class SecondaryFilterState extends material.State<SecondaryFilter> {
  @override
  void didUpdateWidget(SecondaryFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Set default selectedConsultation when activeIndex changes
    if (widget.activeIndex != oldWidget.activeIndex) {
      if (widget.activeIndex == 2) {
        // Physio: Default to Visit
        widget.selectedConsultation.value = 2;
      } else if (widget.activeIndex == 3) {
        // Doctor: Default to Consult
        widget.selectedConsultation.value = 1;
      }
      print(
        'activeIndex changed to ${widget.activeIndex}, set selectedConsultation to ${widget.selectedConsultation.value}',
      );
    }
  }

  material.Widget buildContainer({
    required String icon,
    required String activeIcon,
    required double? width,
    String? text,
    double iconSize = 24,
    bool isLeftRounded = false,
    bool isRightRounded = false,
    required int activeIndex,
    bool isGender = false,
    bool isShift = false,
    bool isDistance = false,
    bool isConsultation = false,
    bool isFilter = false,
    bool isLeftAdjacentActive = false,
    bool isRightAdjacentActive = false,
    bool isDisabled = false, // Parameter for disabled state
  }) {
    return material.ValueListenableBuilder<int>(
      valueListenable:
          isGender
              ? widget.selectedGender
              : isShift
              ? widget.selectedShift
              : isDistance
              ? widget.selectedDistance
              : isConsultation
              ? widget.selectedConsultation
              : widget.selectedFilter,
      builder: (context, value, child) {
        final isActive = value == activeIndex && !isDisabled;
        final borderColor =
            isDisabled
                ? AppColors
                    .grey200 // Same as inactive for disabled
                : isActive
                ? AppColors.primary
                : AppColors.grey200;
        final fillColor =
            isDisabled
                ? AppColors
                    .grey200 // Matches border for disabled
                : isActive
                ? AppColors.primary
                : AppColors.white;
        final contentColor =
            isDisabled
                ? AppColors
                    .grey600 // Same as inactive
                : isActive
                ? AppColors.white
                : AppColors.grey600;

        // Debug logging
        print(
          'buildContainer: activeIndex=$activeIndex, isActive=$isActive, '
          'isDisabled=$isDisabled, isLeftAdjacentActive=$isLeftAdjacentActive, '
          'isRightAdjacentActive=$isRightAdjacentActive, border=$borderColor, '
          'fill=$fillColor, content=$contentColor, text/icon=${text ?? icon}',
        );

        // Main container with uniform border color
        final mainContainer = material.Container(
          width: width,
          height: 36,
          padding:
              text != null
                  ? const material.EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  )
                  : const material.EdgeInsets.all(6),
          decoration: material.BoxDecoration(
            color:
                isDisabled
                    ? AppColors.grey200
                    : isActive
                    ? AppColors.primary
                    : null,
            border: material.Border.all(color: borderColor, width: 1),
            borderRadius:
                isFilter
                    ? const material.BorderRadius.all(
                      material.Radius.circular(10),
                    )
                    : isLeftRounded
                    ? const material.BorderRadius.only(
                      topLeft: material.Radius.circular(10),
                      bottomLeft: material.Radius.circular(10),
                    )
                    : isRightRounded
                    ? const material.BorderRadius.only(
                      topRight: material.Radius.circular(10),
                      bottomRight: material.Radius.circular(10),
                    )
                    : null,
          ),
          child:
              text != null
                  ? material.Center(
                    child: material.Text(
                      text,
                      style: material.TextStyle(
                        fontSize: 12,
                        fontWeight: material.FontWeight.w500,
                        color: contentColor,
                      ),
                    ),
                  )
                  : svg.SvgPicture.asset(
                    isActive && !isDisabled ? activeIcon : icon,
                    width: iconSize,
                    height: iconSize,
                    colorFilter: material.ColorFilter.mode(
                      contentColor,
                      material.BlendMode.srcIn,
                    ),
                  ),
        );

        return material.GestureDetector(
          onTap:
              isDisabled
                  ? null
                  : () {
                    print(
                      'Tapped container: activeIndex=$activeIndex, isShift=$isShift, isDistance=$isDistance, isConsultation=$isConsultation',
                    );
                    if (isGender) {
                      widget.onGenderChanged(activeIndex);
                    } else if (isDistance) {
                      widget.onDistanceChanged(activeIndex);
                    } else if (isConsultation) {
                      widget.onConsultationChanged(activeIndex);
                    } else if (isFilter) {
                      widget.onFilterChanged(activeIndex);
                    } else if (isShift) {
                      widget.onShiftChanged(activeIndex);
                    }
                  },
          child: material.Stack(
            children: [
              mainContainer,
              // Overlay left border if left adjacent is active and this box is inactive
              if (!isActive && isLeftAdjacentActive && !isDisabled)
                material.Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: material.Container(
                    width: 1,
                    color: fillColor, // White for inactive, blue for active
                  ),
                ),
              // Overlay right border if right adjacent is active and this box is inactive
              if (!isActive && isRightAdjacentActive && !isDisabled)
                material.Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: material.Container(
                    width: 1,
                    color: fillColor, // White for inactive, blue for active
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  List<material.Widget> _buildFilterSets() {
    final List<material.Widget> filterSets = [];

    // Nurse (index 0) and Attendant (index 1): Show Gender, Shift (with Custom), Distance (disabled if 24h), Filter
    if (widget.activeIndex == 0 || widget.activeIndex == 1) {
      filterSets.addAll([
        // Gender set: All, Male, Female
        material.IntrinsicWidth(
          child: material.ValueListenableBuilder<int>(
            valueListenable: widget.selectedGender,
            builder: (context, value, child) {
              return buildContainer(
                icon: '',
                activeIcon: '',
                text: 'All',
                width: null,
                isLeftRounded: true,
                activeIndex: 2,
                isGender: true,
                isRightAdjacentActive: value == 1, // Male is right
              );
            },
          ),
        ),
        material.ValueListenableBuilder<int>(
          valueListenable: widget.selectedGender,
          builder: (context, value, child) {
            return buildContainer(
              icon: 'assets/icons/nurse_male.svg',
              activeIcon: 'assets/icons/nurse_male.svg',
              width: 36,
              activeIndex: 1,
              isGender: true,
              isLeftAdjacentActive: value == 2, // All is left
              isRightAdjacentActive: value == 3, // Female is right
            );
          },
        ),
        material.ValueListenableBuilder<int>(
          valueListenable: widget.selectedGender,
          builder: (context, value, child) {
            return buildContainer(
              icon: 'assets/icons/nurse_female.svg',
              activeIcon: 'assets/icons/nurse_female.svg',
              width: 36,
              isRightRounded: true,
              activeIndex: 3,
              isGender: true,
              isLeftAdjacentActive: value == 1, // Male is left
            );
          },
        ),
        // Spacing
        const material.SizedBox(width: 12),
        // Shift set: 24 Hours, Day, Night, Custom
        material.ValueListenableBuilder<int>(
          valueListenable: widget.selectedShift,
          builder: (context, value, child) {
            return buildContainer(
              icon: 'assets/icons/24_hours.svg',
              activeIcon: 'assets/icons/24_hours.svg',
              width: 36,
              isLeftRounded: true,
              activeIndex: 3,
              isShift: true,
              isRightAdjacentActive: value == 1, // Day is right
            );
          },
        ),
        material.ValueListenableBuilder<int>(
          valueListenable: widget.selectedShift,
          builder: (context, value, child) {
            return buildContainer(
              icon: 'assets/icons/day.svg',
              activeIcon: 'assets/icons/day_bold.svg',
              width: 36,
              activeIndex: 1,
              isShift: true,
              isLeftAdjacentActive: value == 3, // 24 Hours is left
              isRightAdjacentActive: value == 2, // Night is right
            );
          },
        ),
        material.ValueListenableBuilder<int>(
          valueListenable: widget.selectedShift,
          builder: (context, value, child) {
            return buildContainer(
              icon: 'assets/icons/night.svg',
              activeIcon: 'assets/icons/night_bold.svg',
              width: 36,
              activeIndex: 2,
              isShift: true,
              isLeftAdjacentActive: value == 1, // Day is left
              isRightAdjacentActive: value == 4, // Custom is right
            );
          },
        ),
        // Custom box (clickable, placeholder for other duties)
        material.ValueListenableBuilder<int>(
          valueListenable: widget.selectedShift,
          builder: (context, value, child) {
            return buildContainer(
              icon: 'assets/icons/hamburger_menu.svg',
              activeIcon: 'assets/icons/hamburger_menu.svg',
              width: 36,
              isRightRounded: true,
              activeIndex: 4, // Custom shift
              isShift: true,
              isLeftAdjacentActive: value == 2, // Night is left
            );
          },
        ),
        // Spacing
        const material.SizedBox(width: 12),
      ]);

      // Distance set: All, 5 km, 10 km, 10+ km (disabled if 24h shift)
      filterSets.add(
        material.ValueListenableBuilder<int>(
          valueListenable: widget.selectedShift,
          builder: (context, shiftValue, child) {
            final isDistanceDisabled = shiftValue == 3; // Disable for 24h shift
            print(
              'Distance filter: isDisabled=$isDistanceDisabled, shiftValue=$shiftValue',
            );

            return material.Row(
              mainAxisSize: material.MainAxisSize.min,
              children: [
                material.IntrinsicWidth(
                  child: material.ValueListenableBuilder<int>(
                    valueListenable: widget.selectedDistance,
                    builder: (context, value, child) {
                      return buildContainer(
                        icon: '',
                        activeIcon: '',
                        text: 'All',
                        width: null,
                        activeIndex: 0,
                        isDistance: true,
                        isLeftRounded: true,
                        isRightAdjacentActive: value == 1, // 5 km is right
                        isDisabled: isDistanceDisabled,
                      );
                    },
                  ),
                ),
                material.IntrinsicWidth(
                  child: material.ValueListenableBuilder<int>(
                    valueListenable: widget.selectedDistance,
                    builder: (context, value, child) {
                      return buildContainer(
                        icon: '',
                        activeIcon: '',
                        text: '5 km',
                        width: null,
                        activeIndex: 1,
                        isDistance: true,
                        isLeftAdjacentActive: value == 0, // All is left
                        isRightAdjacentActive: value == 2, // 10 km is right
                        isDisabled: isDistanceDisabled,
                      );
                    },
                  ),
                ),
                material.IntrinsicWidth(
                  child: material.ValueListenableBuilder<int>(
                    valueListenable: widget.selectedDistance,
                    builder: (context, value, child) {
                      return buildContainer(
                        icon: '',
                        activeIcon: '',
                        text: '10 km',
                        width: null,
                        activeIndex: 2,
                        isDistance: true,
                        isLeftAdjacentActive: value == 1, // 5 km is left
                        isRightAdjacentActive: value == 3, // 10+ km is right
                        isDisabled: isDistanceDisabled,
                      );
                    },
                  ),
                ),
                material.IntrinsicWidth(
                  child: material.ValueListenableBuilder<int>(
                    valueListenable: widget.selectedDistance,
                    builder: (context, value, child) {
                      return buildContainer(
                        icon: '',
                        activeIcon: '',
                        text: '10+ km',
                        width: null,
                        isRightRounded: true,
                        activeIndex: 3,
                        isDistance: true,
                        isLeftAdjacentActive: value == 2, // 10 km is left
                        isDisabled: isDistanceDisabled,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      );

      // Spacing and Filter icon
      filterSets.addAll([
        const material.SizedBox(width: 12),
        material.ValueListenableBuilder<int>(
          valueListenable: widget.selectedFilter,
          builder: (context, value, child) {
            return buildContainer(
              icon: 'assets/icons/filter.svg',
              activeIcon: 'assets/icons/filter_bold.svg',
              width: 36,
              activeIndex: 1,
              isFilter: true,
              isRightRounded: true,
            );
          },
        ),
      ]);
    }
    // Physio (index 2) and Doctor (index 3): Visit, Distance, Filter
    else if (widget.activeIndex == 2 || widget.activeIndex == 3) {
      filterSets.addAll([
        // Visit (non-interactive)
        material.IntrinsicWidth(
          child: material.Container(
            height: 36,
            padding: const material.EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: const material.BoxDecoration(
              color: AppColors.primary,
              border: material.Border.fromBorderSide(
                material.BorderSide(color: AppColors.primary, width: 1),
              ),
              borderRadius: material.BorderRadius.all(
                material.Radius.circular(10),
              ),
            ),
            child: const material.Text(
              'Visit',
              style: material.TextStyle(
                fontSize: 12,
                fontWeight: material.FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const material.SizedBox(width: 12),
        // Distance: All, 5 km, 10 km, 10+ km
        material.IntrinsicWidth(
          child: material.ValueListenableBuilder<int>(
            valueListenable: widget.selectedDistance,
            builder: (context, value, child) {
              return buildContainer(
                icon: '',
                activeIcon: '',
                text: 'All',
                width: null,
                isLeftRounded: true,
                activeIndex: 0,
                isDistance: true,
                isRightAdjacentActive: value == 1,
              );
            },
          ),
        ),
        material.IntrinsicWidth(
          child: material.ValueListenableBuilder<int>(
            valueListenable: widget.selectedDistance,
            builder: (context, value, child) {
              return buildContainer(
                icon: '',
                activeIcon: '',
                text: '5 km',
                width: null,
                activeIndex: 1,
                isDistance: true,
                isLeftAdjacentActive: value == 0,
                isRightAdjacentActive: value == 2,
              );
            },
          ),
        ),
        material.IntrinsicWidth(
          child: material.ValueListenableBuilder<int>(
            valueListenable: widget.selectedDistance,
            builder: (context, value, child) {
              return buildContainer(
                icon: '',
                activeIcon: '',
                text: '10 km',
                width: null,
                activeIndex: 2,
                isDistance: true,
                isLeftAdjacentActive: value == 1,
                isRightAdjacentActive: value == 3,
              );
            },
          ),
        ),
        material.IntrinsicWidth(
          child: material.ValueListenableBuilder<int>(
            valueListenable: widget.selectedDistance,
            builder: (context, value, child) {
              return buildContainer(
                icon: '',
                activeIcon: '',
                text: '10+ km',
                width: null,
                isRightRounded: true,
                activeIndex: 3,
                isDistance: true,
                isLeftAdjacentActive: value == 2,
              );
            },
          ),
        ),
        const material.SizedBox(width: 12),
        // Filter icon
        material.ValueListenableBuilder<int>(
          valueListenable: widget.selectedFilter,
          builder: (context, value, child) {
            return buildContainer(
              icon: 'assets/icons/filter.png',
              activeIcon: 'assets/icons/filter_bold.png',
              width: 36,
              activeIndex: 1,
              isFilter: true,
              isRightRounded: true,
            );
          },
        ),
      ]);
    }
    // Equipment (index 4) and Search (index 5): No filters
    return filterSets;
  }

  @override
  material.Widget build(material.BuildContext context) {
    return material.SizedBox(
      width: double.infinity,
      height: 36,
      child: material.Row(
        mainAxisAlignment: material.MainAxisAlignment.start,
        mainAxisSize: material.MainAxisSize.max,
        children: [
          // Filter options
          material.Expanded(
            child: material.SingleChildScrollView(
              scrollDirection: material.Axis.horizontal,
              child: material.Row(
                mainAxisSize: material.MainAxisSize.min,
                children: _buildFilterSets(),
              ),
            ),
          ),
          // Gradient container
          material.Container(
            width: 20,
            height: 36,
            decoration: const material.BoxDecoration(
              gradient: material.LinearGradient(
                begin: material.Alignment.centerLeft,
                end: material.Alignment.centerRight,
                colors: [
                  material.Color.fromRGBO(255, 255, 255, 0.0), // Transparent
                  material.Color.fromRGBO(255, 255, 255, 1.0), // White
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
