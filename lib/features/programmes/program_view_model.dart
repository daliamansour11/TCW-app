import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/features/courses/data/models/last_viewed_model.dart';
import 'package:tcw/features/courses/presentation/cubit/course/courses_cubit.dart';
import 'package:tcw/features/courses/presentation/cubit/student/student_course_cubit.dart';
import 'package:tcw/features/programmes/presentation/cubit/program_cubit.dart';

class ProgramViewmodel {
  ProgramViewmodel(this.ctx);
  final BuildContext ctx;


  ProgramCubit get programCubit => BlocProvider.of<ProgramCubit>(ctx, listen: false);


  Future<void> fetchProgramDetails(int programId) async {
    try{
      await ctx.read<ProgramCubit>().fetchProgramDetails(programId);
    }catch(e){
      debugPrint('Error updating Last Viewed: $e');

    }
  }



}