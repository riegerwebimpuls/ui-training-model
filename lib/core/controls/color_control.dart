import 'package:flutter/material.dart';
import 'package:ui_training_model/core/controls/control_label.dart';
import 'package:ui_training_model/core/property_binding.dart';

class ColorControl extends StatelessWidget {
  const ColorControl({super.key, required this.binding});

  final PropertyBinding<Color> binding;

  static const _palette = <Color>[
    Colors.teal,
    Colors.indigo,
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.blueGrey,
    Colors.amber,
    Colors.pink,
    Colors.black87,
    Colors.white,
  ];

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
            valueText: '#${value.toARGB32().toRadixString(16).padLeft(8, '0')}',
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final c in _palette)
                InkWell(
                  onTap: () => binding.setValue(c),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: value == c
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outlineVariant,
                        width: value == c ? 2.5 : 1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
