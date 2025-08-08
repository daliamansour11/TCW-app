import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/apis/apis_url.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:tcw/features/reels/presentation/cubit/reels_cubit.dart';
import 'package:tcw/features/reels/presentation/pages/reel_view_screen.dart';
import 'package:tcw/features/reels/presentation/reel_viewmodel.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({
    super.key,
    this.showFirstIfAvailable = false,
    this.compactHeight = 50.0,
  });

  final bool showFirstIfAvailable;
  final double compactHeight;

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  late final ReelsViewmodel _viewmodel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _viewmodel = ReelsViewmodel(context);
    _loadInitialData();
    _setupScrollListener();
  }

  void _loadInitialData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReelsCubit>().fetchReels();
    });
  }

  void _setupScrollListener() {
    if (widget.showFirstIfAvailable) return;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<ReelsCubit>().fetchReels();
      }
    });
  }

  @override
  void dispose() {
    _viewmodel.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.showFirstIfAvailable
        ? SizedBox(
      height: widget.compactHeight.h,
      child: Column(
        children: [
          _buildHeader(context),
          Flexible(child: _buildReelsList()),
        ],
      ),
    )
        : Scaffold(
      appBar: const CustomAppBar(title: 'TCW Media'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 10),
            Expanded(child: _buildReelsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TCW Reels',
            style: context.textTheme.headlineMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          OutlinedButton.icon(
            onPressed: () => Zap.toNamed(AppRoutes.createReelPage),
            icon: const ImageIcon(
              AssetImage(AssetUtils.createReelIcon),
              color: Colors.black,
              size: 18,
            ),
            label: Text(
              'Create a Reel',
              style: context.textTheme.headlineMedium?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReelsList() {
    return BlocBuilder<ReelsCubit, ReelsState>(
      builder: (context, state) {
        if (state is ReelsLoading && !(state is ReelsLoadingMore)) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ReelsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => context.read<ReelsCubit>().fetchReels(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (state is ReelsLoaded || state is ReelsLoadingMore) {
          final allReels = _getAllReels(state);

          if (allReels.isEmpty) {
            return _buildEmptyState();
          }

          return _buildReelsListView(allReels, state is ReelsLoadingMore);
        }
        return const SizedBox();
      },
    );
  }

  List<Datum> _getAllReels(ReelsState state) {
    return (state is ReelsLoaded)
        ? state.reels.expand((page) => page.data).toList()
        : context
        .read<ReelsCubit>()
        .allReels
        .expand((page) => page.data)
        .toList();
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetUtils.reel,
            height: 120,
          ),
          const SizedBox(height: 16),
          const Text(
            'No reels found',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => Zap.toNamed(AppRoutes.createReelPage),
            child: const Text('Create your first reel'),
          ),
        ],
      ),
    );
  }

  Widget _buildReelsListView(List<Datum> reels, bool isLoadingMore) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            physics: widget.showFirstIfAvailable
                ? const NeverScrollableScrollPhysics()
                : null,
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: reels.length,
            itemBuilder: (context, index) {
              return _buildReelItem(reels, index);
            },
          ),
        ),
        if (isLoadingMore)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }

  Widget _buildReelItem(List<Datum> reels, int index) {
    final reel = reels[index];

    return GestureDetector(
      onTap: () => _navigateToReelView(reels, index),
      child: Container(
        height: 350,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildReelThumbnail(reel),
              _buildViewsCount(reel),
              if (reel.videoPath?.isNotEmpty ?? false)
                const Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(Icons.play_circle_outline,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReelThumbnail(Datum reel) {
    final imageUrl = _getValidImageUrl(reel.thumbnailUrl);

    return imageUrl.isNotEmpty
        ? CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => _buildPlaceholderImage(),
      errorWidget: (context, url, error) => _buildPlaceholderImage(),
    )
        : _buildPlaceholderImage();
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetUtils.reelPalceHolder),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  String _getValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    return url.startsWith('http')
        ? url
        : '${ApiUrl.baseImageUrl}/storage/app/public/$url';
  }

  String _getValidVideoUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    return url.startsWith('http')
        ? url
        : '${ApiUrl.baseImageUrl}/storage/app/public/$url';
  }

  Widget _buildViewsCount(Datum reel) {
    return Positioned(
      left: 8,
      bottom: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.play_arrow, size: 14, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              _formatViewsCount(reel.viewsCount ?? 0),
              // '${reel.viewsCount??0}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatViewsCount(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }

  void _navigateToReelView(List<Datum> reels, int index) async {
    final reel = reels[index];
    final videoUrl = _getValidVideoUrl(reel.videoPath);
    final updatedReel = await Navigator.push<Datum>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ReelViewScreen(
              reel: reel,
              user_id: reel.user?.id??0,
              videoUrl: videoUrl,
            ),
      ),
    );

    if (updatedReel != null) {
      context.read<ReelsCubit>().updateReelStats(
        reelId: updatedReel.id!,
        isLiked: updatedReel.isLiked,
        likesCount: updatedReel.likesCount,
        commentsCount: updatedReel.commentsCount,
      );
    }
  }
}