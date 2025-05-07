import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';

enum TopBarVariant {
  defaultTopBar,
  iconBack,
  fullNavbar,
  homePageNavBar,
  titleIcon,
  titleIconDark,
  batteryBar,
  UserTypeAppBar,
}

class AppTopBar extends material.StatelessWidget {
  final TopBarVariant variant;
  final material.ThemeMode themeMode;
  final material.VoidCallback? onModeToggle;
  final material.VoidCallback? onBackPressed;
  final List<material.Widget>? actions;
  final List<bool>? actionVisibilities;
  final String? title;
  final List<String>? tabTitles;
  final material.ValueChanged<int>? onTabChanged;
  final int? selectedTabIndex;

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
          themeMode: themeMode,
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
      case TopBarVariant.titleIcon:
        return TitleIconTopBar(
          onBackPressed: onBackPressed,
          actions: actions,
          actionVisibilities: actionVisibilities,
          themeMode: themeMode,
          title: title,
        );
      case TopBarVariant.titleIconDark:
        return TitleIconDarkTopBar(
          onBackPressed: onBackPressed,
          actions: actions,
          actionVisibilities: actionVisibilities,
          themeMode: themeMode,
          title: title,
        );
      case TopBarVariant.batteryBar:
        return const DefaultTopBar();
      case TopBarVariant.UserTypeAppBar:
        return material.Container(
          padding: const material.EdgeInsets.symmetric(vertical: 10),
          color:
              themeMode == material.ThemeMode.dark
                  ? AppColors.dark3
                  : AppColors.white,
          child: material.Row(
            mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
            children: [
              material.Row(
                children: [
                  if (onBackPressed != null)
                    material.IconButton(
                      icon: material.Icon(
                        material.Icons.arrow_back,
                        color:
                            themeMode == material.ThemeMode.dark
                                ? AppColors.white
                                : AppColors.grey600,
                        size: 24,
                      ),
                      onPressed: onBackPressed,
                    ),
                  material.Text(
                    title ?? 'Find Jobs',
                    style: material.TextStyle(
                      fontSize: 18,
                      fontWeight: material.FontWeight.w700,
                      color:
                          themeMode == material.ThemeMode.dark
                              ? AppColors.white
                              : AppColors.black,
                    ),
                  ),
                ],
              ),
              material.Row(
                children: List.generate(actions?.length ?? 0, (index) {
                  return material.Visibility(
                    visible:
                        actionVisibilities != null &&
                                actionVisibilities!.length > index
                            ? actionVisibilities![index]
                            : true,
                    child:
                        actions != null
                            ? actions![index]
                            : const material.SizedBox.shrink(),
                  );
                }),
              ),
            ],
          ),
        );
    }
  }
}

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

class IconBackTopBar extends material.StatelessWidget {
  final material.VoidCallback? onBackPressed;
  final List<material.Widget>? actions;
  final List<bool>? actionVisibilities;
  final material.ThemeMode themeMode;

  const IconBackTopBar({
    super.key,
    this.onBackPressed,
    this.actions,
    this.actionVisibilities,
    required this.themeMode,
  });

