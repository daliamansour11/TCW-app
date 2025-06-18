// ignore_for_file: unused_field, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/event/data/models/event_model.dart';
import 'package:tcw/features/event/presentation/widgets/event_slider_widget.dart';
import 'package:tcw/features/event/presentation/widgets/past_event.dart';
import 'package:tcw/features/event/presentation/widgets/upComing_event.dart';

class EventScreen extends StatefulWidget {
  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<Event> upComingEvents = [
    Event(
      date: "17 Mar",
      time: "02.00 - 03.30 PM",
      title: "Mastering Productivity",
      description:
          "Learn practical strategies to boost efficiency, manage time effectively, and achieve your goals with expert insights.",
      coachName: "Ahmed Mohamed",
      coachRole: "Coach",
      isAlertSet: true,
    ),
    Event(
      date: "17 Mar",
      time: "02.00 - 03.30 PM",
      title: "Mastering Productivity",
      description:
          "Learn practical strategies to boost efficiency, manage time effectively, and achieve your goals with expert insights.",
      coachName: "Ahmed Mohamed",
      coachRole: "Coach",
      isAlertSet: false,
    ),
    Event(
      date: "17 Mar",
      time: "02.00 - 03.30 PM",
      title: "Mastering Productivity",
      description:
          "Learn practical strategies to boost efficiency, manage time effectively, and achieve your goals with expert insights.",
      coachName: "Ahmed Mohamed",
      coachRole: "Coach",
      isAlertSet: false,
    ),
  ];

  void toggleAlert(int index) {
    setState(() {});
  }

  final List<Map<String, String>> events = [
    {
      'title':
          'Join our live event to master time management and achieve peak productivity!',
      'date': 'Monday, 4 Mar 2025',
      'time': '02.00 - 03.30 PM',
      'image': AssetManger.container,
    },
    {
      'title': 'Boost your leadership skills with expert guidance.',
      'date': 'Tuesday, 5 Mar 2025',
      'time': '03.00 - 04.00 PM',
      'image': AssetManger.ex_1,
    },
    {
      'title': 'Unlock your potential with our exclusive workshop!',
      'date': 'Wednesday, 6 Mar 2025',
      'time': '01.00 - 02.30 PM',
      'image': AssetManger.ex_2,
    },
    {
      'title': 'Enhance your skills with our expert-led training session.',
      'date': 'Thursday, 7 Mar 2025',
      'time': '11.00 - 12.30 PM',
      'image': AssetManger.container,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.propHeight(32)),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: context.propWidth(70)),
                  Text(
                    "Events",
                    style: context.textTheme.headlineMedium,
                  ),
                  //back
                ],
              ),
              SizedBox(height: context.propHeight(12)),
              _buildSearchAndCalender(),
              SizedBox(height: context.propHeight(24)),
              EventSlider(
                events: events
              ),
              SizedBox(height: context.propHeight(16)),
              _buildUpComingEvents(),
              SizedBox(height: context.propHeight(10)),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return UpComingEventCard(
                      event: upComingEvents[index],
                      onToggleAlert: () => toggleAlert(index),
                    );
                  },
                ),
              ),
              SizedBox(height: context.propHeight(24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Past Events",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: context.propHeight(10)),
              Container(
                 decoration: ShapeDecoration(
    color: Colors.white /* color-gray-10 */,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    shadows: [
      BoxShadow(
        color: Color(0x0F080F34),
        blurRadius: 42,
        offset: Offset(0, 14),
        spreadRadius: 0,
      )
    ],
  ),
                height: 500,
                child: ListView.builder(
                  itemCount: upComingEvents.length,
                  itemBuilder: (context, index) {
                    return PastEventCard(event: upComingEvents[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 
  Widget _buildSearchAndCalender() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search your course here....',
                      hintStyle: GoogleFonts.poppins(fontSize: 12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: context.propWidth(12)),
        const Icon(Icons.calendar_today_outlined, size: 25),
      ],
    );
  }


  Widget _buildUpComingEvents() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Upcoming Events',
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildMyCourses() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Your Courses',
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('See All',
            style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryColor)),
      ],
    );
  }
}
