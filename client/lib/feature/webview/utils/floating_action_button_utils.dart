import 'package:app_gokai/feature/webview/package/draggable_expandable_fab.dart';
import 'package:flutter/material.dart';


class FloatingActionButtonUtils extends StatelessWidget {
    final Function() onReload1;
  final Function() onReload2;
  const FloatingActionButtonUtils({super.key, required this.onReload1, required this.onReload2});

  @override
  Widget build(BuildContext context) {
    return ExpandableDraggableFab(
      childrenCount: 2,
      distance: 5,
      childrenType: ChildrenType.columnChildren,
      childrenAlignment: Alignment.centerRight,
      children: [
        IconButton(
          tooltip: 'Close',
          onPressed: onReload1,
          icon: Icon(Icons.close),
        ),
        IconButton(
            tooltip: 'Reload',
            onPressed: onReload2,
            icon: Icon(Icons.refresh)),
      ],
    );
  }
}