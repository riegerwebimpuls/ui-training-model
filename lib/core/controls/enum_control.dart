import 'package:flutter/material.dart';
import 'package:ui_training_model/core/controls/control_label.dart';
import 'package:ui_training_model/core/property_binding.dart';

class EnumControl<T> extends StatelessWidget {
  const EnumControl({super.key, required this.binding});

  final PropertyBinding<T> binding;

  @override
  Widget build(BuildContext context) {
    final values = binding.enumValues ?? const [];
    final labels = binding.enumLabels ?? values.map((e) => '$e').toList();
    final current = binding.getValue();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ControlLabel(
            labelDe: binding.labelDe,
            codeName: binding.codeName,
            helpDe: binding.helpDe,
            useCaseDe: binding.useCaseDe,
            valueText: '$current',
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<T>(
            key: ValueKey('enum-${binding.codeName}-$current'),
            initialValue: values.contains(current) ? current : null,
            items: [
              for (var i = 0; i < values.length; i++)
                DropdownMenuItem(value: values[i], child: Text(labels[i])),
            ],
            onChanged: (v) {
              if (v != null) binding.setValue(v);
            },
          ),
        ],
      ),
    );
  }
}
