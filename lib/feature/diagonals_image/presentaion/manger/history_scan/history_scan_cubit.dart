import 'dart:io';

import 'package:agri_guide_app/core/erorr/error_handler.dart';
import 'package:agri_guide_app/feature/diagonals_image/domain/entity/scan_entity.dart';
import 'package:agri_guide_app/feature/diagonals_image/domain/repos/scan_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'history_scan_state.dart';

class HistoryScanCubit extends Cubit<HistoryScanState> {
  HistoryScanCubit(this.repo, ) : super(HistoryScanInitial());
  final ScanRepo repo;
  List<ScanEntity>? _cachedHistory;
  

 Future<void> getHistory() async {
  
  if (_cachedHistory != null) {
    emit(HistoryScanSuccess(data: _cachedHistory!));
    return;
  }

  emit(HistoryScanLoading());

  try {
    final response = await repo.getHistory();

    _cachedHistory = response;

    emit(HistoryScanSuccess(data: response));
  } catch (e) {
    emit(
      HistoryScanFailure(
        errmessage: ErrorHandler.handlePostgrestError(e),
      ),
    );
  }
}
  Future<void> refreshHistory() async {
    _cachedHistory = null;
  await getHistory();
}

}
