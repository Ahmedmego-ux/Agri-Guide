import 'package:agri_guide_app/feature/crop_recom/presentation/mange/cubit/crop_cubit.dart';
import 'package:agri_guide_app/feature/crop_recom/presentation/widget/crop_descrption.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CropRecoViewBody extends StatefulWidget {
  final double lat;
  final double lon;

  const CropRecoViewBody({
    super.key,
    required this.lat,
    required this.lon,
  });

  @override
  State<CropRecoViewBody> createState() => _CropRecoViewBodyState();
}

class _CropRecoViewBodyState extends State<CropRecoViewBody> {
  @override
  void initState() {
    super.initState();

    final currentState = context.read<CropCubit>().state;

    
    if (currentState is CropSuccess) {
      
      return;
    }

    context.read<CropCubit>().recommendCrop(
      lat: widget.lat,
      lon: widget.lon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(
          'cropRecommendation'.tr(),
          style: TextStyle(color: theme.colorScheme.onPrimary),
        ),
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
      ),
      body: BlocBuilder<CropCubit, CropState>(
        builder: (context, state) {
    
          if (state is CropLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: primary),
                  const SizedBox(height: 16),
                  Text('analyzingYourRegion'.tr()),
                ],
              ),
            );
          }
    
          if (state is CropFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: 64,
                        color: theme.colorScheme.error),
                    const SizedBox(height: 16),
                    Text(
                      state.errmessage,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<CropCubit>().recommendCrop(
                              lat: widget.lat,
                              lon: widget.lon,
                            );
                      },
                      icon: const Icon(Icons.refresh),
                      label: Text('tryAgain'.tr()),
                    ),
                  ],
                ),
              ),
            );
          }
    
          if (state is CropSuccess) {
            final crops = state.listCropEntity;
    
            return ListView.separated(
              itemCount: crops.length,
              separatorBuilder: (context, index) => SizedBox(height:0,),
              itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_)=>CropDescription(
                  title: crops[index].crop,
                   description: crops[index].description,
                   titleAr: crops[index].cropAr,
                   descriptionAr: crops[index].descriptionAr))),
                child: Padding(
                  padding: const EdgeInsets.all( 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              primary,
                              primary.withOpacity(0.75),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Text('🌱', style: TextStyle(fontSize: 56)),
                            const SizedBox(height: 12),
                            Text(
                            context.locale==Locale('en')? crops[index].crop:crops[index].cropAr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                           
                          ],
                        ),
                      ),
                                  
                    ],
                  ),
                ),
              );},
            );
          }
    
          return const SizedBox();
        },
      ),
    );
  }
}
