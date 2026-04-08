import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';



class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);
  void themeToggle(bool isDark){
    emit(isDark?ThemeMode.dark:ThemeMode.light);
  }
 
}
