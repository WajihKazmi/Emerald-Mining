import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/resource/components/machine_widget.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/view_model/services/user_view_model.dart';
import 'package:emerald_mining/view_model/user_machine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';

class MyMiningMachinesScreen extends StatefulWidget {
  const MyMiningMachinesScreen({super.key});

  @override
  State<MyMiningMachinesScreen> createState() => _MyMiningMachinesScreenState();
}

class _MyMiningMachinesScreenState extends State<MyMiningMachinesScreen> {
  @override
  void initState() {
    super.initState();
    // Load the data when the screen initializes
    Provider.of<UserMachineViewModel>(context, listen: false).loadData(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 6, 40, 32),
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
          Consumer<UserMachineViewModel>(
            builder: (context, provider, child) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    expandedHeight: 100.0,
                    floating: true,
                    centerTitle: true,
                    title: Text(
                      'My Mining Machines',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white.withOpacity(
                            1,
                          ),
                          fontWeight: FontWeight.w600),
                    ),
                    leadingWidth: 80,
                    leading: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 5),
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
                          ),
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          AppNavigator.pop(context);
                        },
                        icon: Image.asset(
                          AppImages.menu,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  if (provider.Loading)
                    const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (provider.userMachines.isEmpty)
                    SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'No mining machines available.',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                          ),
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 40),
                            child: MachineWidget2(
                              machine: provider.userMachines[index].machine,
                              userInvites: user.user.successfulInvites,
                            ),
                          );
                        },
                        childCount: provider.userMachines.length,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
