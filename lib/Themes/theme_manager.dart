import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier  {

  ThemeManager(){
    selectedThemeData();
  }

  Future<SharedPreferences> pref = SharedPreferences.getInstance();

  String selectedTheme = '';

  void changeTheme(String theme) async {
  final SharedPreferences pref2 = await pref;
  pref2.setString("SelectedTheme", theme);
  selectedTheme =  pref2.getString("SelectedTheme").toString();
  notifyListeners();
  }

  Future<String> selectedThemeData()async{
   final SharedPreferences pref2 = await pref;
 // pref2.setString("SelectedTheme", 'merron');
  selectedTheme =  pref2.getString("SelectedTheme").toString();
  if(selectedTheme == 'yellow'){
    selectedTheme =  pref2.getString("SelectedTheme").toString();
    notifyListeners();
    return selectedTheme;

  }else if(selectedTheme == 'blue'){
    selectedTheme =  pref2.getString("SelectedTheme").toString();
    notifyListeners();
    return selectedTheme;

  }else if(selectedTheme == 'red'){
    selectedTheme =  pref2.getString("SelectedTheme").toString();
    notifyListeners();
    return selectedTheme;

  }else if (selectedTheme == 'green'){
    selectedTheme =  pref2.getString("SelectedTheme").toString();
    notifyListeners();
    return selectedTheme;
  } 
  else {
    pref2.setString("SelectedTheme", 'rose');
    selectedTheme =  pref2.getString("SelectedTheme").toString();
    notifyListeners();
    return selectedTheme;
  } 
  }

  String get isselectedTheme =>  selectedTheme;

}
