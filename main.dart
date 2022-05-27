
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topointme/core/common/unknown_route_page.dart';
import 'package:topointme/core/language/language_tr.dart';
import 'package:topointme/core/service/storage/settings.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as getXTransition;
import 'package:topointme/home.dart';
import 'package:topointme/theme/theme_cubit.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init();
    await SettingsGet().init();
    ThemeCubit.themeIsDark = await SettingsGet().themeIsDark;
    runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var locale = Language().language(SettingsGet().language)!;
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) {
          ThemeCubit.themeIsDark ? ThemeCubit.setSystemOverlayDark() : ThemeCubit.setSystemOverlayLight();
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeCubit.themeIsDark ? ThemeCubit.darkTheme : ThemeCubit.lightTheme,
            defaultTransition: getXTransition.Transition.rightToLeftWithFade,
            transitionDuration: Duration(milliseconds: 250),
            locale: locale,
            translations: Language(),
            fallbackLocale: Locale('en', 'US'), 
            unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoutePage()),
            initialRoute: '/',
            getPages: [
              GetPage(name: '/', page: () => HomePage())
            ],);
    }));
  }
}