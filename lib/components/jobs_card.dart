import 'package:flutter/material.dart' as material;
import 'package:flutter_svg/flutter_svg.dart' as svg;
import '../constants/colors.dart';
import '../components/tag.dart';

class JobsCard extends material.StatelessWidget {
  final Map<String, dynamic> job;

  const JobsCard({super.key, required this.job});

  // List of valid image assets
  static const List<String> validImages = [
    'assets/images/female_white2.png',
    'assets/images/female_white3.png',
    'assets/images/female_asian_car.png',
    'assets/images/male_india1.png',
    'assets/images/female_asian_office.png',
    'assets/images/female_asian_traveller.png',
    'assets/images/male_white.png',
    'assets/images/male_white2.png',
    'assets/images/female_white.png',
    'assets/images/male_white_blazer.png',
    'assets/images/male_white_mall.png',
    'assets/images/male_white_student.png',
    'assets/images/male_indian.png',
    'assets/images/placeholder.png',
  ];

  // Validate image path
  String getValidImage(String? image) {
    if (image != null && validImages.contains(image)) {
      return image;
    }
    print('Invalid image path: $image, falling back to placeholder.png');
    return 'assets/images/placeholder.png';
  }

  // Location display: distance, area, city
  String getLocationDisplay() {
    final String area = job['area']?.toString() ?? 'N/A';
    final String city = job['city']?.toString() ?? 'N/A';
    final String distance = job['distance']?.toString() ?? '0';
    return '$distance km - $area, $city';
  }

  // Gender display: "All" for "Not Applicable" or null
  String getGenderDisplay() {
    final gender = job['gender']?.toString().toLowerCase();
    return gender == null || gender == 'not applicable'
        ? 'All'
        : job['gender'].toString();
  }

