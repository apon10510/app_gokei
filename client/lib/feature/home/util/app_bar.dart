import 'package:app_gokai/feature/home/util/container_search_bar.dart';
import 'package:app_gokai/core/advance/feedback.dart';
import 'package:flutter/material.dart';

class AppBarUtil extends StatelessWidget {
  const AppBarUtil({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ContainerSearchBarUtils(),
        IconButton(
          onPressed: () {
            feedback(context);
          },
          icon: const Icon(Icons.feedback),
        ),
      ],
    );
  }
}

// 27768810