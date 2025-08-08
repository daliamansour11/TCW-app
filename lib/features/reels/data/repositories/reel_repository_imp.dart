import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/features/reels/data/datasource/reel_datasource_imp.dart';
import 'package:tcw/features/reels/data/models/add_comment_response_model.dart';
import 'package:tcw/features/reels/data/models/comment_model.dart';
import 'package:tcw/features/reels/data/models/reel_interactions_response_model.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:tcw/features/reels/data/models/reel_response.dart';
import 'package:tcw/features/reels/data/repositories/reel_repository.dart';



class ReelRepositoryImpl implements ReelsRepository {
  ReelRepositoryImpl();

  final ReelsDataSourceImpl _datasource = ReelsDataSourceImpl();


  @override
  Future<ApiResponse<List<ReelModel>>> getReels({
    int limit = 10,
    int offset = 1,
  }) {
    return _datasource.getReels(
      limit: limit,
      offset: offset,

    );
  }
  ///getSpecificReel

  Future<ApiResponse<ReelModel>> getSpecificReel(int reelId)
  async{

return  await _datasource.getSpecificReel(reelId);
  }

  @override
  Future<ApiResponse<ReelsInteractionsResonseModel>> toggleLikeOnReel(
      int reelId) async {
    return await _datasource.toggleLikeOnReel(reelId);
  }
  ///create reel

  @override
  Future<ApiResponse<ReelsResponse>> createNewReel({
    required String? caption,
    required File video,
  }) async {
    try {
      return await _datasource.createNewReel(
        caption: caption,
        video: video,
      );
    } catch (e) {
      return ApiResponse<ReelsResponse>(
        data: null,
        mapData: {},
        statusCode: 500,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }
  ///update reel caption
  @override
  Future<ApiResponse<ReelsResponse>> updateReelCaption(String caption,int reelId)async{

    try{
    return await _datasource.updateReelCaption(
       caption,
      reelId
    );
  } catch (e) {
  return ApiResponse<ReelsResponse>(
  data: null,
  mapData: {},
  statusCode: 500,
  message: 'Unexpected error: ${e.toString()}',
  );
  }
  }

//Add Comment
  @override
  Future<ApiResponse<AddCommentResponseModel>> addCommentOnReel(int reelId, String content)async {
    return await _datasource.addCommentToReel(reelId, content);

  }
  //GetComment of Reel

  @override
  Future<ApiResponse<CommentModel>>getCommentsForReel({required int reelId}) async{

    return await _datasource.getCommentsForReel(reelId: reelId);

  }

  @override
  Future<ApiResponse<String>> deleteReel(int reelId) async{
    return await _datasource.deleteReel( reelId);
  }

}




