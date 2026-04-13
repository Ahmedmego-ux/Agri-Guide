import 'package:agri_guide_app/feature/diagonals_image/presentaion/manger/history_scan/history_scan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agri_guide_app/feature/diagonals_image/domain/entity/scan_entity.dart';
import 'package:agri_guide_app/feature/diagonals_image/presentaion/widgets/history_item_card.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HistoryScanCubit>().getHistory();
    
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: BlocBuilder<HistoryScanCubit, HistoryScanState>(
        builder: (context, state) {
          
         
          if (state is HistoryScanLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          
          if (state is HistoryScanFailure) {
            return Center(
              child: Text(
                state.errmessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          
          if (state is HistoryScanSuccess) {
            final List<ScanEntity> scans = state.data;

            // 📭 EMPTY STATE
            if (scans.isEmpty) {
              return const Center(
                child: Text(
                  "No scans yet 🌱",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: scans.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = scans[index];

                return HistoryItemCard(
                  item: item,
                 
                );
              },
            );
          }

          // 🟡 INITIAL STATE
          return const SizedBox();
        },
      ),
    );
  }
}