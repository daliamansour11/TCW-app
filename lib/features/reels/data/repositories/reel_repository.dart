import 'dart:io';

import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/features/reels/data/models/add_comment_response_model.dart';
import 'package:tcw/features/reels/data/models/comment_model.dart';
import 'package:tcw/features/reels/data/models/reel_interactions_response_model.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:tcw/features/reels/data/models/reel_response.dart';

abstract class ReelsRepository {
  Future<ApiResponse<List<ReelModel>>> getReels({
    int limit,
    int offset,

  });
  Future<ApiResponse<ReelModel>> getSpecificReel(int reelId);

  Future<ApiResponse<ReelsResponse>> createNewReel({
    required String? caption,  // Make required but nullable
    required File video,
  });
  Future<ApiResponse<ReelsInteractionsResonseModel>> toggleLikeOnReel(int reelId);
  Future<ApiResponse<AddCommentResponseModel>> addCommentOnReel(int reelId, String content);
  Future<ApiResponse<CommentModel>> getCommentsForReel({required  int reelId});
  Future<ApiResponse<ReelsResponse>> updateReelCaption(String caption,int reelId);
  Future<ApiResponse<String>> deleteReel(int reelId) ;

  }