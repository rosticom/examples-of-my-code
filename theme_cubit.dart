
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:topointme/core/colors.dart';
import 'package:topointme/core/service/storage/settings.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightTheme);

  static bool themeIsDark = false;
  
  static final lightTheme = ThemeData(
    bannerTheme: MaterialBannerThemeData(backgroundColor: Colors.white70),
    inputDecorationTheme: InputDecorationTheme(
       enabledBorder: UnderlineInputBorder(      
          borderSide: BorderSide(
            width: 1.0,
            color: AppColors.underlineInputBorderEnabledLight, 
          ),   
       ),  
       focusedBorder: UnderlineInputBorder(      
          borderSide: BorderSide(
            width: 2.0,
            color: AppColors.underlineColor, 
          ),   
       ) 
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.systemNavigationBarLight
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.popUpMenuLight,
      enableFeedback: true,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
    ),
    highlightColor: Colors.transparent,
    splashColor: Colors.grey.withOpacity(0.15),
    hoverColor: Colors.grey.withOpacity(0.15),
    splashFactory: InkRipple.splashFactory,
    primaryColor: AppColors.drawerBackgroundLight,
    secondaryHeaderColor: AppColors.secondaryHeaderLight,
    backgroundColor: Colors.white,
    bottomAppBarColor: Colors.green[900],
    textTheme: TextTheme(
      headline1: TextStyle(color: AppColors.drawerTextLight, fontSize: 18),
      headline2: TextStyle(color: AppColors.titleTextLight),
      headline3: TextStyle(color: AppColors.textColorLightNew),
      headline4: TextStyle(color: AppColors.headerColorLight),
      headline5: TextStyle(color: AppColors.subTitleAppBarLight),
      headline6: TextStyle(color: Colors.black),
      caption: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: AppColors.subTitleDescriptionLight),
      subtitle2: TextStyle(color: AppColors.emojiSmileLight),
      button: TextStyle(color: AppColors.unselectedTabText.withOpacity(0.99)),
      overline: TextStyle(color: Colors.white),
      bodyText1: TextStyle(color: AppColors.telegramTextLight)
    ),
    iconTheme: IconThemeData(color: AppColors.drawerTextLight),
    appBarTheme: AppBarTheme(
     elevation: 1,
     titleSpacing: 2,
     backgroundColor: Colors.green,
     actionsIconTheme: IconThemeData(color: AppColors.secondaryBackground),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
    brightness: Brightness.light,
    canvasColor: AppColors.chipBackgroundLight,
    dividerColor: AppColors.dividerNewsLight,
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.primaryBackgroundLight,
      unselectedLabelColor: AppColors.secondaryBackground
    ),
    primaryTextTheme: TextTheme(
      overline: TextStyle(color: AppColors.cursorLight)
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.cursorLightNew),
    dividerTheme: DividerThemeData(color: Colors.grey[400]?.withOpacity(0.62))
  );

  static final darkTheme = ThemeData(
    bannerTheme: MaterialBannerThemeData(backgroundColor: AppColors.dashBoardTelegram),
    inputDecorationTheme: InputDecorationTheme(
       enabledBorder: UnderlineInputBorder(      
          borderSide: BorderSide(
            width: 1.0,
            color: AppColors.underlineInputBorderEnabledDark, 
          ),   
       ),  
       focusedBorder: UnderlineInputBorder(      
          borderSide: BorderSide(
            width: 2.0,
            color: AppColors.underlineColor, 
          ),   
       ) 
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.systemNavigationBarDark
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.popUpMenuDark,
      enableFeedback: true,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
    ),
    highlightColor: Colors.transparent,
    splashColor: Colors.grey.withOpacity(0.15),
    hoverColor: Colors.grey.withOpacity(0.15),
    splashFactory: InkRipple.splashFactory,
    primaryColor: AppColors.appBarTitleDark,
    secondaryHeaderColor: AppColors.secondaryHeaderDark,
    appBarTheme: AppBarTheme(
     elevation: 1,
     titleSpacing: 2,
     backgroundColor: Colors.green[700],
     actionsIconTheme: IconThemeData(color: AppColors.hintText),
    ),
    backgroundColor: AppColors.primaryBackgroundDark,
    bottomAppBarColor: Colors.green[100],
    textTheme: TextTheme(
      headline1: TextStyle(color: AppColors.drawerTextDark, fontSize: 18),
      headline2: TextStyle(color: AppColors.titleTextDark),
      headline3: TextStyle(color: AppColors.textColorDarkNew),
      headline4: TextStyle(color: AppColors.headerColorDark),
      headline5: TextStyle(color: AppColors.subTitleDescriptionDark),
      headline6: TextStyle(color: Colors.white),
      caption: TextStyle(color: Colors.black),
      subtitle1: TextStyle(color: AppColors.subTitleDescriptionDark),
      subtitle2: TextStyle(color: AppColors.emojiSmileDark),
      button: TextStyle(color: AppColors.titleTextDark.withOpacity(0.99)),
      overline: TextStyle(color: AppColors.drawerTextLight),
      bodyText1: TextStyle(color: AppColors.underlineColor)
    ),
    iconTheme: IconThemeData(color: AppColors.drawerMenuIcon),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black
    ),
    brightness: Brightness.dark,
    canvasColor: AppColors.chipBackgroundDark,
    dividerColor: AppColors.dividerNewsDark,
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.tabTextLight,
      unselectedLabelColor: AppColors.unselectedTabText
    ),
    primaryTextTheme: TextTheme(
      overline: TextStyle(color: AppColors.cursorDark)
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.cursorDarkNew),
    dividerTheme: DividerThemeData(color: Colors.black87.withOpacity(0.62)),
  );

  void toggleTheme() {
    emit(
      themeIsDark 
      ? lightTheme
      : darkTheme
    );
    state.brightness == Brightness.dark
    ? { SettingsGet().themeIsDark = true, themeIsDark = true }
    : { SettingsGet().themeIsDark = false, themeIsDark = false };
    statusBarBrightness();
  }

  void getThemeMode() async {
    !themeIsDark
    ? Get.changeTheme(ThemeData.light())
    : Get.changeTheme(ThemeData.dark());
    statusBarBrightness();
  }

  static statusBarBrightness() {
       themeIsDark
        ? setSystemOverlayDark()
        :
        setSystemOverlayLight(); 
  }

  static setSystemOverlayDark() {
     SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.systemNavigationBarDark,
            statusBarColor: AppColors.statusBarDark,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light
        )); 
  }

  static setSystemOverlayLight() {
     SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.systemNavigationBarLight,
            statusBarColor: AppColors.statusBarLight,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light
        )); 
  }
}