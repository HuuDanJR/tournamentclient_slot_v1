import 'package:flutter/material.dart';
import 'package:tournament_client/utils/mycolors.dart';

class ConfirmationDialogWidget extends StatelessWidget {
  final String actionTitle;
  final VoidCallback onConfirmed;

  const ConfirmationDialogWidget({
    Key? key,
    required this.actionTitle,
    required this.onConfirmed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(actionTitle),
      content: const Text('Are you sure you want to proceed?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // User pressed NO
          },
          child: const Text('NO'),
        ),
        TextButton.icon(
          icon: Icon(Icons.add_sharp, color: MyColor.red_accent),
          onPressed: () {
            Navigator.of(context).pop(true); // User pressed YES
          },
          label: const Text('YES'),
        ),
      ],
    );
  }
}

Future<void> showConfirmationDialog(
  BuildContext context,
  String actionTitle,
  VoidCallback onConfirmed,
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return ConfirmationDialogWidget(
        actionTitle: actionTitle,
        onConfirmed: onConfirmed,
      );
    },
  );

  if (result == true) {
    onConfirmed(); // Call the action if the user pressed YES
  }
}