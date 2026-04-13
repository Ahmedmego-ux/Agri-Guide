import 'package:agri_guide_app/core/utils/theme/mange_theme/cubit/theme_cubit.dart';
import 'package:agri_guide_app/core/utils/theme/theme.dart';
import 'package:agri_guide_app/feature/chat_bot/data/chat_repo_impl.dart/chat_repo_impl.dart';

import 'package:agri_guide_app/feature/chat_bot/presentation/manger/message/chat_cubit.dart';
import 'package:agri_guide_app/feature/chat_bot/presentation/manger/session/session_cubit.dart';
import 'package:agri_guide_app/feature/diagonals_image/data/repo_impl/scan_impl.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/manger/history_scan/history_scan_cubit.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/manger/scan/scan_cubit.dart';
import 'package:agri_guide_app/feature/home/data/repos/weather_repo_impl.dart';

import 'package:agri_guide_app/feature/home/presentation/manger/cubit/weather_cubit.dart';
import 'package:agri_guide_app/splash_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl6bHZjd3Juc2pvY3RmdndjbXRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzIxOTY3NzIsImV4cCI6MjA4Nzc3Mjc3Mn0.IIkdRViqGRFf07sF2uYACmJLOYcneSg-MPEktHZCViQ',
    url: 'https://yzlvcwrnsjoctfvwcmtr.supabase.co',
  );
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatCubit(ChatRepoImpl())),
        BlocProvider(create: (context) => SessionCubit(ChatRepoImpl())),
         BlocProvider(create: (context) => WeatherCubit(WeatherRepoImpl())),
         BlocProvider(
          create: (context) => ScanCubit(ScanImpl()),
        ),
        BlocProvider(
          create: (context) => HistoryScanCubit(ScanImpl()),
        ),
          
      BlocProvider(
       create: (context) => ThemeCubit(),)
      ],
      
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp(
            locale: context.locale,
      //   locale: Locale('en'),
           supportedLocales: context.supportedLocales,
           localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: mode,
            home: const SplashView(),
          );
        },
      ),
     ); 
  }
}
