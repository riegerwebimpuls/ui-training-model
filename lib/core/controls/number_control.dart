import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_training_model/core/controls/control_label.dart';
import 'package:ui_training_model/core/property_binding.dart';

class NumberControl extends StatefulWidget {
  const NumberControl({super.key, required this.binding});

  final PropertyBinding<double> binding;

  @override
  State<NumberControl> createState() => _NumberControlState();
}

class _NumberControlState extends State<NumberControl> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.binding.getValue().toString(),
    );
  }

  @override
  void didUpdateWidget(covariant NumberControl oldWidget) {
    super.didUpdateWidget(oldWidget);
    final next = widget.binding.getValue().toString();
    if (_controller.text != next && !_controller.selection.isValid) {
      _controller.text = next;
    } else if (_controller.text != next &&
        !_controller.value.composing.isValid) {
      final selection = _controller.selection;
      _controller.value = TextEditingValue(
        text: next,
        selection: selection.baseOffset <= next.length
            ? selection
            : TextSelection.collapsed(offset: next.length),
      );
    }
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
            valueText: widget.binding.getValue().toString(),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.\-]')),
            ],
            decoration: const InputDecoration(isDense: true),
            onChanged: (raw) {
              final parsed = double.tryParse(raw);
              if (parsed != null) {
                widget.binding.setValue(parsed);
              }
            },
          ),
        ],
      ),
    );
  }
}
