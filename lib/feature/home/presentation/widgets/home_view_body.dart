import 'package:agri_guide_app/core/constans/app_colors.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/chat_bot/presentation/view/chat_bot_view.dart';
import 'package:agri_guide_app/feature/crop_recom/presentation/view/crop_reco_view.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/manger/history_scan/history_scan_cubit.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/view/history_screan.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/widgets/history_item_card.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/widgets/image_picker_service.dart';
import 'package:agri_guide_app/feature/home/presentation/widgets/home_action_cards.dart';
import 'package:agri_guide_app/feature/home/presentation/widgets/home_header.dart';
import 'package:agri_guide_app/feature/home/presentation/widgets/weather_widget.dart';
import 'package:agri_guide_app/feature/market/presentation/view/market_view.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';
import 'package:agri_guide_app/feature/settings/presentation/view/settings_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key, required this.loginEntity});

  final LoginEntity loginEntity;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HistoryScanCubit>().getHistory();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: HomeHeader(
                  loginEntity: widget.loginEntity,
                ),
              ),

              const SizedBox(height: 16),

              // Weather
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: WeatherWidget(
                  latitude: widget.loginEntity.latitude,
                  longitude: widget.loginEntity.longitude,
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'quickActions'.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),

              const SizedBox(height: 12),

              // 🌿 Market Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MarketView(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.storefront,
                          color: Colors.white,
                          size: 30,
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'agriMarket'.tr(),
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                'buySeedsToolsFertilizers'.tr(),
                                style: theme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: HomeActionCards(),
              ),

              const SizedBox(height: 12),

              // Recent Scans
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeRecentScans(),
                    SizedBox(height: 28),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => _currentIndex = 2);
          ImagePickerService(context).showPickerSheet();
        },
        backgroundColor: maincolor,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.camera_alt,
          size: 28,
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      // Bottom Navigation
      bottomNavigationBar: BottomAppBar(
        height: 75,
        color: theme.bottomNavigationBarTheme.backgroundColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        elevation: 12,
        shadowColor: Colors.black26,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,
          children: [
            // 🏠 Home
            _buildNavItem(
              '🏠',
              'home'.tr(),
              0,
              () {
                setState(() => _currentIndex = 0);
              },
            ),

            // 💬 Chat
            _buildNavItem(
              '💬',
              'chat'.tr(),
              1,
              () async {
                setState(() => _currentIndex = 1);

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ChatBotView(),
                  ),
                );

                setState(() => _currentIndex = 0);
              },
            ),

            // FAB Space
            const SizedBox(width: 50),

            // 🌿 Crops
            _buildNavItem(
              '🌿',
              'crops'.tr(),
              3,
              () async {
                setState(() => _currentIndex = 3);

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CropRecoView(),
                  ),
                );

                setState(() => _currentIndex = 0);
              },
            ),

            // ⚙️ Settings
            _buildNavItem(
              '⚙️',
              'settings'.tr(),
              4,
              () async {
                setState(() => _currentIndex = 4);

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value:
                          context.read<ProfileCubit>(),
                      child: SettingsView(),
                    ),
                  ),
                );

                setState(() => _currentIndex = 0);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    String emoji,
    String label,
    int index,
    VoidCallback onPressed,
  ) {
    final theme = Theme.of(context);

    final isSelected = _currentIndex == index;

    final color = isSelected
        ? maincolor
        : theme
            .bottomNavigationBarTheme.unselectedItemColor;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 55,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: const TextStyle(
                fontSize: 20,
                height: 1.0,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected
                    ? FontWeight.w700
                    : FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────

class HomeRecentScans extends StatelessWidget {
  const HomeRecentScans({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'recentScans'.tr(),
                style: theme.textTheme.titleMedium
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HistoryScreen(),
                  ),
                ),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    'seeAll'.tr(),
                    style: theme.textTheme.titleSmall
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                      color:
                          theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        BlocBuilder<HistoryScanCubit,
            HistoryScanState>(
          builder: (context, state) {
            if (state is HistoryScanLoading) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: CircularProgressIndicator(
                    color:
                        theme.colorScheme.primary,
                    strokeWidth: 2.5,
                  ),
                ),
              );
            }

            if (state is HistoryScanSuccess) {
              final recent =
                  state.data.take(3).toList();

              if (recent.isEmpty) {
                return Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 32,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.image_search_rounded,
                          size: 48,
                          color: theme
                              .colorScheme.primary
                              .withOpacity(0.4),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          'noScansYet'.tr(),
                          style: theme
                              .textTheme.bodyMedium
                              ?.copyWith(
                            color: theme
                                .colorScheme.onSurface
                                .withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemCount: recent.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) =>
                    HistoryItemCard(
                  item: recent[index],
                ),
              );
            }

            if (state is HistoryScanFailure) {
              return Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 24,
                  ),
                  child: Text(
                    state.errmessage,
                    style: TextStyle(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}