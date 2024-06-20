import 'package:flutter/material.dart';

/// The recommended padding around page content in Yaru applications.
const kPagePadding = 20.0;

/// The default height of [YaruTitleBar].
const kTitleBarHeight = 46.0;

/// The default border radius for Yaru-style banners.
const kBannerRadius = 10.0;

/// The default border radius for Yaru-style containers.
const kContainerRadius = 8.0;

/// The default border radius for Yaru-style buttons.
const kButtonRadius = 6.0;

/// The default breakpoint width [YaruMasterDetailPage] uses for switching
/// between portrait and landscape modes.
const kMasterDetailBreakpoint = 620.0;

/// The best height for any item inside a [YaruTitleBar]
const kTitleBarItemHeight = 34.0;

/// The default icon size
const kIconSize = 20.0;

const kTargetCanvasSize = 24.0;
const kTargetIconSize = 20.0;

const kLandscapeLayoutPageTransitionsTheme = PageTransitionsTheme(
  builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
    TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
  },
);

const kPortraitLayoutPageTransitionsTheme = PageTransitionsTheme(
  builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
    TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
  },
);

const kDetailPageTransitionsTheme = PageTransitionsTheme(
  builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
    TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
  },
);
