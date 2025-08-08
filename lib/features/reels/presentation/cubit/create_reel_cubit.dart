import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:tcw/features/reels/data/models/reel_response.dart';
import 'package:tcw/features/reels/data/repositories/reel_repository.dart';
import 'package:tcw/features/reels/presentation/cubit/reels_cubit.dart';

part 'create_reel_state.dart';

class CreateReelCubit extends Cubit<CreateReelState> {
  CreateReelCubit(this.reelRepository) : super(CreateReelInitial());

  final ReelsRepository reelRepository;


  Future<void> createReel({required String? caption, required File video}) async {
    emit(CreateReelLoading());
    final response = await reelRepository.createNewReel(
      caption: caption,
      video: video,
    );

    if (response.data != null) {
      emit(CreateReelSuccess(response.data!));
    }
    else {
      emit(CreateReelError(response.message ?? 'Failed to create reel'));
    }
  }

  Future<void> updateReelCaption({
    required String caption, required int  reelId}) async {
    emit(ReelActionsLoading());
    final response = await reelRepository.updateReelCaption(
      caption,
      reelId
    );

    if (response.data != null) {



      emit(ReelUpdateSuccess());
    }

    else {
      emit(CreateReelError(response.message ?? 'Failed to update reel caption' ));
    }
  }

  Future<ApiResponse<String>> deleteReel(int reelId) async {
    emit(CreateReelLoading());
    final result = await reelRepository.deleteReel(reelId);
    if (result.isSuccess) {
      emit(ReelDeleteSuccess());
    } else {
      emit(ReelActionsError(result.message??'Failed to delete reel '));
    }
    return result;
  }


}