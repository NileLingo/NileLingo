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
                    HomeCubit.get(context).toggleFavorite(
                      userId,HomeCubit.get(context).translationId
                    );
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
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            HomeCubit.get(context).language1,
                            style: GoogleFonts.montserrat(
                              color: primaryTextColor,
                              fontSize: 18,
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
                                          ? getFileName(HomeCubit.get(context).path)
                                          : HomeCubit.get(context).sourceText,
                                      style: GoogleFonts.montserrat(
                                        color: secondaryTextColor,
                                        fontSize: 28,
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
                    SizedBox(height: 8.h),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 17.w),
                      child: Divider(
                        color: primaryColor,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    FadeInRight(
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              HomeCubit.get(context).language2,
                              style: GoogleFonts.montserrat(
                                color: primaryTextColor,
                                fontSize: 18,
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
                                            fontSize: 28,
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
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            HomeCubit.get(context).reset();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                          child: IntrinsicWidth(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.add, color: Colors.white, size: 25),
                                  SizedBox(width: 3.w),
                                  Text(
                                    "New translation",
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
