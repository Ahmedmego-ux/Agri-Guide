part of 'scan_cubit.dart';

sealed class ScanState extends Equatable {
  const ScanState();

  @override
  List<Object> get props => [];
}

final class ScanInitial extends ScanState {}
final class ScanLoading extends ScanState {}

final class ScanSuccess extends ScanState {}

final class ScanFailure extends ScanState {
  final String message;

  const ScanFailure({required this.message});

  @override
  List<Object> get props => [message];
}
