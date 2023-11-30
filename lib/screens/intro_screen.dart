import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:gap/gap.dart';
import 'package:image_gallery/screens/home_screen.dart';
import 'package:image_gallery/utils/text_styles.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            FluentIcons.collections_add_24_filled,
            size: 40,
          ),
          const Gap(15),
          Center(
              child: Text(
            "Diskover",
            style: TextStyles.h1,
          )),
          const Gap(20),
          InkWell(
            onTap: () => {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeScreen()))
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
              // color: Theme.of(context).colorScheme.inversePrimary,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: Theme.of(context).colorScheme.inversePrimary),
              child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Start Exploring",
                      style: TextStyles.h4.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const Gap(16),
                    Icon(
                      FluentIcons.arrow_right_16_regular,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
