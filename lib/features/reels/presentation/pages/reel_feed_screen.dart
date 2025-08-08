


// import 'package:flutter/material.dart';
// import 'package:tcw/features/reels/data/models/reel_model.dart';
// import 'package:tcw/features/reels/presentation/pages/reel_view_screen.dart';
//TODO LATER
// class ReelsFeedScreen extends StatefulWidget {
//   final List<Datum> reels;
//   final int initialIndex;
//
//   const ReelsFeedScreen({
//     super.key,
//     required this.reels,
//     this.initialIndex = 0,
//   });
//
//   @override
//   State<ReelsFeedScreen> createState() => _ReelsFeedScreenState();
// }
//
// class _ReelsFeedScreenState extends State<ReelsFeedScreen> {
//   late PageController _pageController;
//   late List<Datum> _reels;
//   int _currentIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _reels = widget.reels;
//     _currentIndex = widget.initialIndex;
//     _pageController = PageController(initialPage: _currentIndex);
//   }
//
//   void _onPageChanged(int index) {
//     setState(() => _currentIndex = index);
//
//     // يمكنك تحميل المزيد عند الاقتراب من نهاية القائمة هنا
//   }
//
//   void _updateReel(Datum updatedReel) {
//     setState(() {
//       _reels[_currentIndex] = updatedReel;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView.builder(
//         controller: _pageController,
//         scrollDirection: Axis.vertical,
//         itemCount: _reels.length,
//         onPageChanged: _onPageChanged,
//         itemBuilder: (context, index) {
//           final reel = _reels[index];
//           return ReelViewScreen(
//             key: ValueKey(reel.id),
//             reel: reel,
//             videoUrl: reel.videoPath ?? '',
//             onUpdate: _updateReel,
//           );
//         },
//       ),
//     );
//   }
// }
