import 'package:agri_guide_app/feature/diagonals_image/domain/entity/scan_entity.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/view/ai_result.dart';

import 'package:flutter/material.dart';

class HistoryItemCard extends StatelessWidget {
  const HistoryItemCard({
    super.key,
    required this.item,
 
  });

  final ScanEntity item;
  
 

  @override
  Widget build(BuildContext context) {
   final cs =Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AIResultScreen(imagePath: item.imageUrl, isNetwork: true,),
            ),
          );
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
              child: Image.network(
                item.imageUrl,
                width: 100,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: cs.surfaceContainerHighest,
                    child: Icon(
                      Icons.broken_image,
                      color: cs.onSurfaceVariant,
                    ),
                  );
                },
              ),
            ),
    
            const SizedBox(width: 12),
    
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.result,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    
                  ],
                ),
              ),
            ),
    
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: cs.onSurfaceVariant,
            ),
    
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}