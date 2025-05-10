import 'package:flutter/material.dart' as material;
import '../components/index.dart';
// For SeeAll component

class HomeTab extends material.StatelessWidget {
  final material.ThemeMode themeMode;

  const HomeTab({super.key, this.themeMode = material.ThemeMode.light});

  @override
  material.Widget build(material.BuildContext context) {
    return material.SingleChildScrollView(
      child: material.Padding(
        padding: const material.EdgeInsets.symmetric(horizontal: 24),
        child: material.Column(
          crossAxisAlignment: material.CrossAxisAlignment.start,
          children: [
            // First Row: App bar (already in main.dart via HomePageNavBar)
            // Spacing: 24px
            const material.SizedBox(height: 24),
            // Second Row: Default Light Search
            Search(
              themeMode: themeMode,
              onChanged: (value) {
                // Handle search text changes
              },
              onFilterPressed: () {
                // Add filter logic here
              },
            ),
            // Spacing: 24px
            const material.SizedBox(height: 24),
            // Third Row: Image with curves
            material.ClipRRect(
              borderRadius: material.BorderRadius.circular(28),
              child: material.Image.asset(
                'assets/images/bluecardwithcurves.png',
                fit: material.BoxFit.fitWidth, // Full width, auto height
                width: double.infinity, // Ensure full width
              ),
            ),
            // Spacing: 24px
            const material.SizedBox(height: 24),
            // Fourth Row: Recommendation Section using SeeAll component
            const SeeAll(title: 'Recommendation'),
            // Spacing: 24px
            const material.SizedBox(height: 24),
            // Fifth Row: Horizontal Scrollable JobCard Section
            // Spacing: 24px
            const material.SizedBox(height: 24),
            // Sixth Row: Alert Component (Success variant)
            const Alert(
              message: 'Alert message',
              variant: AlertVariant.success,
            ),
            // Spacing: 24px
            const material.SizedBox(height: 24),
            // Seventh Row: All Tag Variants Inline
            material.Wrap(
              spacing: 8, // 8px horizontal spacing between tags
              runSpacing: 8, // 8px vertical spacing if wrapped
              children: const [
                Tag(text: 'Default', variant: TagVariant.defaultTag),
                Tag(text: 'Info', variant: TagVariant.info),
                Tag(text: 'Warning', variant: TagVariant.warning),
                Tag(text: 'Error', variant: TagVariant.error),
                Tag(text: 'Success', variant: TagVariant.success),
                Tag(
                  text: 'Outlined Default',
                  variant: TagVariant.outlinedDefault,
                ),
                Tag(text: 'Outlined Info', variant: TagVariant.outlinedInfo),
                Tag(
                  text: 'Outlined Success',
                  variant: TagVariant.outlinedSuccess,
                ),
                Tag(
                  text: 'Outlined Warning',
                  variant: TagVariant.outlinedWarning,
                ),
                Tag(text: 'Outlined Error', variant: TagVariant.outlinedError),
                Tag(
                  text: 'Inverted Default Light',
                  variant: TagVariant.invertedDefaultLight,
                ),
                Tag(
                  text: 'Inverted Info Light',
                  variant: TagVariant.invertedInfoLight,
                ),
                Tag(
                  text: 'Inverted Success Light',
                  variant: TagVariant.invertedSuccessLight,
                ),
                Tag(
                  text: 'Inverted Warning Light',
                  variant: TagVariant.invertedWarningLight,
                ),
                Tag(
                  text: 'Inverted Error Light',
                  variant: TagVariant.invertedErrorLight,
                ),
                Tag(
                  text: 'Inverted Default Dark',
                  variant: TagVariant.invertedDefaultDark,
                ),
                Tag(
                  text: 'Inverted Info Dark',
                  variant: TagVariant.invertedInfoDark,
                ),
                Tag(
                  text: 'Inverted Success Dark',
                  variant: TagVariant.invertedSuccessDark,
                ),
                Tag(
                  text: 'Inverted Warning Dark',
                  variant: TagVariant.invertedWarningDark,
                ),
                Tag(
                  text: 'Inverted Error Dark',
                  variant: TagVariant.invertedErrorDark,
                ),
                Tag(
                  text: 'Borderless Default',
                  variant: TagVariant.borderlessDefault,
                ),
                Tag(
                  text: 'Borderless Info',
                  variant: TagVariant.borderlessInfo,
                ),
                Tag(
                  text: 'Borderless Success',
                  variant: TagVariant.borderlessSuccess,
                ),
                Tag(
                  text: 'Borderless Warning',
                  variant: TagVariant.borderlessWarning,
                ),
                Tag(
                  text: 'Borderless Error',
                  variant: TagVariant.borderlessError,
                ),
              ],
            ),
            // Spacing: 24px
            const material.SizedBox(height: 24),
            // Eighth Row: ProgressLine Components Inline
            material.Wrap(
              spacing:
                  8, // 8px horizontal spacing between ProgressLine components
              runSpacing: 8, // 8px vertical spacing if wrapped
              children: [
                ProgressLine(
                  progress: 1.0, // 100% progress
                  text: '100/100',
                  themeMode: themeMode, // Pass themeMode from HomeTab
                ),
                ProgressLine(
                  progress: 0.8, // 80% progress
                  text: '80/100',
                  themeMode: themeMode, // Pass themeMode from HomeTab
                ),
              ],
            ),
            // Spacing: 24px
            const material.SizedBox(height: 24),
            // Ninth Row: LessonList Components
            material.Column(
              children: [
                LessonList(
                  progressText: '01',
                  topicTitle: 'Math 101',
                  duration: '30 min',
                  icons: const [material.Icons.play_arrow], // Modern play arrow
                  themeMode: themeMode, // Pass themeMode from HomeTab
                ),
                // Spacing: 16px
                const material.SizedBox(height: 16),
                LessonList(
                  progressText: '02',
                  topicTitle: 'Science 101',
                  duration: '45 min',
                  icons: const [], // No icons to show collapsible space
                  themeMode: themeMode, // Pass themeMode from HomeTab
                ),
              ],
            ),
            // Spacing: 24px
            const material.SizedBox(height: 24),
            // Tenth Row: SubjectsList Component
            SubjectsList(
              imagePath: 'assets/images/placeholder.png',
              tagText: 'MCQs',
              bookTitle: 'Mathematics Basics',
              priceText: 'Free',
              studentCount: '197 Students',
            ),
          ],
        ),
      ),
    );
  }
}
