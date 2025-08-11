import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constansts/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/asset_utils.dart';
import '../../data/models/event_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/live_event_screen.dart';

class EventSlider extends StatefulWidget {
  const EventSlider({super.key, required this.events});
  final List<Meeting> events;

  @override
  State<EventSlider> createState() => _EventSliderState();
}

class _EventSliderState extends State<EventSlider> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return SizedBox(
      height: context.propHeight(230),
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.events.length,
        itemBuilder: (context, index) {
          final event = widget.events[index];
          return _buildEventCard(context, event);
        },
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Meeting event) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(event.thumbUrl ?? AssetUtils.programPlaceHolder),
        onError: (exception, stackTrace) {
          print('Image failed to load: $exception');
        },

        fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          _buildOverlay(),
          _buildTopDetails(context, event),
          _buildTitle(context, event),
          _buildJoinButton(context,event),
          _buildIndicator(),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Colors.black.withValues(alpha:0.6),
            Colors.transparent,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );
  }

  Widget _buildTopDetails(BuildContext context, Meeting event) {
    DateTime startDateTime = event.scheduledAt;
    DateTime endDateTime = event.scheduledAt.add(Duration(hours: 1));
    final dateFormat = DateFormat('EEEE, d MMM yyyy');
    final timeFormat = DateFormat('hh:mm a');

    final formattedDate = dateFormat.format(startDateTime);
    final formattedStart = timeFormat.format(startDateTime);
    final formattedEnd = timeFormat.format(endDateTime);

    return Padding(
      padding: EdgeInsets.all(context.propHeight(12)),
      child: Align(
        alignment: Alignment.topRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today, color: Colors.white, size: 14),
            const SizedBox(width: 4),
            Text(formattedDate, style: GoogleFonts.poppins(fontSize: 10, color: Colors.white)),
            const SizedBox(width: 8),
            const Icon(Icons.access_time, color: Colors.white, size: 14),
            const SizedBox(width: 4),
            Text('$formattedStart - $formattedEnd', style: GoogleFonts.poppins(fontSize: 10, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, Meeting event) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          event.title?.isNotEmpty == true
              ? event.title!
              : 'Event Title',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildJoinButton(BuildContext context,Meeting event) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            backgroundColor:Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            final url = event.meetingLink;
            if (url != null && url.isNotEmpty) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LiveEventScreen(
                    meetingUrl: url,
                    questions: [], //
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cannot open meeting link')),
              );
            }
          },

          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              Text(
                'join now',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child:const Icon(
                  Icons.play_arrow_outlined,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 5,
      child: Center(
        child: SmoothPageIndicator(
          controller: _pageController,
          count: widget.events.length,
          effect: WormEffect(
            dotColor: Colors.grey.shade300,
            activeDotColor: AppColors.primaryColor,
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ),
    );
  }
}
