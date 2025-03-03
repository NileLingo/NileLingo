import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/Constant.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String language1 = "EGY";
  String language2 = "ENG";

  Map<String, List<String>> history = {
    "Feb 7, 2025": ["Hello", "مرحبا", "Goodbye", "وداعا"],
    "Feb 8, 2025": ["Goodbye", "وداعا"],
    "Feb 9, 2025": ["Good Morning", "صباح الخير"],
    "Feb 10, 2025": ["Good Night", "تصبح على خير"],
    "Feb 11, 2025": ["Thank You", "شكرا لك"],
    "Feb 12, 2025": ["I Love You", "أنا أحبك"],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: primaryTextColor,
        ),
        backgroundColor: backgroundColor,
        title: Text(
          "History",
          style: GoogleFonts.montserrat(
            color: primaryTextColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 22),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: history.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key, // Date
                      style: GoogleFonts.montserrat(
                        color: primaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Column(
                      children: [
                        for (int i = 0; i < entry.value.length; i += 2)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        entry.value[i],
                                        style: GoogleFonts.montserrat(
                                          color: primaryTextColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      if (i + 1 < entry.value.length)
                                        Container(
                                          width: double.infinity,
                                          child: Text(
                                            entry.value[i + 1],
                                            style: GoogleFonts.montserrat(
                                              color: primaryTextColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                 SizedBox(width: 5.w),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}