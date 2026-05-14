import 'package:agri_guide_app/feature/diagonals_image/domain/entity/scan_entity.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/view/ai_result.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HistoryItemCard extends StatelessWidget {
  const HistoryItemCard({
    super.key,
    required this.item,
  });

  final ScanEntity item;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isAr = context.locale.languageCode != 'en';

    final subtitle = isAr ? item.causeAr : item.cause;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AIResultScreen(
                imagePath: item.imageUrl,
                isNetwork: true,
                historyEntity: item,
              ),
            ),
          );
        },
        child: Row(
          children: [
            /// IMAGE
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  item.imageUrl,
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.eco_outlined,
                    color: cs.primary,
                    size: 32,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 14),

            /// CONTENT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// اسم المرض
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.predictedClass,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: cs.onSurface,
                          ),
                        ),
                      ),
                      /// HEALTHY BADGE
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: (item.isHealthy ? Colors.green : Colors.red)
                              .withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item.isHealthy ? 'healthy'.tr() : 'diseased'.tr(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: item.isHealthy ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  /// السبب
                  Text(
                    subtitle.isNotEmpty ? subtitle : 'noData'.tr(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: cs.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// التاريخ
                  Text(
                    DateFormat('dd MMM yyyy').format(item.date),
                    style: TextStyle(
                      fontSize: 10,
                      color: cs.onSurfaceVariant.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),

            /// ARROW
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: cs.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}