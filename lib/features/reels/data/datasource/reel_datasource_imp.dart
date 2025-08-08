import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/apis/api_service.dart';
import 'package:tcw/core/apis/apis_url.dart';
import 'package:tcw/core/shared/log/logger.dart' show logger;
import 'package:tcw/features/reels/data/datasource/reel_datasource.dart';
import 'package:tcw/features/reels/data/models/add_comment_response_model.dart';
import 'package:tcw/features/reels/data/models/comment_model.dart';
import 'package:tcw/features/reels/data/models/reel_interactions_response_model.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:tcw/features/reels/data/models/reel_response.dart';




class ReelsDataSourceImpl implements ReelDataSource {
  @override
  Future<ApiResponse<List<ReelModel>>> getReels({
    int limit = 10,
    int offset = 1,
  }) async {
    final query = {
      'limit': limit,
      'page': offset,
    };

    final response = await ApiService.instance.get(
        '/reels', queryParameters: query);

    if (response.isError) {
      return response.error(
          message: response.message ?? 'Failed to load reels');
    }

    try {
      final reelModel = ReelModel.fromJson(response.mapData);
      return response.copyWith(data: [reelModel]);
    } catch (e, stack) {
      logger.e('Error parsing reels: $e');
      logger.e(stack);
      return response.error(message: 'Failed to parse reels: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<ReelsResponse>> createNewReel({
    required String? caption,
    required File video,
  }) async {
    final formData = FormData.fromMap({
      'caption': caption ?? '',
      'video': await MultipartFile.fromFile(
        video.path,


        filename: 'reel_${DateTime
            .now()
            .millisecondsSinceEpoch}.mp4',
      ),
    });
    try {
//  API request
      final response = await ApiService.instance.post(
        ApiUrl.reels.base,
        data: formData,
        withToken: true,
      );

      //  error response
      if (response.isError) {
        return response.copyWith<ReelsResponse>(
          data: null,
          message: response.message ?? 'Failed to create reel',
        );
      }

      //  successful response
      try {
        final reelsResponse = ReelsResponse.fromJson(response.mapData);
        return response.copyWith<ReelsResponse>(
          data: reelsResponse,
        );
      } catch (e) {
        return response.copyWith<ReelsResponse>(
          data: null,
          message: 'Failed to parse response: ${e.toString()}',
        );
      }
    } catch (e) {
      //  unexpected errors
      return ApiResponse<ReelsResponse>(
        data: null,
        mapData: {},
        statusCode: 500,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }


  @override
  Future<ApiResponse<ReelsInteractionsResonseModel>> toggleLikeOnReel(
      int reelId) async {
    try {
      final response = await ApiService.instance.post(
          '${ApiUrl.reels.base}/$reelId/like',
          data: {},
          withToken: true
      );

      if (response.isError) {
        return response.copyWith<ReelsInteractionsResonseModel>(
          data: null,
          message: response.message ?? 'Failed to toggle like',
        );
      }

      try {
        final interactionResponse = ReelsInteractionsResonseModel.fromJson(
            response.mapData);
        return response.copyWith(data: interactionResponse);
      } catch (e) {
        return response.copyWith(
          data: null,
          message: 'Failed to parse response: ${e.toString()}',
        );
      }
    } catch (e) {
      return ApiResponse<ReelsInteractionsResonseModel>(
        data: null,
        mapData: {},
        statusCode: 500,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

//ADDcomment

  @override
  Future<ApiResponse<AddCommentResponseModel>> addCommentToReel(int reelId,
      String content) async {
    try {
      final response = await ApiService.instance.post(
          '${ApiUrl.reels.base}/$reelId/comments',
          data: {'content': content},
          withToken: true
      );

      if (response.isError) {
        return response.copyWith<AddCommentResponseModel>(
          data: null,
          message: response.message ??
              'Failed to add comment', // Updated message
        );
      }

      try {
        final interactionResponse = AddCommentResponseModel.fromJson(
            response.mapData);
        return response.copyWith(data: interactionResponse);
      } catch (e) {
        return response.copyWith(
          data: null,
          message: 'Failed to parse response: ${e.toString()}',
        );
      }
    } catch (e) {
      return ApiResponse<AddCommentResponseModel>(
        data: null,
        mapData: {},
        statusCode: 500,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  } //GET REEL COMMENT
  @override
  Future<ApiResponse<CommentModel>> getCommentsForReel(
      {required int reelId}) async {
    final response = await ApiService.instance.get(
        '${ApiUrl.reels.base}/$reelId/comments',
        withToken: true
    );
    if (response.data == null || response.data.isEmpty) {
      print('empty list');
    }
    if (response.isError) {
      return response.error(
          message: response.message ?? 'Failed to load comments');
    }

    try {
      final commentModel = CommentModel.fromJson(response.mapData);
      return response.copyWith(data: commentModel);
    } catch (e, stack) {
      logger.e('Error parsing comments: $e');
      logger.e(stack);
      return response.error(
          message: 'Failed to parse comments: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<String>> deleteReel(int reelId) async {
    final response = await ApiService.instance.delete(
      '/reels/$reelId',
      withToken: true,
    );

    if (response.isError) {
      return response.error(message: response.message ?? 'Delete failed');
    }

    if (response.data is String) {
      final message = response.data as String;
      return ApiResponse<String>(
        data: message,
        mapData: {},
        statusCode: response.statusCode,
        message: message,
      );
    } else if (response.data is Map<String, dynamic>) {
      final map = response.data as Map<String, dynamic>;
      return ApiResponse<String>(
        data: map['message'] ?? 'Deleted successfully',
        mapData: map,
        statusCode: response.statusCode,
        message: map['message'],
      );
    } else {
      return response.error(message: 'Unexpected response format');
    }
  }


  @override
  Future<ApiResponse<ReelModel>> getSpecificReel(int reelId) async {
    final response = await ApiService.instance.get('/reels/$reelId',);
    if (response.isError) {
      return response.error(
          message: response.message ?? 'Failed to load reels');
    }

    try {
      final reelModel = ReelModel.fromJson(response.mapData);
      return response.copyWith(data: reelModel);
    } catch (e, stack) {
      logger.e('Error parsing reels: $e');
      logger.e(stack);
      return response.error(message: 'Failed to parse reels: ${e.toString()}');
    }
  }


  @override
  Future<ApiResponse<ReelsResponse>> updateReelCaption(String caption,
      int reelId) async {
    final formData = FormData.fromMap({
      'caption': caption ?? '',});
    try {
//  API request
      final response = await ApiService.instance.post(
        '${ApiUrl.reels.base}/$reelId',
        data: formData,
        withToken: true,
      );

      //  error response
      if (response.isError) {
        return response.copyWith<ReelsResponse>(
          data: null,
          message: response.message ?? 'Failed to create reel',
        );
      }

      //  successful response
      try {
        final reelsResponse = ReelsResponse.fromJson(response.mapData);
        return response.copyWith<ReelsResponse>(
          data: reelsResponse,
        );
      } catch (e) {
        return response.copyWith<ReelsResponse>(
          data: null,
          message: 'Failed to parse response: ${e.toString()}',
        );
      }
    } catch (e) {
      //  unexpected errors
      return ApiResponse<ReelsResponse>(
        data: null,
        mapData: {},
        statusCode: 500,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }


}



