//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tcw/features/programmes/data/models/programme_model.dart';
// import 'package:tcw/features/reels/data/repositories/reel_repository_imp.dart';
// import 'package:tcw/features/reels/presentation/cubit/reel_interactions/reel_toggle_on_like_cubit.dart';
// import 'package:tcw/features/reels/presentation/cubit/reels_cubit.dart';
//
// class LikeButton extends StatefulWidget {
//
//   const LikeButton({
//     Key? key,
//     required this.reelId,
//     required this.isInitiallyLiked,
//     required this.initialLikesCount,
//     final dynamic Function(Datum)? onLikeChanged,
//
//   }) : super(key: key);
//   final int reelId;
//   final bool isInitiallyLiked;
//   final int initialLikesCount;
//
//   @override
//   State<LikeButton> createState() => _LikeButtonState();
// }
//
// class _LikeButtonState extends State<LikeButton> {
//   late bool _isLiked;
//   late int _likesCount;
//   late ReelToggleOnLikeCubit _cubit;
//
//   @override
//   void initState() {
//     super.initState();
//     _isLiked = widget.isInitiallyLiked;
//     _likesCount = widget.initialLikesCount;
//     _cubit = ReelToggleOnLikeCubit(ReelRepositoryImpl(),ReelsCubit(ReelRepositoryImpl()));
//   }
//
//   @override
//   void dispose() {
//     _cubit.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: _cubit,
//       child: BlocConsumer<ReelToggleOnLikeCubit, ToggleLikeState>(
//         listener: (context, state) {
//           if (state is ToggleLikeError && state.reelId == widget.reelId) {
//             // Rollback UI
//             setState(() {
//               _isLiked = !_isLiked;
//               _likesCount += _isLiked ? 1 : -1;
//             });
//
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('فشل التفاعل، حاول تاني')),
//             );
//           }
//         }
//         ,
//         builder: (context, state) {
//           return Column(
//             children: [
//               IconButton(
//                 icon: Icon(
//                   _isLiked ? Icons.favorite : Icons.favorite_border,
//                   color: _isLiked ? Colors.red : Colors.white,
//                   size: 32,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _isLiked = !_isLiked;
//                     _likesCount += _isLiked ? 1 : -1;
//                   });
//
//                   _cubit.toggleOnReelLike(
//                     reelId: widget.reelId,
//                     oldIsLiked: !_isLiked,
//                   );
//                 },
//               ),
//
//               Text(
//                 '$_likesCount',
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:tcw/features/reels/data/repositories/reel_repository_imp.dart';
import 'package:tcw/features/reels/presentation/cubit/reel_interactions/reel_toggle_on_like_cubit.dart';
import 'package:tcw/features/reels/presentation/cubit/reels_cubit.dart';

class LikeButton extends StatefulWidget {
  LikeButton({
    Key? key,
    required this.reelId,
    required this.isInitiallyLiked,
    required this.initialLikesCount,
    this.onLikeChanged,
  }) : super(key: key);

  final int reelId;
  final bool isInitiallyLiked;
  final int initialLikesCount;
  final Function(bool isLiked, int newLikesCount)? onLikeChanged;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool _isLiked;
  late int _likesCount;
  late ReelToggleOnLikeCubit _cubit;
  bool? _preTapIsLiked;
  int? _preTapLikesCount;
  bool _isLiking = false; // ✅ fix here

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isInitiallyLiked;
    _likesCount = widget.initialLikesCount;
    _cubit = ReelToggleOnLikeCubit(
      ReelRepositoryImpl(),
      ReelsCubit(ReelRepositoryImpl()),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<ReelToggleOnLikeCubit, ToggleLikeState>(
        listener: (context, state) {
          if (state is ToggleLikeSuccess && state.reelId == widget.reelId) {
            setState(() {
              _isLiked = state.isLiked;
              _likesCount = state.likesCount;
            });

            widget.onLikeChanged?.call(_isLiked, _likesCount);
          } else if (state is ToggleLikeError && state.reelId == widget.reelId) {
            setState(() {
              if (_preTapIsLiked != null && _preTapLikesCount != null) {
                _isLiked = _preTapIsLiked!;
                _likesCount = _preTapLikesCount!;
              }
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('فشل التفاعل، حاول تاني')),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              IconButton(
                icon: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.red : Colors.white,
                  size: 32,
                ),
                onPressed: () async {
                  if (_isLiking) return;

                  _preTapIsLiked = _isLiked;
                  _preTapLikesCount = _likesCount;

                  setState(() {
                    _isLiked = !_isLiked;
                    _likesCount += _isLiked ? 1 : -1;
                  });

                  widget.onLikeChanged?.call(_isLiked, _likesCount);

                  _isLiking = true;

                  try {
                    await _cubit.toggleOnReelLike(
                      reelId: widget.reelId,
                      oldIsLiked: _preTapIsLiked ?? false,
                    );
                  } catch (e) {
                    setState(() {
                      _isLiked = _preTapIsLiked ?? false;
                      _likesCount = _preTapLikesCount ?? _likesCount;
                    });
                  } finally {
                    _isLiking = false;
                  }
                },
              ),
              Text(
                '$_likesCount',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          );
        },
      ),
    );
  }
}
