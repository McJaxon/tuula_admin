import 'package:admin_banja/controllers/dashboard_controller.dart';
import 'package:admin_banja/controllers/home_page_controller.dart';
import 'package:admin_banja/screens/app_data.dart';
import 'package:admin_banja/screens/auth/payouts.dart';
import 'package:admin_banja/screens/dash.dart';
import 'package:admin_banja/screens/paymets.dart';
import 'package:admin_banja/screens/user_and_roles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SliderView extends StatelessWidget {
  SliderView({
    Key? key,
  }) : super(key: key);

  //final UserDetailsController userDetails = Get.find();
  var homeController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
          colors: [
            Color.fromARGB(255, 0, 101, 81),
            Color.fromARGB(255, 141, 226, 246)
          ],
        ),
      ),
      padding: EdgeInsets.only(top: 30.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/tuula_logo.png',
              width: 110.w,
            ),
            SizedBox(
              height: 20.h,
            ),

            SizedBox(
              height: 40.h,
            ),
            Text(
              'Menu',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 25.sp,
                  fontFamily: 'Poppins'),
            ),
            SizedBox(
              height: 20.h,
            ),
            Divider(
              endIndent: 30.w,
              color: Colors.white54,
            ),
            SizedBox(
              height: 20.h,
            ),
            const Spacer(),
            _SliderMenuItem(
                canPop: true,
                title: 'Home',
                iconData: 'Home',
                screen: const Dash()),
            _SliderMenuItem(
                title: 'Payments',
                iconData: 'Wallet',
                screen: const PaymentsPage()),
            // _SliderMenuItem(
            //     title: 'Referrals',
            //     iconData: 'Discount',
            //     screen: const Slips()),
            _SliderMenuItem(
                title: 'App Data',
                iconData: 'Paper Download',
                screen: const AppData()),
            _SliderMenuItem(
                title: 'User Management',
                iconData: 'Chart',
                screen: const UserRoles()),
            _SliderMenuItem(
                title: 'Transfers', iconData: 'Chart', screen: const Payout()),
            const Spacer(),

            // _SliderMenuItem(
            //     logout: true,
            //     title: 'Log out',
            //     iconData: 'Logout',
            //     screen: const RegisterPage()),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final String iconData;
  final Widget? screen;
  final bool canPop, logout;

  _SliderMenuItem(
      {Key? key,
      this.canPop = false,
      this.logout = false,
      required this.title,
      required this.iconData,
      this.screen})
      : super(key: key);

  DashboardController dashController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListTile(
        textColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 4,
        title: Text(title, style: const TextStyle(fontFamily: 'Poppins')),
        leading: SvgPicture.asset(
          'assets/images/$iconData.svg',
          color: Colors.white,
        ),
        onTap: () {
          HapticFeedback.lightImpact();
          if (logout) {
            GetStorage().erase();
          }

          if (canPop) {
            dashController.sliderKey.currentState?.closeSlider();
          } else {
            GetStorage().erase();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => screen!));
          }
        });
  }
}
