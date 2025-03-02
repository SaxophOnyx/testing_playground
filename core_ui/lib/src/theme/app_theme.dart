import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core_ui.dart';

final class AppTheme {
  const AppTheme._();

  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.redM3,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      defaultRadius: 8.0,
      fabUseShape: true,
      fabAlwaysCircular: true,
      alignedDropdown: true,
      appBarBackgroundSchemeColor: SchemeColor.primary,
      appBarCenterTitle: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    fontFamily: AppFonts.montserrat.fontFamily,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );

  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.redM3,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      defaultRadius: 8.0,
      fabUseShape: true,
      fabAlwaysCircular: true,
      alignedDropdown: true,
      appBarCenterTitle: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    fontFamily: AppFonts.montserrat.fontFamily,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}
