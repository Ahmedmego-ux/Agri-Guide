import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('theme');

    if (savedTheme == 'dark') {
      emit(ThemeMode.dark);
    } else if (savedTheme == 'light') {
      emit(ThemeMode.light);
    } else {
      emit(ThemeMode.system);
    }
  }

  Future<void> themeToggle(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', isDark ? 'dark' : 'light');
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}