import 'dart:io';

import 'package:agri_guide_app/core/erorr/error_handler.dart';
import 'package:agri_guide_app/feature/diagonals_image/domain/repos/scan_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit(this.repo) : super(ScanInitial());
   final ScanRepo repo;

  Future<void> saveScan({
    required File file,
    required String result,
  }) async {
    emit(ScanLoading());

    try {
      await repo.saveScane(
        file: file,
        result: result,
      );

      emit(ScanSuccess());
    } catch (e) {
      emit(
        ScanFailure(
          message: ErrorHandler.handlePostgrestError(e),
        ),
      );
    }
  }
}
