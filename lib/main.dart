import 'package:agri_guide_app/core/network/api_services.dart';
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
import 'package:agri_guide_app/feature/market/data/data_source/local_data_source.dart';
import 'package:agri_guide_app/feature/market/data/data_source/remot_data_source.dart';
import 'package:agri_guide_app/feature/market/data/repos_impl/product_impl.dart';
import 'package:agri_guide_app/feature/market/presentation/manger/cubit/product_cubit.dart';
import 'package:agri_guide_app/splash_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  await EasyLocalization.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  String? savedLang = prefs.getString('locale');
  if (savedLang == null) {
    final deviceLang =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    savedLang = ['en', 'ar'].contains(deviceLang) ? deviceLang : 'en';

    await prefs.setString('locale', savedLang);
  }
  final savedLocale = Locale(savedLang);

  final chatRepo = ChatRepoImpl();
  final scanImpl = ScanImpl();
  final apiServices = ApiServices(baseUrl: dotenv.env['API_BASE_URL']!);
  final productRepo = ProductImpl(
    networkDataSource: RemotDataSourceImpl(apiServices),
    localDataSource: ProductLocalDataSourceImpl(prefs),
    
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      startLocale: savedLocale,
      child: MyApp(
        prefs: prefs,
        chatRepo: chatRepo,
        scanImpl: scanImpl,
        productRepo: productRepo,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.prefs,
    required this.chatRepo,
    required this.scanImpl,
    required this.productRepo,
  });

  final SharedPreferences prefs;
  final ChatRepoImpl chatRepo;
  final ScanImpl scanImpl;
  final ProductImpl productRepo;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ChatCubit(chatRepo)),
        BlocProvider(create: (_) => SessionCubit(chatRepo)),
        BlocProvider(create: (_) => WeatherCubit(WeatherRepoImpl())),
        BlocProvider(create: (_) => ScanCubit(scanImpl)),
        BlocProvider(create: (_) => HistoryScanCubit(scanImpl)),
        BlocProvider(
          create: (_) => ProductCubit(productRepo)..getProducts(),
        ),
        BlocProvider(create: (_) => ThemeCubit()..loadTheme()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp(
            locale: context.locale,
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