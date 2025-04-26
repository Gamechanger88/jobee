import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';
import 'tag.dart';

class SubjectsList extends material.StatelessWidget {
  final String imagePath; // Path to image (e.g., 'assets/images/subject.png')
  final String tagText; // Tag text (e.g., 'MCQs')
  final String bookTitle; // Book title
  final String priceText; // Price text (e.g., 'Free')
  final String studentCount; // Student count (e.g., '197 Students')
  final material.BoxConstraints?
  constraints; // Optional constraints for multiple instances

  const SubjectsList({
    super.key,
    this.imagePath = 'assets/images/placeholder.png',
    this.tagText = 'MCQs',
    this.bookTitle = 'Book Title',
    this.priceText = 'Free',
    this.studentCount = '197 Students',
    this.constraints,
  });

  @override
  material.Widget build(material.BuildContext context) {
    return material.Container(
      width: double.infinity, // Full width
      padding: const material.EdgeInsets.all(20),
      constraints: constraints, // Apply constraints if provided
      decoration: material.BoxDecoration(
        color: AppColors.white, // White fill
        borderRadius: material.BorderRadius.circular(32), // 32px border radius
        boxShadow: const [
          material.BoxShadow(
            color: material.Color(0x0D04060F), // 04060F at 5% opacity
            offset: material.Offset(0, 4), // x: 0, y: 4
            blurRadius: 60,
            spreadRadius: 0,
          ),
        ],
      ),
      child: material.Row(
        crossAxisAlignment: material.CrossAxisAlignment.center,
        children: [
          // Child 1: Image
          material.Container(
            width: 120,
            height: 150,
            decoration: material.BoxDecoration(
              borderRadius: material.BorderRadius.circular(
                20,
              ), // 20px border radius
              image: material.DecorationImage(
                image: material.AssetImage(imagePath),
                fit: material.BoxFit.cover, // Cover image
              ),
            ),
          ),
          // Spacing: 16px
          const material.SizedBox(width: 16),
          // Child 2: Frame
          material.Expanded(
            child: material.Column(
              mainAxisSize: material.MainAxisSize.min,
              mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: material.CrossAxisAlignment.start,
              children: [
                // Top-oriented Rows
                material.Column(
                  mainAxisSize: material.MainAxisSize.min,
                  crossAxisAlignment: material.CrossAxisAlignment.start,
                  children: [
                    // Row 1: Tag and Icon
                    material.Row(
                      mainAxisAlignment:
                          material.MainAxisAlignment.spaceBetween,
                      children: [
                        // Tag
                        Tag(
                          text: tagText,
                          variant:
                              TagVariant.invertedInfoLight, // Inverted info tag
                        ),
                        // Bookmark Icon
                        material.Icon(
                          material.Icons.bookmark_outline,
                          color: AppColors.primary, // Primary blue
                          size: 24,
                        ),
                      ],
                    ),
                    // Spacing: 12px
                    const material.SizedBox(height: 12),
                    // Row 2: Book Title
                    material.Text(
                      bookTitle,
                      style: material.Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(
                        color: AppColors.grey900, // Greyscale 900
                        fontWeight: material.FontWeight.w700, // Bold
                      ),
                      softWrap: true, // Wrap to next row if too long
                    ),
                  ],
                ),
                // Spacer to push remaining rows to bottom
                const material.SizedBox(height: 12),
                // Row 3: Price
                material.Text(
                  priceText,
                  style: material.Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(
                    color: AppColors.primary, // Primary blue
                    fontWeight: material.FontWeight.w700, // Bold
                  ),
                ),
                // Spacing: 12px
                const material.SizedBox(height: 12),
                // Row 4: Student Count
                material.Text(
                  studentCount,
                  style: material.Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(
                    color: AppColors.grey700, // Greyscale 700
                    fontWeight: material.FontWeight.w500, // Medium
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
