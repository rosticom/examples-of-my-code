
import 'dart:async';
import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:to_point/app_core/data/code/country.dart';
import 'package:to_point/app_core/phone_auth/bloc/phone_auth_bloc.dart';
import 'package:to_point/app_core/phone_auth/service/country_code.dart';
import 'package:to_point/app_core/phone_auth/widget/button/confirm_button.dart';
import 'package:to_point/app_core/phone_auth/widget/button/country_button.dart';
import 'package:to_point/app_core/phone_auth/widget/text-field/country_phone_text.dart';
import 'package:to_point/app_core/phone_auth/widget/text-field/phone_number_text.dart';
import 'package:to_point/service/storage/settings.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ScreenBody extends StatefulWidget {

  @override
  _ScreenBodyState createState() => _ScreenBodyState();
}

class _ScreenBodyState extends State<ScreenBody> {
  CountryCodeService countryCodeController = CountryCodeService();
  late PhoneAuthBloc phoneAuthBloc;
  late String chooseCountryCaption;
  late bool vibrateEnabled;
  bool _newButtonMode = true;
  late StreamSubscription<bool> keyboardSubscription;
  bool animateButtonKeyboard = false;
  double _animateButtonFactor = 0;

  @override
  void initState() {
    super.initState();
      countryCodeController.listViewCountriesDynamic = CountryCode.countryCode;
      countryCodeController.createLists();
      vibrateEnabled = false;
      chooseCountryCaption = "";
      _buttonAnimation();
  }

  void dispose() {
    super.dispose();
    keyboardSubscription.cancel();
  }

  void _newButtonShow(bool? updateState) {
    setState(() {
      _newButtonMode = updateState ?? true;
    });
  }

  void _buttonAnimation() async {
    if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
        var keyboardVisibilityController = KeyboardVisibilityController();
        keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) async {
          if (visible == true) {
            _animateButtonFactor = 0;
             animateButtonKeyboard = false;
             if (mounted) { setState(() { _newButtonShow(false); }); }
             await new Future.delayed(const Duration(milliseconds : 75));
             animateButtonKeyboard = true;
             if (mounted) { setState(() { _newButtonShow(true); }); }
          } else {
            _animateButtonFactor = 410;
            animateButtonKeyboard = false;
             if (mounted) { setState(() { _newButtonShow(false); }); }
             await new Future.delayed(const Duration(milliseconds : 16));
             animateButtonKeyboard = true;
             if (mounted) { setState(() { _newButtonShow(true); }); }
          }
        });
      }  
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthBloc, PhoneAuthBlocState>(
      listener: (context, state) {
        _mapStates(state);
      }, builder: (_, state) {
       return Stack(
        children: [
            Positioned(
              bottom: 14,
              right: 14,
              child: AnimatedContainer(
                curve: Curves.decelerate,
                duration: Duration(milliseconds: animateButtonKeyboard ? 320 : 0),
                transform: Matrix4.translationValues(0, _newButtonMode ? 0 : 200 - _animateButtonFactor, 0),
                  child: ClipRRect(
                    child: Container(
                      child: ConfirmationButtonWidget(
                        BlocProvider.of<PhoneAuthBloc>(context, listen: false).phoneCountry, 
                        BlocProvider.of<PhoneAuthBloc>(context, listen: false).phoneTypeValue,
                  ),
                    padding: EdgeInsets.all(5),
                  ))
          )),
          Column(
            children: [
              SizedBox(height: 22),
              Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                margin: EdgeInsets.all(0),
                child: CountryButtonWidget(context, countryCodeController, chooseCountryCaption)
              ),
              SizedBox(height: 20),
              Row(children: [
                CountryPhoneText(countryCodeController),
                SizedBox(width: 16),
                ShakeAnimatedWidget(
                  enabled: vibrateEnabled,
                  duration: Duration(milliseconds: 200),
                  shakeAngle: Rotation.deg(y: 15),
                  curve: Curves.linear,
                  child: PhoneNumberText(countryCodeController),
                ),
              ]),
              SizedBox(height: 15.5),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                    "check_country_code".tr,
                  style: TextStyle(
                    color: Colors.grey[600] 
                  ),
              ))
            ],
          )
        ] 
    ); 
  }); }

  _mapStates(PhoneAuthBlocState state) async {

    if (state is CountryPickState) {
        chooseCountryCaption = state.value;
        BlocProvider.of<PhoneAuthBloc>(context, listen: false).phoneCountry = state.value;
    }

    if (state is NavigatorLocaleState) {
        await Get.updateLocale(state.value);
        SettingsGet().language = state.value.languageCode;
        chooseCountryCaption = "choose_country".tr;
        setState(() {});
    }

    if (state is VibrateDigitsState) {
        if (await Vibration.hasCustomVibrationsSupport() ?? false) {
          Vibration.vibrate(duration: 205);
        } else {
            Vibration.vibrate();
            await Future.delayed(Duration(milliseconds: 205));
        }
        setState(() {
          vibrateEnabled = true;
        });
        await Future.delayed(Duration(milliseconds: 300));
        setState(() {
          vibrateEnabled = false;
        });
        BlocProvider.of<PhoneAuthBloc>(context, listen: false)
          .add(CountryPickEvent(
            BlocProvider.of<PhoneAuthBloc>(context, listen: false).phoneCountry)
          );
    }

    if (state is CountryTypeState) {
      if (BlocProvider.of<PhoneAuthBloc>(context, listen: false).phoneCountry.length == 0
        && BlocProvider.of<PhoneAuthBloc>(context, listen: false).countryTypeValue.length != 0) {
        chooseCountryCaption = "invalid_country_code".tr;
      } else {
        chooseCountryCaption = "choose_country".tr;
      }
    }
  }
}