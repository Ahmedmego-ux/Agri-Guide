import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agri_guide_app/feature/diagonals_image/presentaion/manger/scan/scan_cubit.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/manger/history_scan/history_scan_cubit.dart';

class AIResultScreen extends StatefulWidget {
  final String imagePath;
  final bool isNetwork;
  final String? result;

  const AIResultScreen({
    super.key,
    required this.imagePath,
    required this.isNetwork,
    this.result,
  });

  @override
  State<AIResultScreen> createState() => _AIResultScreenState();
}

class _AIResultScreenState extends State<AIResultScreen> {
  bool _saved = false;

  /// 🧪 MOCK RESULT (TEST ONLY)
  final String mockResult = '''
🌿 PLANT ANALYSIS TEST REPORT

🔬 Disease: Early Blight (Test Data)
📊 Confidence: 91%

💊 Recommendations:
- Remove infected leaves
- Apply neem oil
- Improve ventilation

⚠️ This is a MOCK RESULT for testing only
''';

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
          result: widget.result ?? mockResult,
        );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Plant Scanner"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocListener<ScanCubit, ScanState>(
          listener: (context, state) {
            if (state is ScanSuccess) {
              context.read<HistoryScanCubit>().refreshHistory();
            }

            if (state is ScanFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Column(
            children: [
              /// IMAGE
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
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
              ),

              const SizedBox(height: 20),

              /// RESULT
              Expanded(
                child: BlocBuilder<ScanCubit, ScanState>(
                  builder: (context, state) {
                    if (state is ScanLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is ScanFailure) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Text(
                          widget.result ?? mockResult,
                          style: textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}