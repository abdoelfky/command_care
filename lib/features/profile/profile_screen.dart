import 'package:command_care/features/help/presentation/UserHelpScreen.dart';
import 'package:command_care/features/settings/change_password.dart';
import 'package:command_care/features/user/home/controllers/bottom_nav_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/constants/app_images.dart';
import 'package:command_care/core/shared_preferences/shared_preferences.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:command_care/core/widgets/background_screen.dart';
import 'package:command_care/core/widgets/primary_app_bar.dart';
import 'package:command_care/features/auth/controllers/auth_provider.dart';
import '../settings/profile_settings/presentation/EditProfileScreen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PrimaryAppBar(
        title: 'Good Afternoon, ${AppSettingsPreferences().name}',
      ),
      body: BackgroundScreen(
        child: Stack(
          children: [
            // Profile header
            SizedBox(
              height: Dimensions.imgHeightDefault,
              child: profileHeader(context),
            ),
            // Scrollable content
            Positioned.fill(
              top: Dimensions.profileTileDefault,
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    // buildListTile("Help", Icons.privacy_tip, () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (_) => HelpScreen(),
                    //     ),
                    //   );
                    // }),

                    buildListTile(
                        // Colors.black,
                        "Delete my account",
                        Icons.delete_outline_outlined, () async {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                elevation: 24.0,
                                title: const Text(
                                  'Are you sure',
                                ),
                                content: const Text(
                                    'We can\'t recover your account again'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        var user =
                                            FirebaseAuth.instance.currentUser;
                                        if (user != null) {
                                          user.delete().then((value) async {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'account deleted successfully',
                                                ),
                                                backgroundColor:
                                                    AppColors.successColor,
                                              ),
                                            );
                                            ref
                                                .read(
                                                    firebaseAuthServiceProvider)
                                                .signOut(context);

                                            // FbAuthController().signOut();
                                          }).catchError((onError) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'account delete failed: ${onError.toString()}')),
                                            );
                                          });
                                        }
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 1.0, horizontal: 15),
                                    child: Container(
                                      width: double.infinity,
                                      height: 0.4,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  CupertinoDialogAction(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ));
                    }),
                    buildListTile(
                      // Colors.black,
                        "Change password",
                        Icons.lock_outlined, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ChangePasswordScreen()));
                    }),
                    buildListTile("Log Out", Icons.exit_to_app, () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            elevation: 24.0,
                            title: Center(
                              child: Text(
                                'Are you sure?',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.black),
                              ),
                            ),
                            content: Text(
                              'You will be logged out from your account.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            actions: [
                              TextButton(
                                child: Text(
                                  'Log Out',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.red),
                                ),
                                onPressed: () {
                                  ref
                                      .read(firebaseAuthServiceProvider)
                                      .signOut(context)
                                      .then((onValue) {
                                    ref
                                        .read(bottomNavProvider.notifier)
                                        .selectIndex(0);
                                  });
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ));
                    }),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget profileHeader(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => EditProfileScreen()));
    },
    child: Stack(
      children: [
        Stack(
          children: [
            Image.asset(
              AppImages.bannerImg3, // Replace with the image path
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
              // Black layer with 50% opacity
              width: double.infinity,
              height: double.infinity,
            ),
          ],
        ),
        Positioned(
          right: 0,
          left: 0,
          top: Dimensions.paddingSizeSmall,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.whiteColor,
                backgroundImage: AssetImage(AppImages.user),
              ),
              SizedBox(height: 10),
              Text(
                AppSettingsPreferences().name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.whiteColor),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildListTile(String title, IconData icon, VoidCallback onTapHandler) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 7),
    child: Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(10)),
      ),
      elevation: 5.0,
      child: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(
              icon,
              size: 20, // Adjust the size of the icon as needed
              color: AppColors.primaryColor, // Adjust icon color if needed
            ),
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16, // Size of the arrow icon
            ),
            onTap: onTapHandler,
          ),
        ),
      ),
    ),
  );
}
