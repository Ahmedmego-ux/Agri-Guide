import 'package:agri_guide_app/feature/market/domain/entity/product_entity.dart';
import 'package:agri_guide_app/feature/market/presentation/widgets/open_whatsapp.dart';
import 'package:agri_guide_app/feature/market/presentation/widgets/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

   ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetails(product: product,)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(product.image,
               height: 130,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
             
               
             
            ),

            const SizedBox(height: 8),

            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 4),

           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "price: ${product.price} EG",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Spacer(),

            
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: ()async {
               await openWhatsApp();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(" Order Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}