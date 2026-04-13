import 'package:agri_guide_app/core/constans/app_colors.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/chat_bot/presentation/view/chat_bot_view.dart';
import 'package:agri_guide_app/feature/crop_recom/presentation/view/crop_reco_view.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/manger/history_scan/history_scan_cubit.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/view/history_screan.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/widgets/history_item_card.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/widgets/image_picker_service.dart';

import 'package:agri_guide_app/feature/home/presentation/widgets/action_card.dart';
import 'package:agri_guide_app/feature/home/presentation/widgets/home_header.dart';

import 'package:agri_guide_app/feature/home/presentation/widgets/weather_widget.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';
import 'package:agri_guide_app/feature/settings/presentation/view/settings_view.dart';
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
    // TODO: implement initState
    super.initState();
     context.read<HistoryScanCubit>().getHistory();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCameraSelected = _currentIndex == 2;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              HomeHeader(loginEntity: widget.loginEntity),

              const SizedBox(height: 16),
                WeatherWidget(latitude: widget.loginEntity.latitude, longitude: widget.loginEntity.longitude,), 
              const SizedBox(height: 24),
              const HomeActionCards(),
              const SizedBox(height: 28),
              const HomeRecentScans(),
              const SizedBox(height: 28),
           
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {setState(() => _currentIndex = 2),
        ImagePickerService(context).showPickerSheet()
        },
        backgroundColor: isCameraSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.surfaceContainerHighest,
        foregroundColor: isCameraSelected
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.onSurfaceVariant,
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 90,
        color: theme.bottomNavigationBarTheme.backgroundColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Home', 0, () {
              setState(() => _currentIndex = 0);
            }),
            _buildNavItem(Icons.chat, 'Chat', 1, () async {
              setState(() => _currentIndex = 1);
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatBotView()),
              );
              setState(() => _currentIndex = 0);
            }),
            const SizedBox(width: 50),
            _buildNavItem(Icons.eco, 'Crops', 3, () async {
              setState(() => _currentIndex = 3);
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
               // HistoryScreen() 
                 CropRecoView()
                ),
              );
              setState(() => _currentIndex = 0);
            }),
            _buildNavItem(Icons.settings, 'Settings', 4, () async {
              setState(() => _currentIndex = 4);
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<ProfileCubit>(),
                    child: SettingsView(),
                  ),
                ),
              );
              setState(() => _currentIndex = 0);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, VoidCallback onPressed) {
    final theme = Theme.of(context);
    final isSelected = _currentIndex == index;
    final color = isSelected
        ? theme.colorScheme.primary
        : theme.bottomNavigationBarTheme.unselectedItemColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: color, size: 26),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: color),
        ),
      ],
    );
  }
}

class HomeActionCards extends StatelessWidget {
  const HomeActionCards({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: ActionCard(
            icon: Icons.camera_alt_outlined,
            title: 'Scan Plant',
            subtitle: 'Analyze plant health',
            color: maincolor,
            onTap:() =>ImagePickerService(context).showPickerSheet()
            
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ActionCard(
            icon: Icons.chat_bubble_outline,
            title: 'AI Chat',
            subtitle: 'Ask expert advice',
            color: const Color.fromARGB(255, 3, 33, 121),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatBotView()),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeRecentScans extends StatelessWidget {
  const HomeRecentScans({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Scans',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_)=>HistoryScreen())),
                child: Text(
                  'see all',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        BlocBuilder<HistoryScanCubit, HistoryScanState>(
          builder: (context, state) {
            if (state is HistoryScanLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HistoryScanSuccess) {
              final recent = state.data.take(3).toList();

              if (recent.isEmpty) {
                return const Center(child: Text('No scans yet'));
              }

              return ListView.separated(
                shrinkWrap: true,                              
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recent.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) => HistoryItemCard(
                  item: recent[index],
                 
                ),
              );
            }

            if (state is HistoryScanFailure) {
              return Center(child: Text(state.errmessage));
            }

            return const SizedBox.shrink();
          },
        ),
    
    
 
      ],
    );
  }
}

