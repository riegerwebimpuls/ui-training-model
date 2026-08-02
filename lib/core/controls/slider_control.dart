import 'package:flutter/material.dart';
import 'package:ui_training_model/core/controls/control_label.dart';
import 'package:ui_training_model/core/property_binding.dart';

class SliderControl extends StatelessWidget {
  const SliderControl({super.key, required this.binding});

  final PropertyBinding<double> binding;

  @override
  Widget build(BuildContext context) {
    final value = binding.getValue();
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
            valueText: value.toStringAsFixed(2),
          ),
          Slider(
            value: value.clamp(binding.min ?? 0, binding.max ?? 1),
            min: binding.min ?? 0,
            max: binding.max ?? 1,
            divisions: binding.divisions,
            label: value.toStringAsFixed(2),
            onChanged: binding.setValue,
          ),
        ],
      ),
    );
  }
}
