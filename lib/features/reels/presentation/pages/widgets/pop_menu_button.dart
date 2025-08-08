import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/shared_widget/custom_icon_dialog.dart';
import 'package:tcw/features/reels/data/datasource/reel_datasource_imp.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:tcw/features/reels/data/repositories/reel_repository.dart';
import 'package:tcw/features/reels/data/repositories/reel_repository_imp.dart';
import 'package:tcw/features/reels/presentation/cubit/create_reel_cubit.dart';
import 'package:tcw/features/reels/presentation/pages/create_reel_page.dart';
import 'package:tcw/features/reels/presentation/reel_viewmodel.dart';

class PopMenuButton extends StatefulWidget {
  const PopMenuButton({
    super.key,
    required this.reelModel,
    required this.currentUserId,
  });

  final Datum reelModel;
  final int currentUserId;

  @override
  State<PopMenuButton> createState() => _PopMenuButtonState();
}

class _PopMenuButtonState extends State<PopMenuButton> {
  bool _hasFetched = false;
  bool _isLoading = true;
  bool _isLiked = false;
  int _likesCount = 0;
  int _commentCount = 0;

  late Datum _reel;


  Future<void> fetchReelAndUpdateView() async {
    if (_hasFetched) return;
    _hasFetched = true;

    try {
      final response = await ReelsDataSourceImpl().getSpecificReel(widget.reelModel.id!);
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

  @override
  Widget build(BuildContext context) {
    final isOwner = widget.reelModel.userId == widget.currentUserId;

    if (!isOwner) {
      return const SizedBox.shrink();
    }

    return BlocConsumer<CreateReelCubit, CreateReelState>(
      listener: (context, state) {
        if (state is ReelDeleteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reel deleted successfully')),
          );
          Navigator.pop(context);
        } else if (state is ReelActionsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? 'Failed to delete reel')),
          );
        }
      },
      builder: (context, state) {
        return PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onSelected: (value)async {
            if (value == 'edit') {
             final updated=await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => CreateReelCubit(ReelRepositoryImpl()),
                    child: CreateReelPage(
                      isEditing: true,
                      reelId: widget.reelModel.id,
                      initialCaption: widget.reelModel.caption,
                    ),
                  ),
                ),
              );
             if (updated == true) {
               fetchReelAndUpdateView();
             }
            } else if (value == 'delete') {
              _confirmDelete(context, widget.reelModel.id!);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, color: Colors.black54),
                  SizedBox(width: 8),
                  Text('Edit Caption'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Delete Reel'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmDelete(BuildContext context, int reelId) {
    return customIconDialog(
      context,
      title: 'Are you sure you want to delete this reel',
      subTitle: '',
      buttons: CustomIconDialogButtons(
        firstTitle: 'Cancel',
        secondTitle: 'Delete Reel',
        firstOnPressed: () {
          Navigator.pop(context);
        },
        secondOnPressed: () {
          Navigator.pop(context);
          context.read<CreateReelCubit>().deleteReel(reelId);
        },
      ),
    );
  }
}
