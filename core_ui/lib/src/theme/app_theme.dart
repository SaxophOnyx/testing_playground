import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core_ui.dart';

final class AppTheme {
  const AppTheme._();

  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.green,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      fabUseShape: true,
      fabAlwaysCircular: true,
      cardRadius: 4.0,
      alignedDropdown: true,
      appBarCenterTitle: true,
      bottomSheetRadius: 4.0,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
      buttonMinSize: Size(0, 48),
      filledButtonRadius: 4,
    ),
    fontFamily: AppFonts.montserrat.fontFamily,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );

  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.green,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      fabUseShape: true,
      fabAlwaysCircular: true,
      cardRadius: 4.0,
      alignedDropdown: true,
      appBarCenterTitle: true,
      bottomSheetRadius: 4.0,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
      buttonMinSize: Size(0, 48),
      filledButtonRadius: 4,
    ),
    fontFamily: AppFonts.montserrat.fontFamily,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}
