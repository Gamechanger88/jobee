import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';

enum TopBarVariant { defaultTopBar, iconBack, fullNavbar, homePageNavBar }

class AppTopBar extends material.StatelessWidget {
  final TopBarVariant variant;
  final material.ThemeMode themeMode; // Light or Dark mode
  final material.VoidCallback? onModeToggle; // Callback to toggle theme mode
  // For IconBack and FullNavbar variants
  final material.VoidCallback? onBackPressed;
  final List<material.Widget>? actions;
  final List<bool>? actionVisibilities;
  // For FullNavbar and HomePageNavBar variants
  final String? title;
  final List<String>?
  tabTitles; // Titles for the tab bar (e.g., Nurse, Attendant, Physio)
  final material.ValueChanged<int>? onTabChanged; // Callback for tab changes
  final int? selectedTabIndex; // Current selected tab index

  const AppTopBar({
    super.key,
    this.variant = TopBarVariant.defaultTopBar,
    this.themeMode = material.ThemeMode.light,
    this.onModeToggle,
    this.onBackPressed,
    this.actions,
    this.actionVisibilities,
    this.title,
    this.tabTitles,
    this.selectedTabIndex,
    this.onTabChanged,
  });

  @override
  material.Widget build(material.BuildContext context) {
    switch (variant) {
      case TopBarVariant.defaultTopBar:
        return const DefaultTopBar();
      case TopBarVariant.iconBack:
        return IconBackTopBar(
          onBackPressed: onBackPressed,
          actions: actions,
          actionVisibilities: actionVisibilities,
        );
      case TopBarVariant.fullNavbar:
        return FullNavbarTopBar(
          title: title ?? '',
          onBackPressed: onBackPressed,
          actions: actions,
          actionVisibilities: actionVisibilities,
          tabTitles: tabTitles ?? ['Nurse', 'Attendant', 'Physio'],
          selectedTabIndex: selectedTabIndex ?? 0,
          onTabChanged: onTabChanged,
        );
      case TopBarVariant.homePageNavBar:
        return HomePageNavBar(
          themeMode: themeMode,
          onModeToggle: onModeToggle,
          title: title ?? 'Jobee',
        );
    }
  }
}

// Default TopBar (Status Bar-style)
class DefaultTopBar extends material.StatelessWidget {
  const DefaultTopBar({super.key});

