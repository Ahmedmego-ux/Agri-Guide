part of 'history_scan_cubit.dart';

sealed class HistoryScanState extends Equatable {
  const HistoryScanState();

  @override
  List<Object> get props => [];
}

final class HistoryScanInitial extends HistoryScanState {}
final class HistoryScanLoading extends HistoryScanState {}
final class HistoryScanSuccess extends HistoryScanState {
  final List<ScanEntity>data;

  HistoryScanSuccess({required this.data});
}
final class HistoryScanFailure extends HistoryScanState {
  final String errmessage;

  HistoryScanFailure({required this.errmessage});
}
