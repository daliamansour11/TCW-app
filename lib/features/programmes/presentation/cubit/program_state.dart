part of 'program_cubit.dart';

@immutable
sealed class ProgramState {}

final class ProgramInitial extends ProgramState {}
class ProgramLoading extends ProgramState {}

class ProgramLoadingMore extends ProgramState {}
class ProgramLoaded extends ProgramState {
  ProgramLoaded(this.programs, {this.hasMore = true});
  final List<ProgramModel> programs;
  final bool hasMore;
}

class ProgramDetailLoaded extends ProgramState {
  ProgramDetailLoaded(this.program);
  final ProgramDetailModel program;
}

class CategoriesLoaded extends ProgramState {
  // CategoriesLoaded(this.categories);
  // final List<CategoryModel> categories;
}

class ProgramError extends ProgramState {
  ProgramError(this.message);
  final String message;
}