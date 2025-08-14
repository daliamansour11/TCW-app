


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/apis/apis_url.dart';
import 'package:tcw/features/reels/data/datasource/reel_datasource_imp.dart';
import 'package:tcw/features/reels/data/models/comment_model.dart' hide Datum;
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:tcw/features/reels/data/repositories/reel_repository_imp.dart';
import 'package:tcw/features/reels/presentation/cubit/create_reel_cubit.dart';
import 'package:tcw/features/reels/presentation/pages/widgets/action_buttons_colum.dart';
import 'package:tcw/features/reels/presentation/pages/widgets/reel_vedio_player.dart';
import 'package:tcw/features/reels/presentation/pages/widgets/user_info_section.dart';
import 'package:tcw/features/reels/presentation/reel_viewmodel.dart';

import '../../../auth/data/datasources/auth_local_datasource_impl.dart';
import '../../data/datasource/local_data_source/reel_history.dart';

class ReelViewScreen extends StatefulWidget {
  const ReelViewScreen({
    super.key,
    required this.reel,
    required this.videoUrl,
  });
  final Datum reel;
  final String videoUrl;
  @override
  State<ReelViewScreen> createState() => _ReelViewScreenState();
}

class _ReelViewScreenState extends State<ReelViewScreen> {
  late Datum _reel;
  bool _hasFetched = false;
  bool _isLoading = true;
  bool _isLiked = false;
  int _likesCount = 0;
  int _commentCount = 0;
  bool? isLikedByMe;
  Timer? _addToHistoryTimer;
  bool _hasAddedToHistory = false;
  Future<int?> _getCurrentUserId() async {
    final authLocal = AuthLocalDatasourceImpl();
    final user = await authLocal.getLoggedUser();
    return user?.id;
  }

  void _onVideoStarted() {
    if (_hasAddedToHistory) return;
    _addToHistoryTimer?.cancel();
    _addToHistoryTimer = Timer(const Duration(seconds: 5), () async {
      await addReelToHistory(_reel);
      _hasAddedToHistory = true;
    });
  }  @override
  void initState() {
    super.initState();
    _reel = widget.reel;
    _isLiked = false;
    _isLiked = _reel.isLiked ?? false;
    _likesCount = widget.reel.likesCount ?? 0;
    _commentCount = widget.reel.commentsCount ?? 0;
    addReelToHistory(_reel);

    _addToHistoryTimer?.cancel();
    fetchReelAndUpdateView();
  }
  List<CommentModel> _comments = [];

  Future<void> fetchComments() async {
    try {
      final response = await ReelsViewmodel(context).getReelComment( reelId: _reel.id!);
      final commentsList = response.data?.data ?? [];
      setState(() {
        _comments = commentsList;
        _commentCount = _comments.length;
      });
    } catch (e) {
      // Handle error
    }
  }void _deleteReel(int reelId) async {
    final result = await context.read<CreateReelCubit>().deleteReel(reelId);
    if (result.isSuccess) {
      Navigator.pop(context, true);
    }
  }

  String buildFullVideoUrl(String? videoUrl, String? videoPath) {
    if (videoUrl != null && videoUrl.isNotEmpty) {
      return videoUrl.replaceFirst('tcw.aspiregypt.com', 'tcw.de-mo.cloud');
    }
    if (videoPath == null || videoPath.isEmpty) return '';
    return '${ApiUrl.baseVideoUrl}$videoPath';
  }

  Future<void> fetchReelAndUpdateView() async {
    if (_hasFetched) return;
    _hasFetched = true;

    try {
      final response = await ReelsDataSourceImpl().getSpecificReel(_reel.id!);
      final list = response.data?.data;
      if (list == null || list.isEmpty) return;

      setState(() {
        _reel = list.first;
        _likesCount = _reel.likesCount ?? _likesCount;
        _commentCount = _reel.commentsCount ?? _commentCount;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _handleLikeToggled(bool newIsLiked, int newLikesCount) {
    setState(() {
      _isLiked = newIsLiked;
      _likesCount = newLikesCount;
    });
  }

  void _handleCommentAdded(int newCount) {
    setState(() {
      _commentCount = newCount;
    });
  }
  @override
  @override
  Widget build(BuildContext context) {

    return BlocProvider<CreateReelCubit>(
      create: (_) => CreateReelCubit(ReelRepositoryImpl()),
      child:
      Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            ReelVideoPlayer(
              videoUrl: buildFullVideoUrl(_reel.videoUrl, _reel.videoPath),
              onStartedPlaying: _onVideoStarted, errorMessage: '',
            ),         SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(child: UserInfoSection(reel: _reel)),
                        const SizedBox(width: 12),
                        FutureBuilder<int?>(
                          future: _getCurrentUserId(),
                          builder: (context, snapshot) {
                            final currentUserId = snapshot.data ?? 0;

                            return ActionButtonsColumn(
                              key: ValueKey('${_reel.id}_${_likesCount}'),
                              reel: _reel,
                              isLiked: _isLiked,
                              likesCount: _likesCount,
                              commentCount: _commentCount,
                              onLikeToggled: _handleLikeToggled,
                              onCommentAdded: _handleCommentAdded,
                              currentUserId: currentUserId,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}