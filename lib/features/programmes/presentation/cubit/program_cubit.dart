import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tcw/features/programmes/data/models/program_detail_model.dart';
import 'package:tcw/features/programmes/data/models/programme_model.dart';
import 'package:tcw/features/programmes/data/repositories/programs_repository_impl.dart';

part 'program_state.dart';

class ProgramCubit extends Cubit<ProgramState> {
  ProgramCubit(this.repository) : super(ProgramInitial());

  final ProgramRepository repository;

  List<ProgramModel> allProgram = [];

  Future<void> fetchPrograms({ // Changed from fetchCourses
    int limit = 10,
    int offset = 1,
    String? search,
    bool loadMore = false,
  }) async {
    if (loadMore) {
      emit(ProgramLoadingMore());
    } else {
      emit(ProgramLoading());
      allProgram.clear();
    }
    final result = await repository.getPrograms(
      limit: limit,
      offset: offset,
      search: search,
    );

    if (result.isSuccess) {
      if (loadMore) {
        allProgram.addAll(result.data ?? []);
      } else {
        allProgram = result.data ?? [];
      }
      emit(ProgramLoaded(
        allProgram,
        hasMore: (result.data?.length ?? 0) == limit,
      ));
    } else {
      emit(ProgramError(result.message ?? 'Failed to load programs')); // Fixed state
    }
  }

  Future<void> fetchProgramDetails(int programId) async {
    emit(ProgramLoading());
    final result = await repository.getProgramDetails(programId);

    if (result.isSuccess && result.data != null) {
      emit(ProgramDetailLoaded(result.data!));
    } else {
      emit(ProgramError(result.message ?? 'Failed to load program details'));
    }
  }


}