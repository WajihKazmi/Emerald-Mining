import 'package:emerald_mining/resource/components/app_button.dart';
import 'package:emerald_mining/resource/components/app_text_form_field.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/view/notification_view.dart';
import 'package:emerald_mining/view_model/send_invite_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isInviteVisible = false; // Track visibility of the invite form

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose(); // Properly dispose of the controller
    super.dispose();
  }

  void toggleInviteVisibility() {
    setState(() {
      if (!isInviteVisible) {
        emailController = TextEditingController(); // Reinitialize controller
      } else {
        emailController.dispose(); // Dispose controller when hiding
      }
      isInviteVisible = !isInviteVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 6, 40, 32),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Invite Friends',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.white.withOpacity(1), fontWeight: FontWeight.w600),
        ),
        leadingWidth: 80,
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          decoration: BoxDecoration(
            border: GradientBoxBorder(
                width: 1.5,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.onPrimaryContainer,
                    Theme.of(context).colorScheme.primary,
                  ],
                  begin: const Alignment(0.5, 0),
                  end: const Alignment(0.1, 1),
                )),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Image.asset(
              AppImages.menu,
              fit: BoxFit.fill,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NotificationScreen(),
              ));
            },
            icon: Image.asset(
              AppImages.notification,
              fit: BoxFit.fill,
            ),
          ),
          6.horizontalSpace,
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            AppImages.bg2,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            colorBlendMode: BlendMode.color,
            color: const Color.fromARGB(255, 6, 51, 29),
            isAntiAlias: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  (35 + kToolbarHeight).verticalSpace,
                  Text(
                    'You and your friend will receive Bonus',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white.withOpacity(1),
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // Image.asset(
                              //   AppImages.photo,
                              //   scale: 0.9,
                              // ),
                              10.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Invite a Friend"),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        AppImages.emerald,
                                        scale: 1.2,
                                      ),
                                      const Text(
                                        "  +5000 Coin",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      2.horizontalSpace,
                                      Text(
                                        'for You and your friend',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color: Colors.white
                                                    .withOpacity(0.9),
                                                fontSize: 9),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: toggleInviteVisibility,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.h),
                                  gradient: LinearGradient(
                                    begin: const Alignment(1.06, 0),
                                    end: const Alignment(-0.08, 0),
                                    colors: [
                                      Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      Theme.of(context).colorScheme.primary
                                    ],
                                  )),
                              child: Text(
                                isInviteVisible ? 'Close' : 'Invite Now',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Show text field when the button is pressed
                  isInviteVisible
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              AppTextFormField(
                                controller: emailController,
                                hintText: "Enter email",
                                validator: emailValidator,
                                isPassword: false,
                              ),
                              const SizedBox(height: 20),
                              Consumer<SendInviteViewModel>(
                                builder: (context, inviteViewModel, child) {
                                  return AppButton.getButton(
                                      context: context,
                                      onPressed: () {
                                        inviteViewModel.sendInviteApi(
                                          context,
                                          emailController.text,
                                        );
                                        emailController.clear();
                                      },
                                      child: Text(
                                        "Send Invite",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Colors.white),
                                      ),
                                      loading:
                                          inviteViewModel.sendInviteLoading);
                                },
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email.';
    }
    if (!validateEmail(email)) {
      return 'Please enter a valid email.';
    }
    return null;
  }
}
