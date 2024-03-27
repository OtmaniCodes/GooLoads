import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logger.dart';

class AppPrefrences {
  late SharedPreferences prefs;

  checkIfFirstLaunch() async {
  prefs = await SharedPreferences.getInstance();
    bool retVal;
    if (prefs.getBool(KFirstLaunchKey) == null) {
      DevLogger.log( "the app is running for the very first time".toUpperCase(), name: 'checkIfFirstLaunch');
      
      retVal = true;
      prefs.setBool(KFirstLaunchKey, true);
    } else {
      DevLogger.log( "the app has already launched before".toUpperCase(), name: 'checkIfFirstLaunch');
          retVal = false;
    }
    return retVal;
  }

// for the app theme

  getSavedThemeId() async {
    prefs = await SharedPreferences.getInstance();
    // 0 for light  
    // 1 for dark
    int retVal;
    if (prefs.getInt(KThemeIDKey) == null) {
      retVal = 0;
    } else {
      retVal = prefs.getInt(KThemeIDKey)!;
    }
    return retVal;
  }

  saveThemeId(int id) async {
    prefs = await SharedPreferences.getInstance();
    try {
      prefs.setInt(KThemeIDKey, id);
    } catch (error) {
      print(error);
    }
  }
}
