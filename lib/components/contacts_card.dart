import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';
import '../components/tag.dart';

class ContactsCard extends material.StatefulWidget {
  final Map<String, dynamic> profile;
  final material.ValueNotifier<int> selectedShift;
  final material.ValueNotifier<int> selectedDistance;
  final material.ValueNotifier<int> selectedConsultation;

  const ContactsCard({
    super.key,
    required this.profile,
    required this.selectedShift,
    required this.selectedDistance,
    required this.selectedConsultation,
  });

  @override
  ContactsCardState createState() => ContactsCardState();
}

class ContactsCardState extends material.State<ContactsCard> {
  int _currentImageIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  String _getDisplayRate(int shift, bool isShiftLabel) {
    final rates =
        widget.profile['rates'] is Map
            ? Map<String, dynamic>.from(widget.profile['rates'])
            : {};
    final roleLower = widget.profile['role']?.toString().toLowerCase() ?? '';
    String rateKey =
        shift == 1
            ? 'day_shift'
            : shift == 2
            ? 'night_shift'
            : '24_hour_shift';
    String rateValue =
        rates[rateKey] is num
            ? rates[rateKey].toString()
            : rates[rateKey]?.toString() ?? 'N/A';

    if (isShiftLabel) {
      if (roleLower == 'nurse' ||
          roleLower == 'staff nurse' ||
          roleLower == 'attendant') {
        if (shift == 1) return 'For 12 hrs Day shift';
        if (shift == 2) return 'For 12 hrs Night shift';
        if (shift == 3) return 'For 24 hrs shift';
        return 'For 24 hrs shift';
      }
      return '';
    }

    if (roleLower == 'nurse' ||
        roleLower == 'staff nurse' ||
        roleLower == 'attendant') {
      return rateValue == 'Not interested' ? 'Not available' : rateValue;
    }
    return 'N/A';
  }

  @override
  material.Widget build(material.BuildContext context) {
    final bool showTopTag =
        widget.profile['ranking'] != null &&
        (widget.profile['ranking'] is num && widget.profile['ranking'] <= 10) &&
        widget.profile['role']?.toString().toLowerCase() != 'doctor';
    final iconColor =
        widget.profile['gender'] == 'Male' ? AppColors.primary : AppColors.pink;
    final images =
        (widget.profile['images'] as List<dynamic>?)?.cast<String>() ?? [];
    final savedName = widget.profile['saved_name']?.toString() ?? 'Not saved';

    print(
      'Rendering ContactsCard: ID=${widget.profile['id']}, name=${widget.profile['name']}, saved_name=$savedName, role=${widget.profile['role']}',
    );

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
                      'Top 10 ${widget.profile['role'] ?? 'Staff'} in Delhi',
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
                      images.isNotEmpty
                          ? CarouselSlider(
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
                                images.map((image) {
                                  return material.ClipRRect(
                                    borderRadius: material
                                        .BorderRadius.circular(13),
                                    child: material.Image.asset(
                                      image,
                                      width: 100,
                                      height: 125,
                                      fit: material.BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              material.Text(
                                                'Image not found',
                                                style: const material.TextStyle(
                                                  color: AppColors.grey600,
                                                ),
                                              ),
                                    ),
                                  );
                                }).toList(),
                          )
                          : material.Text(
                            'No images',
                            style: const material.TextStyle(
                              color: AppColors.grey600,
                            ),
                          ),
                      if (images.isNotEmpty)
                        material.Positioned(
                          bottom: 15,
                          child: material.Row(
                            mainAxisAlignment:
                                material.MainAxisAlignment.center,
                            children: List.generate(images.length, (index) {
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
                              widget.profile['name']?.toString() ?? 'Unknown',
                              style: const material.TextStyle(
                                fontSize: 20,
                                fontWeight: material.FontWeight.bold,
                                color: AppColors.grey900,
                              ),
                            ),
                            const material.SizedBox(width: 16),
                            material.Icon(
                              material.Icons.person,
                              size: 24,
                              color: iconColor,
                            ),
                          ],
                        ),
                      ),
                      const material.SizedBox(height: 8),
                      material.SingleChildScrollView(
                        scrollDirection: material.Axis.horizontal,
                        child: material.Text(
                          savedName,
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
                          widget.profile['role']?.toString() ?? 'Unknown',
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
                          widget.profile['qualifications'] != null &&
                                  widget.profile['experience'] != null
                              ? '${widget.profile['qualifications']} | ${widget.profile['experience']} yrs Exp'
                              : 'No qualifications or experience',
                          style: const material.TextStyle(
                            fontSize: 16,
                            fontWeight: material.FontWeight.w500,
                            color: AppColors.grey600,
                            height: 1.4,
                            letterSpacing: 0.2,
                          ),
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
                      'Rating',
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