  @override
  material.Widget build(material.BuildContext context) {
    return material.Container(
      height: 44,
      color: material.Colors.transparent,
      padding: const material.EdgeInsets.symmetric(horizontal: 16),
      child: material.Row(
        mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
        children: [
          // Left: Network and notifications
          material.Row(
            children: [
              const material.Icon(
                material.Icons.signal_cellular_alt,
                color: AppColors.white,
                size: 16,
              ),
              const material.SizedBox(width: 8),
              const material.Icon(
                material.Icons.wifi,
                color: AppColors.white,
                size: 16,
              ),
              const material.SizedBox(width: 8),
              material.Container(
                padding: const material.EdgeInsets.all(4),
                decoration: const material.BoxDecoration(
                  color: AppColors.error,
                  shape: material.BoxShape.circle,
                ),
                child: material.Text(
                  '2',
                  style: material.Theme.of(context).textTheme.labelLarge!
                      .copyWith(color: AppColors.white, fontSize: 10),
                ),
              ),
            ],
          ),
          // Right: Battery and time
          material.Row(
            children: [
              material.Text(
                '12:34',
                style: material.Theme.of(context).textTheme.labelLarge!
                    .copyWith(color: AppColors.white, fontSize: 12),
              ),
              const material.SizedBox(width: 8),
              const material.Icon(
                material.Icons.battery_full,
                color: AppColors.white,
                size: 16,
              ),
              const material.SizedBox(width: 4),
              material.Text(
                '100%',
                style: material.Theme.of(context).textTheme.labelLarge!
                    .copyWith(color: AppColors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Icon Back TopBar (Navigation Bar-style with Back Icon, Empty Expanded Space, Actions)
class IconBackTopBar extends material.StatelessWidget {
  final material.VoidCallback? onBackPressed;
  final List<material.Widget>? actions;
  final List<bool>? actionVisibilities;

  const IconBackTopBar({
    super.key,
    this.onBackPressed,
    this.actions,
    this.actionVisibilities,
  });

  @override
  material.Widget build(material.BuildContext context) {
    // Default actions if none provided
    final defaultActions = [
      material.IconButton(
        icon: const material.Icon(
          material.Icons.settings,
          color: AppColors.primary,
          size: 28,
        ),
        onPressed: () {},
      ),
      material.IconButton(
        icon: const material.Icon(
          material.Icons.notifications,
          color: AppColors.primary,
          size: 28,
        ),
        onPressed: () {},
      ),
      material.IconButton(
        icon: const material.Icon(
          material.Icons.favorite,
          color: AppColors.primary,
          size: 28,
        ),
        onPressed: () {},
      ),
      material.IconButton(
        icon: const material.Icon(
          material.Icons.add,
          color: AppColors.primary,
          size: 28,
        ),
        onPressed: () {},
      ),
    ];

    final effectiveActions = actions ?? defaultActions;
    final effectiveVisibilities =
        actionVisibilities ??
        List.generate(effectiveActions.length, (index) => true);

    return material.Column(
      children: [
        // First Row: Default TopBar (Status Bar)
        const DefaultTopBar(),
        // Gap: 16px
        const material.SizedBox(height: 16),
        // Second Row: Icon Back TopBar (Auto Layout, 48px height)
        material.Container(
          height: 48,
          color: AppColors.primary,
          padding: const material.EdgeInsets.symmetric(horizontal: 16),
          child: material.Row(
            children: [
              // Left: Back Icon (28x28)
              material.IconButton(
                icon: const material.Icon(
                  material.Icons.arrow_back,
                  color: AppColors.white,
                  size: 28,
                ),
                onPressed:
                    onBackPressed ?? () => material.Navigator.pop(context),
                padding: material.EdgeInsets.zero,
                constraints: const material.BoxConstraints(
                  minWidth: 28,
                  minHeight: 28,
                ),
              ),
              // Spacing: 16px
              const material.SizedBox(width: 16),
              // Middle: Expanded Empty Space
              const material.Expanded(child: material.SizedBox()),
              // Spacing: 16px
              const material.SizedBox(width: 16),
              // Right: Actions (Icons, 28x28, 20px gap)
              material.Row(
                mainAxisSize: material.MainAxisSize.min,
                children:
                    effectiveActions.asMap().entries.map((entry) {
                      final index = entry.key;
                      final action = entry.value;
                      final isVisible = effectiveVisibilities[index];
                      return isVisible
                          ? material.Padding(
                            padding: material.EdgeInsets.only(
                              left: index > 0 ? 20 : 0,
                            ),
                            child: material.SizedBox(
                              width: 28,
                              height: 28,
                              child: action,
                            ),
                          )
                          : const material.SizedBox.shrink();
                    }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Full Navbar TopBar (Status Bar, Icon Back, Tab Bar)
class FullNavbarTopBar extends material.StatelessWidget {
  final String title;
  final material.VoidCallback? onBackPressed;
  final List<material.Widget>? actions;
  final List<bool>? actionVisibilities;
  final List<String> tabTitles;
  final int selectedTabIndex;
  final material.ValueChanged<int>? onTabChanged;

  const FullNavbarTopBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
    this.actionVisibilities,
    required this.tabTitles,
    required this.selectedTabIndex,
    this.onTabChanged,
  });

  @override
  material.Widget build(material.BuildContext context) {
    // Default actions for IconBackTopBar section
    final defaultActions = [
      material.IconButton(
        icon: const material.Icon(
          material.Icons.settings,
          color: AppColors.primary,
          size: 28,
        ),
        onPressed: () {},
      ),
      material.IconButton(
        icon: const material.Icon(
          material.Icons.notifications,
          color: AppColors.primary,
          size: 28,
        ),
        onPressed: () {},
      ),
      material.IconButton(
        icon: const material.Icon(
          material.Icons.favorite,
          color: AppColors.primary,
          size: 28,
        ),
        onPressed: () {},
      ),
    ];

    final effectiveActions = actions ?? defaultActions;
    final effectiveVisibilities =
        actionVisibilities ??
        List.generate(effectiveActions.length, (index) => true);

    return material.Column(
      children: [
        // First Row: Default TopBar (Status Bar)
        const DefaultTopBar(),
        // Spacing: 16px
        const material.SizedBox(height: 16),
        // Second Row: Modified Icon Back TopBar (App Logo, Back Icon, Title, Actions)
        material.Container(
          margin: const material.EdgeInsets.symmetric(vertical: 12),
          padding: const material.EdgeInsets.symmetric(horizontal: 24),
          height: 48,
          color: AppColors.primary,
          child: material.Row(
            mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
            children: [
              // Left-Oriented: App Logo, Back Icon, Title
              material.Row(
                children: [
                  // App Logo (32x32)
                  const material.Icon(
                    material.Icons.circle,
                    color: AppColors.white,
                    size: 32,
                  ),
                  // Spacing: 16px
                  const material.SizedBox(width: 16),
                  // Back Icon (28x28)
                  material.IconButton(
                    icon: const material.Icon(
                      material.Icons.arrow_back,
                      color: AppColors.white,
                      size: 28,
                    ),
                    onPressed:
                        onBackPressed ?? () => material.Navigator.pop(context),
                    padding: material.EdgeInsets.zero,
                    constraints: const material.BoxConstraints(
                      minWidth: 28,
                      minHeight: 28,
                    ),
                  ),
                  // Spacing: 16px
                  const material.SizedBox(width: 16),
                  // Title (H4 Bold, Greyscale 900)
                  material.Text(
                    title,
                    style: material.Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: AppColors.grey900),
                  ),
                ],
              ),
              // Right-Oriented: Actions (Icons, 28x28, 16px gap)
              material.Row(
                mainAxisSize: material.MainAxisSize.min,
                children:
                    effectiveActions.asMap().entries.map((entry) {
                      final index = entry.key;
                      final action = entry.value;
                      final isVisible = effectiveVisibilities[index];
                      return isVisible
                          ? material.Padding(
                            padding: material.EdgeInsets.only(
                              left: index > 0 ? 16 : 0,
                            ),
                            child: material.SizedBox(
                              width: 28,
                              height: 28,
                              child: action,
                            ),
                          )
                          : const material.SizedBox.shrink();
                    }).toList(),
              ),
            ],
          ),
        ),
        // Spacing: 16px
        const material.SizedBox(height: 16),
        // Third Row: Tab Bar (Nurse, Attendant, Physio)
        material.Container(
          padding: const material.EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 0,
          ),
          child: material.Row(
            children:
                tabTitles.asMap().entries.map((entry) {
                  final index = entry.key;
                  final tabTitle = entry.value;
                  final isActive = index == selectedTabIndex;
                  return material.Expanded(
                    child: material.GestureDetector(
                      onTap:
                          onTabChanged != null
                              ? () => onTabChanged!(index)
                              : null,
                      child: material.Column(
                        mainAxisSize: material.MainAxisSize.min,
                        children: [
                          material.Text(
                            tabTitle,
                            style: material.Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              fontWeight: material.FontWeight.w600, // Semibold
                              color:
                                  isActive
                                      ? AppColors.primary
                                      : AppColors.grey500,
                            ),
                            textAlign: material.TextAlign.center,
                          ),
                          const material.SizedBox(height: 12),
                          if (isActive)
                            material.Container(
                              height: 4,
                              decoration: material.BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: material.BorderRadius.circular(
                                  100,
                                ),
                              ),
                            )
                          else
                            const material.SizedBox.shrink(),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}

// Home Page NavBar (Transparent Space + Row with Avatar, Title, Mode Toggle Icon)
class HomePageNavBar extends material.StatelessWidget {
  final material.ThemeMode themeMode;
  final material.VoidCallback? onModeToggle;
  final String title;

  const HomePageNavBar({
    super.key,
    this.themeMode = material.ThemeMode.light,
    this.onModeToggle,
    required this.title,
  });

  @override
  material.Widget build(material.BuildContext context) {
    // Colors based on themeMode
    final material.Color avatarBackgroundColor =
        themeMode == material.ThemeMode.light
            ? AppColors
                .grey400 // Light mode: Greyscale 400
            : AppColors.grey700; // Dark mode: Greyscale 700
    final material.Color titleColor =
        themeMode == material.ThemeMode.light
            ? AppColors
                .black // Light mode: Black
            : AppColors.white; // Dark mode: White
    final material.Color modeIconColor =
        themeMode == material.ThemeMode.light
            ? AppColors
                .grey900 // Light mode: Greyscale 900
            : AppColors.white; // Dark mode: White

    return material.Column(
      children: [
        // Transparent Space (44px height for system info)
        const DefaultTopBar(),
        // Row with Avatar, Title, and Mode Toggle Icon
        material.Container(
          margin: const material.EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: material.Row(
            mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
            children: [
              // Left: 48x48 Container (e.g., for avatar)
              material.Container(
                width: 48,
                height: 48,
                decoration: material.BoxDecoration(
                  color: avatarBackgroundColor,
                  borderRadius: material.BorderRadius.circular(24),
                ),
                child: const material.Icon(
                  material.Icons.person,
                  color: AppColors.white,
                  size: 32,
                ),
              ),
              // Spacing: 24px
              const material.SizedBox(width: 24),
              // Middle: Expanded Text Column with App Name (H4 Bold)
              material.Expanded(
                child: material.Column(
                  mainAxisSize: material.MainAxisSize.min,
                  crossAxisAlignment: material.CrossAxisAlignment.start,
                  children: [
                    material.Text(
                      title,
                      style: material.Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(color: titleColor),
                    ),
                  ],
                ),
              ),
              // Spacing: 24px
              const material.SizedBox(width: 24),
              // Right: 48x48 Container with Mode Toggle Icon
              material.Container(
                width: 48,
                height: 48,
                alignment: material.Alignment.centerRight,
                child: material.IconButton(
                  icon: material.Icon(
                    themeMode == material.ThemeMode.light
                        ? material
                            .Icons
                            .nightlight_round // Light mode: Moon icon
                        : material.Icons.wb_sunny, // Dark mode: Sun icon
                    color: modeIconColor,
                    size: 24,
                  ),
                  onPressed: onModeToggle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
