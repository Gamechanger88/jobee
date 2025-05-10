import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_svg/flutter_svg.dart' as svg;
import '../constants/colors.dart';
import '../components/index.dart';

class StaffCard extends material.StatefulWidget {
  final Map<String, dynamic> profile;
  final material.ValueNotifier<int>
  selectedShift; // 0: none, 1: day, 2: night, 3: 24h
  final material.ValueNotifier<int>
  selectedDistance; // 0: all, 1: 5 km, 2: 10 km, 3: 10+ km
  final material.ValueNotifier<int>
  selectedConsultation; // 0: none, 1: consult, 2: visit

  const StaffCard({
    super.key,
    required this.profile,
    required this.selectedShift,
    required this.selectedDistance,
    required this.selectedConsultation,
  });

  @override
  StaffCardState createState() => StaffCardState();
}

class StaffCardState extends material.State<StaffCard> {
  int _currentImageIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  material.Widget build(material.BuildContext context) {
    final String displayLocation =
        (widget.profile['city'] != null && widget.profile['city'] != 'Delhi')
            ? widget.profile['city']
            : widget.profile['location'] ?? 'Unknown';
    final bool showTopTag =
        widget.profile['ranking'] != null &&
        widget.profile['ranking'] <= 10 &&
        widget.profile['role'].toString().toLowerCase() != 'doctor';
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
          if (showTopTag)
            material.SizedBox(
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
          if (showTopTag) const material.SizedBox(height: 12),
          material.SizedBox(
            width: double.infinity,
            child: material.Row(
              mainAxisAlignment: material.MainAxisAlignment.start,
              crossAxisAlignment: material.CrossAxisAlignment.start,
              children: [
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
                const material.SizedBox(width: 16),
                material.Expanded(
                  child: material.Column(
                    mainAxisSize: material.MainAxisSize.min,
                    crossAxisAlignment: material.CrossAxisAlignment.start,
                    children: [
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
                      const material.SizedBox(height: 8),
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
                      const material.SizedBox(height: 8),
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
                      const material.SizedBox(height: 8),
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
          const material.SizedBox(height: 12),
          material.SizedBox(
            width: double.infinity,
            child: material.Column(
              mainAxisSize: material.MainAxisSize.min,
              children: [
                material.Row(
                  mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
                  children: [
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
                            '${widget.profile['clients']} Interested',
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
                material.Divider(
                  color: AppColors.grey200,
                  height: 1,
                  thickness: 1,
                ),
                const material.SizedBox(height: 10),
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
  final bool isShiftLabel;

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
    print(
      'RateDisplay init: Profile ID: ${widget.profile['id']}, Role: ${widget.profile['role']}, Rates: ${widget.profile['rates']}, Distance: ${widget.selectedDistance.value}, isShiftLabel: ${widget.isShiftLabel}',
    );
  }

  String _getDisplayRate(int shift, int distance, int consultation) {
    if (widget.profile['rates'] == null) {
      print('No rates for profile: ${widget.profile['id']}');
      return widget.isShiftLabel ? '' : 'N/A';
    }

    final roleLower = widget.profile['role'].toString().toLowerCase();
    if (roleLower == 'nurse' ||
        roleLower == 'staff nurse' ||
        roleLower == 'attendant') {
      if (widget.isShiftLabel) {
        if (shift == 1) return 'For 12 hrs Day shift';
        if (shift == 2) return 'For 12 hrs Night shift';
        if (shift == 3) return 'For 24 hrs shift';
        if (shift == 4) {
          return 'For Custom shift'; // Placeholder for custom shift
        }
        return 'For 24 hrs shift';
      }
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
      } else if (shift == 4) {
        print('Using custom_shift for ${widget.profile['id']}');
        return widget.profile['rates']['custom_shift'] is num
            ? widget.profile['rates']['custom_shift'].toString()
            : 'Not available';
      }
      print('Defaulting to 24 hrs rate for ${widget.profile['role']}');
      return widget.profile['rates']['24_hour_shift'] is num
          ? widget.profile['rates']['24_hour_shift'].toString()
          : 'Not available';
    } else if (roleLower == 'physiotherapist') {
      String rateKey;
      double totalRate = 0;
      if (distance == 0) {
        if (widget.profile['distance_from_client'] != null) {
          final double dist = widget.profile['distance_from_client'].toDouble();
          if (dist <= 5) {
            rateKey = 'up_to_5_km';
          } else if (dist <= 10) {
            rateKey = '5_to_10_km';
          } else {
            rateKey = 'beyond_10_km';
          }
        } else {
          rateKey = 'up_to_5_km';
        }
      } else if (distance == 1) {
        rateKey = 'up_to_5_km';
      } else if (distance == 2) {
        rateKey = '5_to_10_km';
      } else if (distance == 3) {
        rateKey = 'beyond_10_km';
      } else {
        print('Invalid distance value: $distance for ${widget.profile['id']}');
        return widget.isShiftLabel ? '' : 'N/A';
      }

      if (widget.profile['rates'][rateKey] is num) {
        totalRate = widget.profile['rates'][rateKey].toDouble();
        print(
          'Physio rate for ${widget.profile['id']}: rateKey=$rateKey, totalRate=$totalRate, distance=${widget.profile['distance_from_client']}',
        );
        if (widget.isShiftLabel) {
          final visitFee =
              widget.profile['rates']['up_to_5_km'] is num
                  ? widget.profile['rates']['up_to_5_km'].toDouble().round()
                  : 0;
          final travelCharge = totalRate - visitFee;
          print(
            'Breakdown for ${widget.profile['id']}: visitFee=$visitFee, travelCharge=$travelCharge',
          );
          if (visitFee > 0) {
            return 'Rs $visitFee (fees) + Rs ${travelCharge.round()} (travel)';
          }
          return '';
        }
        return totalRate.round().toString();
      }
      print('No valid rate for $rateKey in profile ${widget.profile['id']}');
      return widget.isShiftLabel ? '' : 'N/A';
    } else if (roleLower == 'doctor') {
      if (widget.isShiftLabel) return '';
      if (consultation == 1) {
        print('Using teleconsultation for ${widget.profile['id']}');
        return widget.profile['rates']['teleconsultation'] is num
            ? widget.profile['rates']['teleconsultation'].toString()
            : 'N/A';
      } else if (consultation == 2) {
        print('Using home_visit_below_10_km for ${widget.profile['id']}');
        return widget.profile['rates']['home_visit_below_10_km'] is num
            ? widget.profile['rates']['home_visit_below_10_km'].toString()
            : 'N/A';
      } else if (consultation == 3) {
        print('Using home_visit_above_10_km for ${widget.profile['id']}');
        return widget.profile['rates']['home_visit_above_10_km'] is num
            ? widget.profile['rates']['home_visit_above_10_km'].toString()
            : 'N/A';
      }
      print('Defaulting to teleconsultation rate for Doctor');
      return widget.profile['rates']['teleconsultation'] is num
          ? widget.profile['rates']['teleconsultation'].toString()
          : 'N/A';
    }
    print('Unknown role: ${widget.profile['role']}');
    if (widget.isShiftLabel) return '';
    return widget.profile['rates']['24_hour_shift']?.toString() ??
        widget.profile['rates']['teleconsultation']?.toString() ??
        widget.profile['rates']['up_to_5_km']?.toString() ??
        'N/A';
  }

  @override
  material.Widget build(material.BuildContext context) {
    return material.ValueListenableBuilder<int>(
      valueListenable: widget.selectedShift,
      builder: (context, shift, child) {
        return material.ValueListenableBuilder<int>(
          valueListenable: widget.selectedDistance,
          builder: (context, distance, child) {
            return material.ValueListenableBuilder<int>(
              valueListenable: widget.selectedConsultation,
              builder: (context, consultation, child) {
                final roleLower =
                    widget.profile['role'].toString().toLowerCase();
                final isNurseOrAttendant =
                    roleLower == 'nurse' ||
                    roleLower == 'staff nurse' ||
                    roleLower == 'attendant';
                final isPhysioOrDoctor =
                    roleLower == 'physiotherapist' || roleLower == 'doctor';

                String text = _getDisplayRate(shift, distance, consultation);
                String suffix = '';

                if (!widget.isShiftLabel) {
                  if (isNurseOrAttendant) {
                    if (consultation == 2) {
                      suffix = '/visit';
                    } else if (shift == 1 ||
                        shift == 2 ||
                        shift == 3 ||
                        shift == 4) {
                      suffix = '/day';
                    }
                  } else if (isPhysioOrDoctor) {
                    suffix = '/visit';
                  }
                }

                // Debug logging
                print(
                  'Rendering RateDisplay for ${widget.profile['id']}: '
                  'isShiftLabel=${widget.isShiftLabel}, role=$roleLower, '
                  'text=$text, suffix=$suffix, shift=$shift, consultation=$consultation',
                );

                return widget.isShiftLabel
                    ? material.Text(
                      text,
                      style: const material.TextStyle(
                        fontSize: 12,
                        fontWeight: material.FontWeight.w500,
                        color: AppColors.grey700,
                      ),
                    )
                    : material.RichText(
                      text: material.TextSpan(
                        children: [
                          material.TextSpan(
                            text: text,
                            style: material.TextStyle(
                              fontSize: 16,
                              fontWeight: material.FontWeight.bold,
                              color:
                                  text == 'Not interested'
                                      ? AppColors.grey600
                                      : AppColors.primary,
                            ),
                          ),
                          material.TextSpan(
                            text: suffix,
                            style: const material.TextStyle(
                              fontSize: 12,
                              fontWeight: material.FontWeight.normal,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
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
