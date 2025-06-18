import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/routes/routes_names.dart';

class EventSlider extends StatefulWidget {
  final List<Map<String, String>> events;

  const EventSlider({super.key, required this.events});

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: context.propHeight(230),
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.events.length,
            onPageChanged: (index) {
              setState(() {
              });
            },
            itemBuilder: (context, index) {
              final event = widget.events[index];
              return Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(event['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                        context.propHeight(12),
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                color: Colors.white, size: 14),
                            SizedBox(width: context.propWidth(4)),
                            Text(event['date']!,
                                style: GoogleFonts.poppins(
                                    fontSize: 10, color: Colors.white)),
                            SizedBox(width: context.propWidth(12)),
                            const Icon(Icons.access_time,
                                color: Colors.white, size: 14),
                            SizedBox(width: context.propWidth(4)),
                            Text(event['time']!,
                                style: GoogleFonts.poppins(
                                    fontSize: 10, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          event['title']!,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                       Modular.to.pushNamed(AppRoutes.liveEventScreen);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('join now',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white)),
                              const SizedBox(width: 8),
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(Icons.play_arrow_rounded,
                                    size: 12, color: AppColors.primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: context.propHeight(12)),
        Center(
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
      ],
    );
  }
}
