import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nile_lingo/Home%20Page/Cubit/Home%20States.dart';
import 'package:sizer/sizer.dart';
import '../Constants/Constant.dart';
import '../History/UI/History Screen.dart';
import '../Home Page/Cubit/Home Cubit.dart';
import '../Home Page/UI/Home Screen.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            actions: [
              FadeInRight(
                duration: const Duration(milliseconds: 500),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HistoryScreen()),
                          );
                        },
                        icon: Icon(
                          Icons.account_circle_outlined,
                          color: secondaryTextColor,
                          size: 30,
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                  onPressed: () {
                    HomeCubit.get(context).toggleFavourite();
                  },
                  icon: FaIcon(
                    HomeCubit.get(context).isFavourite
                        ? FontAwesomeIcons.solidStar
                        : FontAwesomeIcons.star,
                    color:  secondaryTextColor,
                    size: 25,
                  )
                ),
              ),

            ],
          ),
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 22),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 45),
                      decoration: BoxDecoration(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            HomeCubit.get(context).language1,
                            style: GoogleFonts.montserrat(
                              color: primaryTextColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      HomeCubit.get(context).isAudioInput
                                          ? HomeCubit.get(context).audioFilePath // Show file path if audio input
                                          : truncateFileName(HomeCubit.get(context).sourceText, 1000),
                                      style: GoogleFonts.montserrat(
                                        color: secondaryTextColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              if (HomeCubit.get(context).isAudioInput) // Show icon only for audio input
                                IconButton(
                                  onPressed: () {
                                    HomeCubit.get(context).togglePlaying(isSource: true);
                                  },
                                  icon: Icon(
                                    HomeCubit.get(context).isPlaying ? Icons.pause : Icons.volume_up,
                                    color: primaryColor,
                                    size: 35,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.5.h),
                    FadeInRight(
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              HomeCubit.get(context).language2,
                              style: GoogleFonts.montserrat(
                                color: primaryTextColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start, // Aligns items to the top
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          HomeCubit.get(context).togglePlaying(isSource: false);
                                        },
                                        icon: Icon(
                                          HomeCubit.get(context).isResultPlaying
                                              ? Icons.pause
                                              : Icons.volume_up,
                                          color: primaryColor,
                                          size: 35,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10), // Adds spacing between icon and text
                                  Expanded( // Ensures text wraps properly
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          HomeCubit.get(context).translation,
                                          style: GoogleFonts.montserrat(
                                            color: secondaryTextColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          softWrap: true, // Allows text to wrap
                                          overflow: TextOverflow.visible, // Ensures text doesn't get clipped
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        "Cultural insights",
                        style: GoogleFonts.montserrat(
                          color: primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.5.h),
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: fillColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Another sentence that can be used for greating someone",
                              style: GoogleFonts.montserrat(
                                color: secondaryTextColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      HomeCubit.get(context).togglePlaying(isSource: false);
                                    },
                                    icon: Icon(
                                    Icons.volume_up,
                                      color: primaryColor,
                                      size: 30,
                                    )),
                                Expanded(
                                  child: Text(
                                    "عامل ايه ؟ (? meaning : how are you)",
                                    style: GoogleFonts.montserrat(
                                      color: secondaryTextColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.volume_up,
                                      color: primaryColor,
                                      size: 30,
                                    )),
                                Expanded(
                                  child: Text(
                                    "عامل ايه ؟ (? meaning : how are you)",
                                    style: GoogleFonts.montserrat(
                                      color: secondaryTextColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Note: ",
                                    style: GoogleFonts.montserrat(
                                      color: primaryColor,
                                      // Change this to your desired color
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "this phrase can’t be translated literally",
                                    style: GoogleFonts.montserrat(
                                      color: secondaryTextColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "See more details",
                                  style: GoogleFonts.montserrat(
                                    color: primaryTextColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
