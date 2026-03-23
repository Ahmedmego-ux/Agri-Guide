part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ProfileLoading extends ProfileState {}
final class ProfileSuccess extends ProfileState {
  final ProfileEntity profileEntity;

  ProfileSuccess({required this.profileEntity});

}
final class ProfileFaliure extends ProfileState {
  final String errmessage;

  ProfileFaliure({required this.errmessage});
}
