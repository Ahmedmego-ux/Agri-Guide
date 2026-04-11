import 'package:agri_guide_app/feature/crop_recom/domain/entity/crop_entity.dart';
import 'package:agri_guide_app/feature/crop_recom/presentation/widget/crop_item.dart';
import 'package:flutter/material.dart';

class CropRecoViewBody extends StatelessWidget {
   CropRecoViewBody({super.key});
  final List<CropEntity> crops = [
  CropEntity(
    title: "Wheat",
    description:
        "Wheat is one of the most important cereal crops in the world. It is mainly grown in temperate regions and requires moderate temperatures during its growing season. Wheat is used to produce flour for bread, pasta, and many other food products. Proper irrigation and soil management are essential for achieving high yields.",
  ),
  CropEntity(
    title: "Rice",
    description:
        "Rice is a staple food for more than half of the world's population. It is typically grown in flooded fields called paddies, which help control weeds and pests. Rice requires a warm and humid climate and a large amount of water throughout its growing period. It is rich in carbohydrates and provides a major source of energy.",
  ),
  CropEntity(
    title: "Maize",
    description:
        "Maize, also known as corn, is a versatile crop used for food, animal feed, and industrial products. It grows best in warm weather with adequate sunlight and well-drained soil. Maize is rich in vitamins and minerals and is widely used in many food products such as cornmeal, corn oil, and snacks.",
  ),
  CropEntity(
    title: "Cotton",
    description:
        "Cotton is a soft, fluffy fiber that grows in a boll around the seeds of the cotton plant. It requires a long frost-free period, plenty of sunshine, and moderate rainfall. Cotton is widely used in the textile industry to produce clothing and other fabric-based products. Proper pest control is crucial for maintaining crop quality.",
  ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Theme.of(context).colorScheme.primary,

        title: Text('Crop Recomendtion',
        style:TextStyle(
          color: Theme.of(context).colorScheme.onPrimary
        ) ,
        ),
      ),
body:SafeArea(
  child: Padding(
    padding: const EdgeInsets.all(12),
    child: ListView.builder(
      itemCount: crops.length,
      itemBuilder: (context,index){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: CropItem(title: crops[index].title, subtitle: crops[index].description),
      );
    })
    ),
  ),
) ;

    
  }
}