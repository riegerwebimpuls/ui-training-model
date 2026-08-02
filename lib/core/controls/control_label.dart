import 'package:flutter/material.dart';
import 'package:ui_training_model/theme/app_theme.dart';

/// Zeigt deutschen Hilfetext + Flutter-[codeName] + optionalen Live-Wert.
class ControlLabel extends StatelessWidget {
  const ControlLabel({
    super.key,
    required this.labelDe,
    required this.codeName,
    required this.helpDe,
    this.valueText,
  });

  final String labelDe;
  final String codeName;
  final String helpDe;
  final String? valueText;

  @override
  Widget build(BuildContext context) {
    final mono = Theme.of(context).extension<CodeNameStyle>()?.textStyle ??
        Theme.of(context).textTheme.bodySmall;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                labelDe,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            if (valueText != null)
              Text(
                valueText!,
                style: mono?.copyWith(color: scheme.primary),
              ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          codeName,
          style: mono?.copyWith(color: scheme.tertiary),
        ),
        const SizedBox(height: 2),
        Text(
          helpDe,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}
