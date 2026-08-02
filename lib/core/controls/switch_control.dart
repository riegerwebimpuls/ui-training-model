import 'package:flutter/material.dart';
import 'package:ui_training_model/core/controls/control_label.dart';
import 'package:ui_training_model/core/property_binding.dart';

class SwitchControl extends StatelessWidget {
  const SwitchControl({super.key, required this.binding});

  final PropertyBinding<bool> binding;

  @override
  Widget build(BuildContext context) {
    final value = binding.getValue();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ControlLabel(
              labelDe: binding.labelDe,
              codeName: binding.codeName,
              helpDe: binding.helpDe,
              useCaseDe: binding.useCaseDe,
              valueText: value ? 'true' : 'false',
            ),
          ),
          Switch(value: value, onChanged: binding.setValue),
        ],
      ),
    );
  }
}
