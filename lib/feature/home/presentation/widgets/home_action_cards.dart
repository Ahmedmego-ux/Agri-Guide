import 'package:agri_guide_app/core/constans/app_colors.dart';
import 'package:agri_guide_app/feature/chat_bot/presentation/view/chat_bot_view.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/widgets/image_picker_service.dart';
import 'package:agri_guide_app/feature/home/presentation/widgets/action_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeActionCards extends StatelessWidget {
  const HomeActionCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ActionCard(
                icon: Icons.camera_alt_outlined,
                title: 'scanPlant'.tr(),
                subtitle: 'analyzePlantHealth'.tr(),
                color: const Color(0xff2D6A4F),
                onTap: () =>
                    ImagePickerService(context).showPickerSheet(),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: ActionCard(
                icon: Icons.chat_bubble_outline,
                title: 'aiChat'.tr(),
                subtitle: 'askExpertAdvice'.tr(),
                color: const Color(0xff52B788),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatBotView(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}