  @override
  material.Widget build(material.BuildContext context) {
    final gender = job['gender']?.toString().toLowerCase();
    final isMale = gender == 'male';
    final isAll = gender == null || gender == 'not applicable';
    final userIconColor =
        isMale
            ? AppColors.primary
            : isAll
            ? AppColors.grey400
            : AppColors.pink;
    final status = job['application_status']?.toString().trim().toLowerCase();
    final normalizedStatus =
        status == 'apply'
            ? 'Apply'
            : status == 'applied'
            ? 'Applied'
            : status == 'hired'
            ? 'Hired'
            : 'Apply';
    print(
      'Job ${job['id']}: application_status = $status, normalizedStatus = $normalizedStatus',
    );

    return material.ConstrainedBox(
      constraints: const material.BoxConstraints(minWidth: 200, minHeight: 100),
      child: material.Container(
        width: double.infinity,
        padding: const material.EdgeInsets.all(10),
        decoration: const material.BoxDecoration(
          color: AppColors.white,
          borderRadius: material.BorderRadius.all(material.Radius.circular(28)),
          border: material.Border.fromBorderSide(
            material.BorderSide(color: AppColors.grey200, width: 1),
          ),
        ),
        child: material.Column(
          mainAxisSize: material.MainAxisSize.min,
          crossAxisAlignment: material.CrossAxisAlignment.start,
          children: [
            // Date/Time
            material.SingleChildScrollView(
              scrollDirection: material.Axis.horizontal,
              child: material.Row(
                children: [
                  material.Text(
                    '${job['day']?.toString() ?? 'N/A'}, ${job['date']?.toString() ?? 'N/A'}',
                    style: const material.TextStyle(
                      fontSize: 10,
                      color: AppColors.grey700,
                      height: 1.0,
                    ),
                  ),
                  const material.SizedBox(width: 12),
                  material.Text(
                    job['time']?.toString() ?? 'N/A',
                    style: const material.TextStyle(
                      fontSize: 10,
                      color: AppColors.grey700,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            const material.SizedBox(height: 10),
            // Role/Gender and Rate
            material.Row(
              mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
              children: [
                material.Expanded(
                  child: material.Row(
                    children: [
                      svg.SvgPicture.asset(
                        'assets/icons/profile_bold.svg',
                        width: 24,
                        height: 24,
                        colorFilter: material.ColorFilter.mode(
                          userIconColor,
                          material.BlendMode.srcIn,
                        ),
                      ),
                      const material.SizedBox(width: 8),
                      material.Flexible(
                        child: material.Text(
                          '${job['requirement']?.toString() ?? 'N/A'} | ${getGenderDisplay()}',
                          style: const material.TextStyle(
                            fontSize: 20,
                            fontWeight: material.FontWeight.w600,
                            color: AppColors.grey900,
                            height: 1.2,
                          ),
                          overflow: material.TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                material.Row(
                  mainAxisSize: material.MainAxisSize.min,
                  children: [
                    const material.Icon(
                      material.Icons.currency_rupee,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    material.Text(
                      job['rate']?.toString() ?? 'N/A',
                      style: const material.TextStyle(
                        fontSize: 18,
                        fontWeight: material.FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const material.SizedBox(height: 10),
            // Location and Shift
            material.Row(
              mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
              children: [
                material.Expanded(
                  child: material.Row(
                    children: [
                      svg.SvgPicture.asset(
                        'assets/icons/location_bold.svg',
                        width: 24,
                        height: 24,
                        colorFilter: material.ColorFilter.mode(
                          AppColors.primary,
                          material.BlendMode.srcIn,
                        ),
                      ),
                      const material.SizedBox(width: 8),
                      material.Flexible(
                        child: material.Text(
                          getLocationDisplay(),
                          style: const material.TextStyle(
                            fontSize: 16,
                            fontWeight: material.FontWeight.w500,
                            color: AppColors.grey600,
                            height: 1.4,
                          ),
                          overflow: material.TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                material.Text(
                  job['shift']?.toString() ?? 'N/A',
                  style: const material.TextStyle(
                    fontSize: 16,
                    fontWeight: material.FontWeight.w500,
                    color: AppColors.grey600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
            const material.SizedBox(height: 10),
            // Languages and Seniority
            material.Row(
              mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
              children: [
                material.Expanded(
                  child: material.Row(
                    children: [
                      svg.SvgPicture.asset(
                        'assets/icons/voice_bold.svg',
                        width: 24,
                        height: 24,
                        colorFilter: material.ColorFilter.mode(
                          AppColors.primary,
                          material.BlendMode.srcIn,
                        ),
                      ),
                      const material.SizedBox(width: 8),
                      material.Flexible(
                        child: material.Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children:
                              (job['languages'] as List<dynamic>?)
                                  ?.take(3)
                                  .map(
                                    (lang) => Tag(
                                      text:
                                          (lang
                                                  as Map<
                                                    String,
                                                    dynamic
                                                  >)['language']
                                              ?.toString() ??
                                          'N/A',
                                      variant: TagVariant.outlinedDefault,
                                    ),
                                  )
                                  .toList() ??
                              [
                                Tag(
                                  text: 'N/A',
                                  variant: TagVariant.outlinedDefault,
                                ),
                              ],
                        ),
                      ),
                    ],
                  ),
                ),
                Tag(
                  text: job['seniority']?.toString() ?? 'N/A',
                  variant: TagVariant.outlinedInfo,
                ),
              ],
            ),
            const material.SizedBox(height: 10),
            const material.Divider(
              color: AppColors.grey200,
              height: 1,
              thickness: 1,
            ),
            const material.SizedBox(height: 6),
            // Posted By
            const material.Text(
              'Posted by',
              style: material.TextStyle(
                fontSize: 10,
                color: AppColors.grey700,
                height: 1.0,
              ),
            ),
            // Profile + Name/Role and Button/Applicants
            material.Row(
              mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
              children: [
                material.Row(
                  children: [
                    material.ClipRRect(
                      borderRadius: material.BorderRadius.circular(12),
                      child: material.Image.asset(
                        getValidImage(job['image']),
                        width: 36,
                        height: 36,
                        fit: material.BoxFit.cover,
                      ),
                    ),
                    const material.SizedBox(width: 16),
                    material.Column(
                      mainAxisSize: material.MainAxisSize.min,
                      crossAxisAlignment: material.CrossAxisAlignment.start,
                      children: [
                        material.Text(
                          job['posted_by']?.toString() ?? 'N/A',
                          style: const material.TextStyle(
                            fontSize: 18,
                            fontWeight: material.FontWeight.w500,
                            color: AppColors.grey600,
                          ),
                          overflow: material.TextOverflow.ellipsis,
                        ),
                        material.Text(
                          job['type']?.toString() ?? 'N/A',
                          style: const material.TextStyle(
                            fontSize: 12,
                            color: AppColors.grey600,
                          ),
                          overflow: material.TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                material.Column(
                  mainAxisSize: material.MainAxisSize.min,
                  crossAxisAlignment: material.CrossAxisAlignment.end,
                  children: [
                    material.Theme(
                      data: material.Theme.of(context).copyWith(
                        elevatedButtonTheme: material.ElevatedButtonThemeData(
                          style: material.ElevatedButton.styleFrom(
                            backgroundColor:
                                normalizedStatus == 'Apply'
                                    ? AppColors.primary
                                    : normalizedStatus == 'Applied'
                                    ? AppColors.green
                                    : AppColors.grey400,
                            foregroundColor: AppColors.white,
                            disabledBackgroundColor:
                                normalizedStatus == 'Apply'
                                    ? AppColors.primary
                                    : normalizedStatus == 'Applied'
                                    ? AppColors.green
                                    : AppColors.grey400,
                            padding: const material.EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            shape: material.RoundedRectangleBorder(
                              borderRadius: material.BorderRadius.circular(6),
                            ),
                            minimumSize: const material.Size(0, 24),
                            textStyle: const material.TextStyle(
                              fontSize: 10,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                      child: material.ElevatedButton(
                        onPressed:
                            normalizedStatus == 'Apply'
                                ? () {
                                  print('Applying for job: ${job['id']}');
                                }
                                : null,
                        child: material.Text(
                          normalizedStatus,
                          style: const material.TextStyle(
                            fontSize: 10,
                            fontWeight: material.FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                    material.Text(
                      job['applicants'] != null && job['applicants'] > 10
                          ? '10+ Applicants'
                          : '${job['applicants']?.toString() ?? '0'} Applicants',
                      style: const material.TextStyle(
                        fontSize: 10,
                        color: AppColors.grey600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
