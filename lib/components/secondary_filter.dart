import 'package:flutter/material.dart' as material;
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import '../constants/colors.dart';

class SecondaryFilter extends material.StatefulWidget {
  final int activeIndex; // From UserTypeSelector
  final material.ValueNotifier<int>
  selectedGender; // Current gender (0: none, 1: male, 2: both, 3: female)
  final material.ValueNotifier<int>
  selectedShift; // Current shift (0: none, 1: day, 2: night, 3: 24h)
  final material.ValueNotifier<int>
  selectedDistance; // Current distance (0: all, 1: 5 km, 2: 10 km, 3: 10+ km)
  final material.ValueNotifier<int>
  selectedConsultation; // Current consultation (0: none, 1: teleconsultation, 2: 10 km, 3: 10+ km)
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
  material.Widget buildContainer({
    required String icon,
    required String activeIcon,
    required double? width,
    String? text,
    double iconSize = 24,
    bool isLeftRounded = false,
    bool isRightRounded = false,
    required int activeIndex,
    bool isBoth = false,
    bool isGender = false,
    bool isShift = false,
    bool isDistance = false,
    bool isConsultation = false,
    bool isFilter = false,
    bool noRightBorder = false,
    bool noLeftBorder = false,
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
        print(
          'Building container: activeIndex=$activeIndex, value=$value, isShift=$isShift, isDistance=$isDistance',
        );
        final isActive = value == activeIndex;
        final borderColor = AppColors.grey200;
        final fillColor = isActive ? AppColors.primary : null;
        final iconColor = isActive ? AppColors.white : AppColors.grey600;
        return material.GestureDetector(
          onTap: () {
            print(
              'Tapped container: activeIndex=$activeIndex, isShift=$isShift, isDistance=$isDistance',
            );
            if (isGender) {
              widget.onGenderChanged(activeIndex);
            } else if (isDistance) {
              widget.onDistanceChanged(activeIndex);
            } else if (isConsultation) {
              widget.onConsultationChanged(activeIndex);
            } else if (isFilter) {
              widget.onFilterChanged(activeIndex);
            } else {
              widget.onShiftChanged(activeIndex);
            }
          },
          child: material.Container(
            width: width,
            height: 36,
            padding:
                text != null
                    ? const material.EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 6,
                    )
                    : const material.EdgeInsets.all(6),
            decoration: material.BoxDecoration(
              color: fillColor,
              border: material.Border(
                top: material.BorderSide(color: borderColor, width: 1),
                bottom: material.BorderSide(color: borderColor, width: 1),
                left:
                    noLeftBorder
                        ? material.BorderSide.none
                        : material.BorderSide(color: borderColor, width: 1),
                right:
                    noRightBorder
                        ? material.BorderSide.none
                        : material.BorderSide(color: borderColor, width: 1),
              ),
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
                isBoth
                    ? material.Row(
                      mainAxisAlignment: material.MainAxisAlignment.center,
                      mainAxisSize: material.MainAxisSize.min,
                      children: [
                        svg.SvgPicture.asset(
                          'assets/icons/nurse_male.svg',
                          width: iconSize,
                          height: iconSize,
                          colorFilter: material.ColorFilter.mode(
                            iconColor,
                            material.BlendMode.srcIn,
                          ),
                        ),
                        const material.SizedBox(width: 6),
                        svg.SvgPicture.asset(
                          'assets/icons/nurse_female.svg',
                          width: iconSize,
                          height: iconSize,
                          colorFilter: material.ColorFilter.mode(
                            iconColor,
                            material.BlendMode.srcIn,
                          ),
                        ),
                      ],
                    )
                    : text != null
                    ? material.Center(
                      child: material.Text(
                        text,
                        style: material.TextStyle(
                          fontSize: 12,
                          fontWeight: material.FontWeight.w500,
                          color: isActive ? AppColors.white : AppColors.grey600,
                        ),
                      ),
                    )
                    : svg.SvgPicture.asset(
                      isActive ? activeIcon : icon,
                      width: iconSize,
                      height: iconSize,
                      colorFilter: material.ColorFilter.mode(
                        iconColor,
                        material.BlendMode.srcIn,
                      ),
                    ),
          ),
        );
      },
    );
  }

  List<material.Widget> _buildFilterSets() {
    final List<material.Widget> filterSets = [];

    // Nurse (index 0) and Attendant (index 1): Show Gender, Shift, Distance, Filter
    if (widget.activeIndex == 0 || widget.activeIndex == 1) {
      filterSets.addAll([
        // Gender set: Both, Male, Female
        buildContainer(
          icon: 'assets/icons/nurse_male.svg',
          activeIcon: 'assets/icons/nurse_male.svg',
          width: 66,
          iconSize: 21,
          isLeftRounded: true,
          activeIndex: 2,
          isBoth: true,
          isGender: true,
          noRightBorder: true,
        ),
        buildContainer(
          icon: 'assets/icons/nurse_male.svg',
          activeIcon: 'assets/icons/nurse_male.svg',
          width: 36,
          activeIndex: 1,
          isGender: true,
        ),
        buildContainer(
          icon: 'assets/icons/nurse_female.svg',
          activeIcon: 'assets/icons/nurse_female.svg',
          width: 36,
          isRightRounded: true,
          activeIndex: 3,
          isGender: true,
          noLeftBorder: true,
        ),
        // Spacing
        const material.SizedBox(width: 12),
        // Shift set: 24 Hours, Day, Night
        buildContainer(
          icon: 'assets/icons/24_hours.svg',
          activeIcon: 'assets/icons/24_hours.svg',
          width: 36,
          isLeftRounded: true,
          activeIndex: 3,
          isShift: true,
          noRightBorder: true,
        ),
        buildContainer(
          icon: 'assets/icons/day.svg',
          activeIcon: 'assets/icons/day_bold.svg',
          width: 36,
          activeIndex: 1,
          isShift: true,
        ),
        buildContainer(
          icon: 'assets/icons/night.svg',
          activeIcon: 'assets/icons/night_bold.svg',
          width: 36,
          isRightRounded: true,
          activeIndex: 2,
          isShift: true,
          noLeftBorder: true,
        ),
        // Spacing
        const material.SizedBox(width: 12),
        // Distance set: All, 5 km, 10 km, 10+ km
        material.IntrinsicWidth(
          child: buildContainer(
            icon: '',
            activeIcon: '',
            text: 'All',
            width: null,
            activeIndex: 0,
            isDistance: true,
            isLeftRounded: true,
            noRightBorder: true,
          ),
        ),
        material.IntrinsicWidth(
          child: buildContainer(
            icon: '',
            activeIcon: '',
            text: '5 km',
            width: null,
            activeIndex: 1,
            isDistance: true,
            noRightBorder: true,
            noLeftBorder: true,
          ),
        ),
        material.IntrinsicWidth(
          child: buildContainer(
            icon: '',
            activeIcon: '',
            text: '10 km',
            width: null,
            activeIndex: 2,
            isDistance: true,
          ),
        ),
        material.IntrinsicWidth(
          child: buildContainer(
            icon: '',
            activeIcon: '',
            text: '10+ km',
            width: null,
            isRightRounded: true,
            activeIndex: 3,
            isDistance: true,
            noLeftBorder: true,
          ),
        ),
        // Spacing
        const material.SizedBox(width: 12),
        // Filter icon
        buildContainer(
          icon: 'assets/icons/filter.svg',
          activeIcon: 'assets/icons/filter_bold.svg',
          width: 36,
          activeIndex: 1,
          isFilter: true,
          isRightRounded: true,
        ),
      ]);
    }
    // Physio (index 2): Show All, 5 km, 10 km, 10+ km, Filter
    else if (widget.activeIndex == 2) {
      filterSets.addAll([
        // All filter
        buildContainer(
          icon: 'assets/icons/physio.svg',
          activeIcon: 'assets/icons/physio.svg',
          width: 36,
          isLeftRounded: true,
          activeIndex: 0,
          isDistance: true,
          noRightBorder: true,
        ),
        // Distance set: 5 km, 10 km, 10+ km
        material.IntrinsicWidth(
          child: buildContainer(
            icon: '',
            activeIcon: '',
            text: '5 km',
            width: null,
            activeIndex: 1,
            isDistance: true,
            noRightBorder: true,
            noLeftBorder: true,
          ),
        ),
        material.IntrinsicWidth(
          child: buildContainer(
            icon: '',
            activeIcon: '',
            text: '10 km',
            width: null,
            activeIndex: 2,
            isDistance: true,
          ),
        ),
        material.IntrinsicWidth(
          child: buildContainer(
            icon: '',
            activeIcon: '',
            text: '10+ km',
            width: null,
            isRightRounded: true,
            activeIndex: 3,
            isDistance: true,
            noLeftBorder: true,
          ),
        ),
        // Spacing
        const material.SizedBox(width: 12),
        // Filter icon
        buildContainer(
          icon: 'assets/icons/filter.svg',
          activeIcon: 'assets/icons/filter_bold.svg',
          width: 36,
          activeIndex: 1,
          isFilter: true,
          isRightRounded: true,
        ),
      ]);
    }
    // Doctor (index 3): Show Consultation, Filter
    else if (widget.activeIndex == 3) {
      filterSets.addAll([
        // Consultation set: Teleconsultation, 10 km, 10+ km
        buildContainer(
          icon: 'assets/icons/doctor.svg',
          activeIcon: 'assets/icons/doctor.svg',
          width: 36,
          isLeftRounded: true,
          activeIndex: 1,
          isConsultation: true,
          noRightBorder: true,
        ),
        material.IntrinsicWidth(
          child: buildContainer(
            icon: '',
            activeIcon: '',
            text: '10 km',
            width: null,
            activeIndex: 2,
            isConsultation: true,
          ),
        ),
        material.IntrinsicWidth(
          child: buildContainer(
            icon: '',
            activeIcon: '',
            text: '10+ km',
            width: null,
            isRightRounded: true,
            activeIndex: 3,
            isConsultation: true,
            noLeftBorder: true,
          ),
        ),
        // Spacing
        const material.SizedBox(width: 12),
        // Filter icon
        buildContainer(
          icon: 'assets/icons/filter.svg',
          activeIcon: 'assets/icons/filter_bold.svg',
          width: 36,
          activeIndex: 1,
          isFilter: true,
          isRightRounded: true,
        ),
      ]);
    }
    // Equipment (index 4) and Search (index 5): No filters
    return filterSets;
  }

  @override
  material.Widget build(material.BuildContext context) {
    return material.Container(
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
