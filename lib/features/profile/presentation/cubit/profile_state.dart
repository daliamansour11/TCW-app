part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {}

class ProfileError extends ProfileState {}

// get profile and return user model

class GetProfileLoaded extends ProfileState {
  GetProfileLoaded({required this.user});
  final UserModel user;
} 
