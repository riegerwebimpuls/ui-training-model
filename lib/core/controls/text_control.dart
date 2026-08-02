import 'package:flutter/material.dart';
import 'package:ui_training_model/core/controls/control_label.dart';
import 'package:ui_training_model/core/property_binding.dart';

class TextControl extends StatefulWidget {
  const TextControl({super.key, required this.binding});

  final PropertyBinding<String> binding;

  @override
  State<TextControl> createState() => _TextControlState();
}

class _TextControlState extends State<TextControl> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.binding.getValue());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ControlLabel(
            labelDe: widget.binding.labelDe,
            codeName: widget.binding.codeName,
            helpDe: widget.binding.helpDe,
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(isDense: true),
            onChanged: widget.binding.setValue,
          ),
        ],
      ),
    );
  }
}