  @override
  material.Widget build(material.BuildContext context) {
    final isDarkMode = themeMode == material.ThemeMode.dark;
    final backgroundColor = isDarkMode ? AppColors.dark2 : AppColors.primary;
    final iconColor = isDarkMode ? AppColors.grey200 : AppColors.white;

    final defaultActions = [
      material.IconButton(
        icon: material.Icon(material.Icons.search, color: iconColor, size: 28),
        onPressed: () {},
        tooltip: 'Search',
      ),
    ];

    final effectiveActions = actions ?? defaultActions;
    final effectiveVisibilities =
        actionVisibilities ??
        List.generate(effectiveActions.length, (index) => true);

    return material.Column(
      children: [
        const DefaultTopBar(),
        const material.SizedBox(height: 16),
        material.Container(
          height: 48,
          color: backgroundColor,
          padding: const material.EdgeInsets.symmetric(horizontal: 16),
          child: material.Row(
            children: [
              material.IconButton(
                icon: material.Icon(
                  material.Icons.arrow_back,
                  color: iconColor,
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
              const material.SizedBox(width: 16),
              const material.Expanded(child: material.SizedBox()),
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
                              left: index > 0 ? 0 : 0,
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

class TitleIconTopBar extends material.StatelessWidget {
  final material.VoidCallback? onBackPressed;
  final List<material.Widget>? actions;
  final List<bool>? actionVisibilities;
  final material.ThemeMode themeMode;
  final String? title;

  const TitleIconTopBar({
    super.key,
    this.onBackPressed,
    this.actions,
    this.actionVisibilities,
    required this.themeMode,
    this.title,
  });

  @override
  material.Widget build(material.BuildContext context) {
    final isDarkMode = themeMode == material.ThemeMode.dark;
    final iconColor = isDarkMode ? AppColors.grey200 : AppColors.white;

    final defaultActions = [
      material.IconButton(
        icon: material.Icon(material.Icons.search, color: iconColor, size: 28),
        onPressed: () {},
        tooltip: 'Search',
        padding: material.EdgeInsets.zero,
        constraints: const material.BoxConstraints(),
      ),
    ];

    final effectiveActions =
        actions != null && actions!.isNotEmpty ? actions! : defaultActions;
    final effectiveVisibilities =
        actionVisibilities != null &&
                actionVisibilities!.length == effectiveActions.length
            ? actionVisibilities!
            : List.generate(effectiveActions.length, (index) => true);

    return material.Column(
      children: [
        const DefaultTopBar(),
        material.Padding(
          padding: const material.EdgeInsets.only(left: 20),
          child: material.Row(
            mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
            children: [
              material.Expanded(
                child: material.Row(
                  children: [
                    material.IconButton(
                      icon: material.Icon(
                        material.Icons.arrow_back,
                        size: 28,
                        color: AppColors.grey900,
                      ),
                      onPressed:
                          onBackPressed ??
                          () => material.Navigator.pop(context),
                      padding: material.EdgeInsets.zero,
                      constraints: const material.BoxConstraints(),
                    ),
                    const material.SizedBox(width: 16),
                    material.Expanded(
                      child: material.Text(
                        title ?? 'Find Jobs',
                        style: material.Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(
                          color: AppColors.grey900,
                          fontWeight: material.FontWeight.w700,
                          fontSize: 20,
                        ),
                        textAlign: material.TextAlign.left,
                        overflow: material.TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const material.SizedBox(width: 12),
              material.Row(
                mainAxisAlignment: material.MainAxisAlignment.end,
                children: [
                  material.SizedBox(
                    width: 28,
                    height: 28,
                    child: material.IconButton(
                      icon: material.Icon(
                        material.Icons.favorite,
                        size: 24,
                        color: AppColors.primary,
                      ),
                      onPressed: () {},
                      padding: material.EdgeInsets.zero,
                      constraints: const material.BoxConstraints(),
                    ),
                  ),
                  const material.SizedBox(width: 16),
                  material.SizedBox(
                    width: 28,
                    height: 28,
                    child: material.IconButton(
                      icon: material.Icon(
                        material.Icons.notifications,
                        size: 24,
                        color: AppColors.primary,
                      ),
                      onPressed: () {},
                      padding: material.EdgeInsets.zero,
                      constraints: const material.BoxConstraints(),
                    ),
                  ),
                  const material.SizedBox(width: 16),
                  material.SizedBox(
                    width: 28,
                    height: 28,
                    child: material.IconButton(
                      icon: material.Icon(
                        material.Icons.map,
                        size: 24,
                        color: AppColors.primary,
                      ),
                      onPressed: () {},
                      padding: material.EdgeInsets.zero,
                      constraints: const material.BoxConstraints(),
                    ),
                  ),
                  ...effectiveActions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final action = entry.value;
                    final isVisible = effectiveVisibilities[index];
                    return isVisible
                        ? material.SizedBox(
                          width: 28,
                          height: 28,
                          child: action,
                        )
                        : const material.SizedBox.shrink();
                  }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TitleIconDarkTopBar extends material.StatelessWidget {
  final material.VoidCallback? onBackPressed;
  final List<material.Widget>? actions;
  final List<bool>? actionVisibilities;
  final material.ThemeMode themeMode;
  final String? title;

  const TitleIconDarkTopBar({
    super.key,
    this.onBackPressed,
    this.actions,
    this.actionVisibilities,
    required this.themeMode,
    this.title,
  });

  @override
  material.Widget build(material.BuildContext context) {
    final isDarkMode = themeMode == material.ThemeMode.dark;
    final iconColor = isDarkMode ? AppColors.grey200 : AppColors.white;

    final defaultActions = [
      material.IconButton(
        icon: material.Icon(material.Icons.search, color: iconColor, size: 28),
        onPressed: () {},
        tooltip: 'Search',
      ),
    ];

    final effectiveActions = actions ?? defaultActions;
    final effectiveVisibilities =
        actionVisibilities ??
        List.generate(effectiveActions.length, (index) => true);

    return material.Column(
      children: [
        const DefaultTopBar(),
        material.Padding(
          padding: const material.EdgeInsets.symmetric(horizontal: 20),
          child: material.Container(
            child: material.Row(
              mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
              children: [
                material.Expanded(
                  child: material.Container(
                    child: material.Row(
                      children: [
                        material.IconButton(
                          icon: material.Icon(
                            material.Icons.arrow_back,
                            size: 28,
                            color: AppColors.white,
                          ),
                          onPressed:
                              onBackPressed ??
                              () => material.Navigator.pop(context),
                        ),
                        const material.SizedBox(width: 16),
                        material.Expanded(
                          child: material.Text(
                            title ?? 'title',
                            style: material.Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(
                              color: AppColors.white,
                              fontWeight: material.FontWeight.w700,
                            ),
                            textAlign: material.TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const material.SizedBox(width: 12),
                material.Container(
                  child: material.Row(
                    mainAxisAlignment: material.MainAxisAlignment.end,
                    children: [
                      material.Container(
                        width: 28,
                        height: 28,
                        child: material.Center(
                          child: material.Icon(
                            material.Icons.search,
                            size: 24,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const material.SizedBox(width: 20),
                      material.Container(
                        width: 28,
                        height: 28,
                        child: material.Center(
                          child: material.Icon(
                            material.Icons.favorite,
                            size: 24,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const material.SizedBox(width: 20),
                      material.Container(
                        width: 28,
                        height: 28,
                        child: material.Center(
                          child: material.Icon(
                            material.Icons.map,
                            size: 24,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      ...effectiveActions.asMap().entries.map((entry) {
                        final index = entry.key;
                        final action = entry.value;
                        final isVisible = effectiveVisibilities[index];
                        return isVisible
                            ? material.Padding(
                              padding: material.EdgeInsets.only(left: 20),
                              child: material.SizedBox(
                                width: 28,
                                height: 28,
                                child: action,
                              ),
                            )
                            : const material.SizedBox.shrink();
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

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
        const DefaultTopBar(),
        const material.SizedBox(height: 16),
        material.Container(
          margin: const material.EdgeInsets.symmetric(vertical: 12),
          padding: const material.EdgeInsets.symmetric(horizontal: 24),
          height: 48,
          color: AppColors.primary,
          child: material.Row(
            mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
            children: [
              material.Row(
                children: [
                  const material.Icon(
                    material.Icons.circle,
                    color: AppColors.white,
                    size: 32,
                  ),
                  const material.SizedBox(width: 16),
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
                  const material.SizedBox(width: 16),
                  material.Text(
                    title,
                    style: material.Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: AppColors.grey900),
                  ),
                ],
              ),
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
        const material.SizedBox(height: 16),
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
                              fontWeight: material.FontWeight.w600,
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
    final material.Color avatarBackgroundColor =
        themeMode == material.ThemeMode.light
            ? AppColors.grey400
            : AppColors.grey700;
    final material.Color titleColor =
        themeMode == material.ThemeMode.light
            ? AppColors.black
            : AppColors.white;
    final material.Color modeIconColor =
        themeMode == material.ThemeMode.light
            ? AppColors.grey900
            : AppColors.white;

    return material.Column(
      children: [
        const DefaultTopBar(),
        material.Container(
          margin: const material.EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: material.Row(
            mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
            children: [
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
              const material.SizedBox(width: 24),
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
              const material.SizedBox(width: 24),
              material.Container(
                width: 48,
                height: 48,
                alignment: material.Alignment.centerRight,
                child: material.IconButton(
                  icon: material.Icon(
                    themeMode == material.ThemeMode.light
                        ? material.Icons.nightlight_round
                        : material.Icons.wb_sunny,
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
