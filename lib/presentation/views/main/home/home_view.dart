import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constant/images.dart';
import '../../../../core/router/app_router.dart';
import '../../../blocs/user/user_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController scrollController = ScrollController();

  void _scrollListener() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    double scrollPercentage = 0.7;
    if (currentScroll > (maxScroll * scrollPercentage)) {
  
    }
  }

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: (MediaQuery.of(context).padding.top + 10),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                    if (state is UserLogged) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRouter.userProfile);
                              },
                              child: Text(
                                "${state.user.firstName} ${state.user.lastName}",
                                style: TextStyle(fontSize: 18.sp),
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRouter.userProfile);
                              },
                              child: state.user.image != null
                                  ? CachedNetworkImage(
                                      imageUrl: state.user.image!,
                                      imageBuilder: (context, image) =>
                                          CircleAvatar(
                                        radius: 18.sp,
                                        backgroundImage: image,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 18.sp,
                                      backgroundImage: AssetImage(kUserAvatar),
                                      backgroundColor: Colors.transparent,
                                    ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Welcome",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.sp,
                                ),
                              ),
                              Text(
                                " booknstyle",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRouter.signIn);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 24.0,
                                backgroundImage: AssetImage(kUserAvatar),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 1.h,
                    left: 6.w,
                    right: 6.w,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: 55,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
