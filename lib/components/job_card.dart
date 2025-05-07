import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_svg/flutter_svg.dart' as svg;
import '../constants/colors.dart';
import '../components/index.dart';

class JobCard extends material.StatefulWidget {
  final Map<String, dynamic> profile;
  final material.ValueNotifier<int>
  selectedShift; // 0: none, 1: day, 2: night, 3: 24h
  final material.ValueNotifier<int>
  selectedDistance; // 0: all, 1: 5 km, 2: 10 km, 3: 10+ km
  final material.ValueNotifier<int>
  selectedConsultation; // 0: none, 1: teleconsultation, 2: 10 km, 3: 10+ km

  const JobCard({
    super.key,
    required this.profile,
    required this.selectedShift,
    required this.selectedDistance,
    required this.selectedConsultation,
  });

  @override
  JobCardState createState() => JobCardState();
}

class JobCardState extends material.State<JobCard> {
  int _currentImageIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  material.Widget build(material.BuildContext context) {
    // Determine display location: use city if not Delhi, else use location (area)
    final String displayLocation =
        (widget.profile['city'] != null && widget.profile['city'] != 'Delhi')
            ? widget.profile['city']
            : widget.profile['location'] ?? 'Unknown';

    // Determine if top tag should be shown: only for top 10 Nurse, Attendant, Physio
    final bool showTopTag =
        widget.profile['ranking'] != null &&
        widget.profile['ranking'] <= 10 &&
        widget.profile['role'].toString().toLowerCase() != 'doctor';

    // Determine icon color based on gender
    final iconColor =
        widget.profile['gender'] == 'Male' ? AppColors.primary : AppColors.pink;

    return material.Container(
      width: 360,
      padding: const material.EdgeInsets.only(
        top: 10,
        left: 16,
        right: 16,
        bottom: 6,
      ),
      decoration: material.BoxDecoration(
        color: AppColors.white,
        border: material.Border.all(color: AppColors.grey200, width: 1),
        borderRadius: material.BorderRadius.circular(28),
      ),
      child: material.Column(
        mainAxisSize: material.MainAxisSize.min,
        children: [
          // First Child: Tag row (only shown for top 10 Nurse, Attendant, Physio)
          if (showTopTag)
            material.Container(
              width: double.infinity,
              child: material.Row(
                mainAxisSize: material.MainAxisSize.max,
                mainAxisAlignment: material.MainAxisAlignment.start,
                children: [
                  material.Container(
                    padding: const material.EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 6,
                    ),
                    decoration: material.BoxDecoration(
                      color: AppColors.green,
                      borderRadius: material.BorderRadius.circular(4),
                    ),
                    child: material.Text(
                      'Top 10 ${widget.profile['role']} in Delhi',
                      style: const material.TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 10,
                        fontWeight: material.FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          // Spacing: 12px (only if tag row is shown)
          if (showTopTag) const material.SizedBox(height: 12),
          // Second Child: Horizontal layout with photo slider and scrollable staff details
          material.Container(
            width: double.infinity,
            child: material.Row(
              mainAxisAlignment: material.MainAxisAlignment.start,
              crossAxisAlignment: material.CrossAxisAlignment.start,
              children: [
                // Photo slider with dots
                material.SizedBox(
                  width: 100,
                  child: material.Stack(
                    alignment: material.Alignment.center,
                    children: [
                      CarouselSlider(
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          height: 125,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: true,
                          autoPlay: false,
                          enlargeCenterPage: false,
                          scrollDirection: material.Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                        ),
                        items:
                            (widget.profile['images'] as List<dynamic>).map((
                              image,
                            ) {
                              return material.ClipRRect(
                                borderRadius: material.BorderRadius.circular(
                                  13,
                                ),
                                child: material.Image.asset(
                                  image,
                                  width: 100,
                                  height: 125,
                                  fit: material.BoxFit.cover,
                                ),
                              );
                            }).toList(),
                      ),
                      material.Positioned(
                        bottom: 15,
                        child: material.Row(
                          mainAxisAlignment: material.MainAxisAlignment.center,
                          children: List.generate(3, (index) {
                            return material.Container(
                              width: 6,
                              height: 6,
                              margin: const material.EdgeInsets.symmetric(
                                horizontal: 3,
                              ),
                              decoration: material.BoxDecoration(
                                shape: material.BoxShape.circle,
                                color:
                                    _currentImageIndex == index
                                        ? AppColors.white
                                        : AppColors.grey400,
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                // Spacing: 16px
                const material.SizedBox(width: 16),
                // Scrollable staff details
                material.Expanded(
                  child: material.Column(
                    mainAxisSize: material.MainAxisSize.min,
                    crossAxisAlignment: material.CrossAxisAlignment.start,
                    children: [
                      // Row 1: Name, SizedBox, and Profile Icon (independently scrollable)
                      material.SingleChildScrollView(
                        scrollDirection: material.Axis.horizontal,
                        child: material.Row(
                          children: [
                            material.Text(
                              widget.profile['name'],
                              style: const material.TextStyle(
                                fontSize: 20,
                                fontWeight: material.FontWeight.bold,
                                color: AppColors.grey900,
                              ),
                            ),
                            const material.SizedBox(width: 16),
                            svg.SvgPicture.asset(
                              'assets/icons/profile_bold.svg',
                              width: 24,
                              height: 24,
                              colorFilter: material.ColorFilter.mode(
                                iconColor,
                                material.BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Spacing: 8px
                      const material.SizedBox(height: 8),
                      // Row 2: Role (independently scrollable)
                      material.SingleChildScrollView(
                        scrollDirection: material.Axis.horizontal,
                        child: material.Text(
                          widget.profile['role'],
                          style: const material.TextStyle(
                            fontSize: 16,
                            fontWeight: material.FontWeight.w500,
                            color: AppColors.grey600,
                            height: 1.4,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      // Spacing: 8px
                      const material.SizedBox(height: 8),
                      // Row 3: Qualifications and Experience (independently scrollable)
                      material.SingleChildScrollView(
                        scrollDirection: material.Axis.horizontal,
                        child: material.Text(
                          '${widget.profile['qualifications']} | ${widget.profile['experience']} yrs Exp',
                          style: const material.TextStyle(
                            fontSize: 16,
                            fontWeight: material.FontWeight.w500,
                            color: AppColors.grey600,
                            height: 1.4,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      // Spacing: 8px
                      const material.SizedBox(height: 8),
                      // Row 4: Location and Distance (independently scrollable)
                      material.SingleChildScrollView(
                        scrollDirection: material.Axis.horizontal,
                        child: material.Row(
                          children: [
                            material.Text(
                              '$displayLocation, ${widget.profile['distance_from_client']} km away',
                              style: const material.TextStyle(
                                fontSize: 16,
                                fontWeight: material.FontWeight.w500,
                                color: AppColors.grey600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Spacing: 12px
          const material.SizedBox(height: 12),
          // Third Child: Column with 3 rows
          material.Container(
            width: double.infinity,
            child: material.Column(
              mainAxisSize: material.MainAxisSize.min,
              children: [
                // Row 1: Horizontal layout with two containers
                material.Row(
                  mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
                  children: [
                    // First container: INR icon, rate, and shift label or rate breakdown
                    material.Column(
                      crossAxisAlignment: material.CrossAxisAlignment.start,
                      children: [
                        material.Row(
                          children: [
                            const material.Icon(
                              material.Icons.currency_rupee,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const material.SizedBox(width: 4),
                            RateDisplay(
                              profile: widget.profile,
                              selectedShift: widget.selectedShift,
                              selectedDistance: widget.selectedDistance,
                              selectedConsultation: widget.selectedConsultation,
                            ),
                          ],
                        ),
                        const material.SizedBox(height: 4),
                        RateDisplay(
                          profile: widget.profile,
                          selectedShift: widget.selectedShift,
                          selectedDistance: widget.selectedDistance,
                          selectedConsultation: widget.selectedConsultation,
                          isShiftLabel: true,
                        ),
                      ],
                    ),
                    // Second container: Column with Tag and applicants
                    material.Container(
                      child: material.Column(
                        mainAxisSize: material.MainAxisSize.min,
                        crossAxisAlignment: material.CrossAxisAlignment.center,
                        children: [
                          const Tag(
                            text: 'View Bids',
                            variant: TagVariant.info,
                          ),
                          material.Text(
                            '${widget.profile['clients']} applicants',
                            style: const material.TextStyle(
                              fontSize: 12,
                              fontWeight: material.FontWeight.w500,
                              color: AppColors.grey700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const material.SizedBox(height: 10),
                // Row 2: Divider
                material.Divider(
                  color: AppColors.grey200,
                  height: 1,
                  thickness: 1,
                ),
                const material.SizedBox(height: 10),
                // Row 3: Text and down arrow icon
                material.Row(
                  mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
                  children: [
                    const material.Text(
                      'Notable clients',
                      style: material.TextStyle(
                        fontSize: 16,
                        fontWeight: material.FontWeight.w600,
                        color: AppColors.grey600,
                      ),
                    ),
                    const material.Icon(
                      material.Icons.keyboard_arrow_down,
                      size: 24,
                      color: AppColors.grey600,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RateDisplay extends material.StatefulWidget {
  final Map<String, dynamic> profile;
  final material.ValueNotifier<int> selectedShift;
  final material.ValueNotifier<int> selectedDistance;
  final material.ValueNotifier<int> selectedConsultation;
  final bool isShiftLabel; // Flag to render shift label or rate breakdown

  const RateDisplay({
    super.key,
    required this.profile,
    required this.selectedShift,
    required this.selectedDistance,
    required this.selectedConsultation,
    this.isShiftLabel = false,
  });

  @override
  RateDisplayState createState() => RateDisplayState();
}

class RateDisplayState extends material.State<RateDisplay> {
  @override
  void initState() {
    super.initState();
    // Log profile data for debugging
    print(
      'Profile: ${widget.profile['id']}, Role: ${widget.profile['role']}, Rates: ${widget.profile['rates']}, Shift: ${widget.selectedShift.value}, Distance: ${widget.selectedDistance.value}',
    );
  }

  String _getDisplayRate(int shift, int distance, int consultation) {
    if (widget.profile['rates'] == null) {
      print('No rates for profile: ${widget.profile['id']}');
      return widget.isShiftLabel ? '' : 'N/A';
    }

    // Nurse/Attendant: Shift rates
    final roleLower = widget.profile['role'].toString().toLowerCase();
    if (roleLower == 'nurse' ||
        roleLower == 'staff nurse' ||
        roleLower == 'attendant') {
      // Handle shift label
      if (widget.isShiftLabel) {
        if (shift == 1) {
          return 'For 12 hrs Day shift';
        } else if (shift == 2) {
          return 'For 12 hrs Night shift';
        } else if (shift == 3) {
          return 'For 24 hrs shift';
        }
        print('Defaulting to 24 hrs shift for ${widget.profile['role']}');
        return 'For 24 hrs shift'; // Default to 24 hrs
      }
      // Handle rates for shifts
      if (shift == 1) {
        print('Using day_shift for ${widget.profile['id']}');
        return widget.profile['rates']['day_shift'] is num
            ? widget.profile['rates']['day_shift'].toString()
            : 'Not available';
      } else if (shift == 2) {
        print('Using night_shift for ${widget.profile['id']}');
        return widget.profile['rates']['night_shift'] is num
            ? widget.profile['rates']['night_shift'].toString()
            : 'Not available';
      } else if (shift == 3) {
        print('Using 24_hour_shift for ${widget.profile['id']}');
        return widget.profile['rates']['24_hour_shift'] is num
            ? widget.profile['rates']['24_hour_shift'].toString()
            : 'Not available';
      }
      // Default to 24 hrs rate
      print('Defaulting to 24 hrs rate for ${widget.profile['role']}');
      return widget.profile['rates']['24_hour_shift'] is num
          ? widget.profile['rates']['24_hour_shift'].toString()
          : 'Not available';
    }
    // Physio: Distance rates and breakdown
    else if (roleLower == 'physiotherapist') {
      String rateKey;
      double totalRate = 0;
      if (distance == 0) {
        // For All filter, use up_to_5_km as fallback
        rateKey = 'up_to_5_km';
      } else if (distance == 1) {
        rateKey = 'up_to_5_km';
      } else if (distance == 2) {
        rateKey = '5_to_10_km';
      } else if (distance == 3) {
        rateKey = 'beyond_10_km';
      } else {
        return widget.isShiftLabel ? '' : 'N/A';
      }
      if (widget.profile['rates'][rateKey] is num) {
        totalRate = widget.profile['rates'][rateKey].toDouble();
        print(
          'Using physio distance rate for ${widget.profile['id']}: $rateKey = $totalRate',
        );
        if (widget.isShiftLabel) {
          // Visit fee is up_to_5_km rate
          final visitFee =
              widget.profile['rates']['up_to_5_km'] is num
                  ? widget.profile['rates']['up_to_5_km'].toDouble().round()
                  : 0;
          final travelCharge = totalRate - visitFee;
          if (visitFee > 0 && travelCharge >= 0) {
            return 'Rs $visitFee (fees) + Rs $travelCharge (travel)';
          }
          return '';
        }
        return totalRate.toString();
      }
      return widget.isShiftLabel ? '' : 'N/A';
    }
    // Doctor: Consultation rates
    else if (roleLower == 'doctor') {
      if (widget.isShiftLabel) return '';
      if (consultation == 1) {
        print('Using teleconsultation for ${widget.profile['id']}');
        return widget.profile['rates']['teleconsultation'] is num
            ? widget.profile['rates']['teleconsultation'].toString()
            : 'N/A';
      } else if (consultation == 2) {
        print('Using 5_to_10_km for ${widget.profile['id']}');
        return widget.profile['rates']['5_to_10_km'] is num
            ? widget.profile['rates']['5_to_10_km'].toString()
            : 'N/A';
      } else if (consultation == 3) {
        print('Using beyond_10_km for ${widget.profile['id']}');
        return widget.profile['rates']['beyond_10_km'] is num
            ? widget.profile['rates']['beyond_10_km'].toString()
            : 'N/A';
      }
      // Default to teleconsultation rate
      print('Defaulting to teleconsultation rate for Doctor');
      return widget.profile['rates']['teleconsultation'] is num
          ? widget.profile['rates']['teleconsultation'].toString()
          : 'N/A';
    }
    // Default
    print('Unknown role: ${widget.profile['role']}');
    if (widget.isShiftLabel) return '';
    return widget.profile['rates']['24_hour_shift']?.toString() ??
        widget.profile['rates']['teleconsultation']?.toString() ??
        widget.profile['rates']['up_to_5_km']?.toString() ??
        'N/A';
  }

  @override
  material.Widget build(material.BuildContext context) {
    // Use ValueListenableBuilder for shift, distance, and consultation changes
    final roleLower = widget.profile['role'].toString().toLowerCase();
    return material.ValueListenableBuilder<int>(
      valueListenable: widget.selectedShift,
      builder: (context, shift, child) {
        return material.ValueListenableBuilder<int>(
          valueListenable: widget.selectedDistance,
          builder: (context, distance, child) {
            return material.ValueListenableBuilder<int>(
              valueListenable: widget.selectedConsultation,
              builder: (context, consultation, child) {
                final text = _getDisplayRate(shift, distance, consultation);
                print(
                  'RateDisplay for ${widget.profile['id']}: Shift=$shift, Distance=$distance, Rate=$text',
                );
                return material.Text(
                  text,
                  style: material.TextStyle(
                    fontSize: widget.isShiftLabel ? 12 : 16,
                    fontWeight:
                        widget.isShiftLabel
                            ? material.FontWeight.w500
                            : material.FontWeight.bold,
                    color:
                        widget.isShiftLabel
                            ? AppColors.grey700
                            : text == 'Not available'
                            ? AppColors.grey600
                            : AppColors.primary,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
