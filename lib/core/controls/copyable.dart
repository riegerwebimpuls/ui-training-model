import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Kopiert [text] und zeigt kurz eine Bestätigung.
Future<void> copyTextToClipboard(
  BuildContext context,
  String text, {
  String feedback = 'Kopiert',
}) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (!context.mounted) return;
  final messenger = ScaffoldMessenger.maybeOf(context);
  messenger?.clearSnackBars();
  messenger?.showSnackBar(
    SnackBar(
      content: Text(feedback),
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

/// Kompakter One-Tap-Copy-Button (z. B. neben einem `codeName`).
class CopyTextIconButton extends StatelessWidget {
  const CopyTextIconButton({
    super.key,
    required this.text,
    this.tooltip = 'Kopieren',
    this.feedback = 'Kopiert',
  });

  final String text;
  final String tooltip;
  final String feedback;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      padding: EdgeInsets.zero,
      iconSize: 16,
      onPressed: text.isEmpty
          ? null
          : () => copyTextToClipboard(context, text, feedback: feedback),
      icon: const Icon(Icons.copy_outlined),
    );
  }
}
