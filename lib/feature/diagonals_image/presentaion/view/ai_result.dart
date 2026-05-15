import 'dart:io';
import 'package:agri_guide_app/feature/diagonals_image/domain/entity/scan_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agri_guide_app/feature/diagonals_image/presentaion/manger/scan/scan_cubit.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/manger/history_scan/history_scan_cubit.dart';

class AIResultScreen extends StatefulWidget {
  final String imagePath;
  final bool isNetwork;
  final ScanEntity? historyEntity;

  const AIResultScreen({
    super.key,
    required this.imagePath,
    required this.isNetwork,
    this.historyEntity,
  });

  @override
  State<AIResultScreen> createState() => _AIResultScreenState();
}

class _AIResultScreenState extends State<AIResultScreen> {
  bool _saved = false;

  @override
  void initState() {
    super.initState();

    if (!widget.isNetwork) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _saveScan();
      });
    }
  }

  void _saveScan() {
    if (_saved) return;
    _saved = true;

    context.read<ScanCubit>().saveScan(
          file: File(widget.imagePath),
        );
  }

  Color _confidenceColor(double c) {
    if (c > 0.75) return Colors.green;
    if (c > 0.4) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('aiPlantScanner'.tr()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<ScanCubit, ScanState>(
          listener: (context, state) {
            if (state is ScanSuccess) {
              context.read<HistoryScanCubit>().refreshHistory();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('scanSuccess'.tr())),
              );
            }

            if (state is ScanFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final entity = widget.historyEntity ??
                (state is ScanSuccess ? state.entity : null);

            return Column(
              children: [
                /// IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: widget.isNetwork
                      ? Image.network(
                          widget.imagePath,
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(widget.imagePath),
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),

                const SizedBox(height: 20),

                /// RESULT
                Expanded(
                  child: Builder(
                    builder: (_) {
                      if (entity == null && state is ScanLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (entity == null && state is ScanFailure) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      if (entity != null) {
                        final isAr = context.locale.languageCode != 'en';

                        final disease    = entity.diseaseName;
                        final diseaseAr =entity.diseaseNameAr;
                        final confidence = entity.confidence;
                        final cause      = isAr ? entity.causeAr      : entity.cause;
                        final symptoms   = isAr ? entity.symptomsAr   : entity.symptoms;
                        final treatment  = isAr ? entity.treatmentAr  : entity.treatment;
                        final prevention = isAr ? entity.preventionAr : entity.prevention;

                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// TITLE + HEALTHY BADGE
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: (entity.isHealthy
                                          ? Colors.green
                                          : Colors.red)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                      context.locale==Locale('en')?  disease:diseaseAr,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: entity.isHealthy
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                    Chip(
                                      label: Text(
                                        entity.isHealthy
                                            ? 'healthy'.tr()
                                            : 'diseased'.tr(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      backgroundColor: entity.isHealthy
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 12),

                              /// CONFIDENCE
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _confidenceColor(confidence)
                                      .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${'confidence'.tr()}: ${(confidence * 100).toStringAsFixed(1)}%',
                                  style: TextStyle(
                                    color: _confidenceColor(confidence),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              /// SECTIONS
                              if (!entity.isHealthy) ...[
                                _InfoSection(
                                  title: 'cause'.tr(),
                                  body: cause,
                                  icon: Icons.bug_report_outlined,
                                ),
                                _InfoSection(
                                  title: 'symptoms'.tr(),
                                  body: symptoms,
                                  icon: Icons.sick_outlined,
                                ),
                                _InfoSection(
                                  title: 'treatment'.tr(),
                                  body: treatment,
                                  icon: Icons.medical_services_outlined,
                                ),
                                _InfoSection(
                                  title: 'prevention'.tr(),
                                  body: prevention,
                                  icon: Icons.shield_outlined,
                                ),
                              ] else
                                _InfoSection(
                                  title: 'plantIsHealthy'.tr(),
                                  body: 'noIssuesDetected'.tr(),
                                  icon: Icons.check_circle_outline,
                                ),
                            ],
                          ),
                        );
                      }

                      return Center(
                        child: Text('waitingResult'.tr()),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
class _InfoSection extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;

  const _InfoSection({
    required this.title,
    required this.body,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: cs.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: cs.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              body.isNotEmpty ? body : 'noData'.tr(),
              style: const TextStyle(height: 1.7, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}