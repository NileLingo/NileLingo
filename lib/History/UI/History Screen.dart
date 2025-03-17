import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/Constant.dart';
import '../Cubit/History Cubit.dart';
import '../Cubit/History States.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      HistoryCubit.get(context).fetchUserTranslations(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final historyData = HistoryCubit.get(context).translations;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            iconTheme: IconThemeData(color: primaryTextColor),
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
          body: state is HistoryLoadingState
              ? Center(
            child: SpinKitCircle(
              color: primaryColor,
              size: 70,
            ),
          )
              : historyData.isEmpty
              ? _buildNoTranslationsFound()
              : _buildTranslationList(historyData),
        );
      },
    );
  }

  Widget _buildNoTranslationsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.fileCircleXmark,
            size: 60,
            color: Colors.grey.shade500,
          ),
          SizedBox(height: 2.h),
          Text(
            "No translations found",
            style: GoogleFonts.montserrat(
              color: Colors.grey.shade600,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslationList(List<dynamic> historyData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 22),
      child: ListView.builder(
        itemCount: historyData.length,
        itemBuilder: (context, index) {
          final translation = historyData[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formatDate(translation['date']),
                style: GoogleFonts.montserrat(
                  color: primaryTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 0.5.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Text(
                      translation['src_text'],
                      style: GoogleFonts.montserrat(
                        color: primaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(width: 5.w),

                  Expanded(
                    child: Text(
                      translation['tgt_text'],
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

              SizedBox(height: 0.5.h),

              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    translation['favorite'] == true
                        ? FontAwesomeIcons.solidStar
                        : FontAwesomeIcons.star,
                    color:  primaryColor,
                    size: 20,
                  ),
                ),
              ),

              SizedBox(height: 2.h), // Space between entries
            ],
          );
        },
      ),
    );
  }
  String _formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return "${_monthName(date.month)} ${date.day}, ${date.year}";
  }

  String _monthName(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month - 1];
  }
}
