
import 'package:to_point/app_core/data/code/phone_mask.dart';
import 'package:to_point/app_core/phone_auth/model/country_model.dart';

class CountryCodeService {

  late List<dynamic> listViewCountriesDynamic = [];
  dynamic listPhoneMaskReverse = {};
  dynamic listPhoneMaskReverseCode = {};
  dynamic listCodeCountry = {};
  dynamic maskSeparatedCode = {};
  late List<CountryCodeModel> listViewCountries = [];
  String foundMask = "";
  String foundCountry = "";

  createLists() async {
    for(int i = 0; i < listViewCountriesDynamic.length; i++) {
      CountryCodeModel countryCodeModel = new CountryCodeModel(
        listViewCountriesDynamic[i]['name'],
        listViewCountriesDynamic[i]['dial_code'],
        listViewCountriesDynamic[i]['code']
      );
      listViewCountries.add(countryCodeModel);
    }
    PhoneMask.phoneMaskList.forEach((key, value) {
      String l, newString = "", code = "";
      for(int i=0; i<value.length; i++) {
        l = value.substring(i, i+1);
        if (l == "(" || l == ")" || l== "-") {
          newString = value.substring(0, i) + " " + value.substring(i+1, value.length); 
          value = newString;
        }
      }
      listPhoneMaskReverse[value] = key;
      code = value.substring(0, value.length).replaceAll(" ", ""); 
      code = code.substring(0, code.length).replaceAll("#", ""); 
      code = code.substring(0, code.length).replaceAll("(", ""); 
      code = code.substring(0, code.length).replaceAll(")", ""); 
      listPhoneMaskReverseCode[code] = key;
      dynamic outputObject = listViewCountriesDynamic.where((o) => o['code'] == key);
      for (final element in outputObject) {
        listCodeCountry[code] = element['name'];
      }
      maskSeparatedCode[code] = value.substring(code.length + 1, value.length);
      if (maskSeparatedCode[code].substring(0, 1) == " ") {
        maskSeparatedCode[code] = value.substring(code.length + 2, value.length);
      }
    });
  }

  findMask(typeCode) {
    String found = "";
    try {
      found = maskSeparatedCode['+' + typeCode];
      foundCountry = found;
      return found;
    } catch(e) {
      return "not found";
    }
  }

  findCountry(typeCode) {
    String found = "";
    foundMask = findMask(typeCode);
    if (foundMask != "not found") {
      try {
        found = listCodeCountry['+' + typeCode];
        foundCountry = found;
        return found;
      } catch(e) {
        return "not found";
      }
    } else return "not found";
  }

  findIndexByName(countryName) {
    int foundIndex = -1;
    for(int i=0; i<listViewCountries.length; i++) {
      if (countryName == listViewCountries[i].name) foundIndex = i;
    }
    return foundIndex;
  }
}