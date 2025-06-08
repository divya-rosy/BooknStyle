import 'package:booknstyle/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:booknstyle/presentation/views/authentication/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:booknstyle/domain/usecases/user_info/get_user_profile.dart';
import 'package:booknstyle/domain/usecases/user_info/save_user_profile.dart';
import 'package:provider/provider.dart';
import 'core/constant/strings.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'presentation/blocs/home/navbar_cubit.dart';
import 'presentation/blocs/user/user_bloc.dart';
import 'core/services/services_locator.dart' as di;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(di.sl);
  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final getUserProfileUseCase = di.sl<GetUserProfileUseCase>();
    final saveUserProfileUseCase = di.sl<SaveUserProfileUseCase>();
    return MultiBlocProvider(
      providers: [
        Provider<GetUserProfileUseCase>.value(value: getUserProfileUseCase),
        Provider<SaveUserProfileUseCase>.value(value: saveUserProfileUseCase),
        BlocProvider(
          create: (context) => di.sl<NavbarCubit>(),
        ),
        BlocProvider(create: (context) => UserProfileBloc(
        getUserProfile: context.read<GetUserProfileUseCase>(), 
        saveUserProfile: context.read<SaveUserProfileUseCase>()),),
        BlocProvider(
          create: (_) => di.sl<UserBloc>(),
        ),
      ],
      child: OKToast(
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AppRouter.home,            
            onGenerateRoute: AppRouter.onGenerateRoute,
            title: appTitle,
            home: SignUpScreen(),
            theme: AppTheme.lightTheme,
            builder: EasyLoading.init(),
          );
        }),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = true;
}
