import 'package:agri_guide_app/feature/market/domain/entity/product_entity.dart';
import 'package:agri_guide_app/feature/market/presentation/widgets/open_whatsapp.dart';
import 'package:agri_guide_app/feature/market/presentation/widgets/order_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetails(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  Image.network(
                    product.image,
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 130,
                      color: cs.primaryContainer,
                      child: Icon(
                        Icons.image_outlined,
                        size: 40,
                        color: cs.primary.withOpacity(0.4),
                      ),
                    ),
                  ),
                  // Price badge on image
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: cs.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${product.price} EG',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: cs.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                product.title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const Spacer(),

            // Order button
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
              child: ElevatedButton.icon(
                onPressed: () async {
                  await openWhatsApp();
                },
                icon: const Icon(Icons.shopping_cart_outlined, size: 16),
                label:  Text('orderNow'.tr()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: cs.primary,
                  foregroundColor: cs.onPrimary,
                  minimumSize: const Size(double.infinity, 38),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}