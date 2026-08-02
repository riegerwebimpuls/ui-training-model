export 'color_control.dart';
export 'control_label.dart';
export 'enum_control.dart';
export 'number_control.dart';
export 'slider_control.dart';
export 'switch_control.dart';
export 'text_control.dart';

import 'package:flutter/material.dart';
import 'package:ui_training_model/core/controls/color_control.dart';
import 'package:ui_training_model/core/controls/enum_control.dart';
import 'package:ui_training_model/core/controls/number_control.dart';
import 'package:ui_training_model/core/controls/slider_control.dart';
import 'package:ui_training_model/core/controls/switch_control.dart';
import 'package:ui_training_model/core/controls/text_control.dart';
import 'package:ui_training_model/core/property_binding.dart';

/// Rendert das passende Control für ein [PropertyBinding].
Widget buildControlFor(PropertyBinding<dynamic> binding) {
  switch (binding.type) {
    case PropertyControlType.slider:
      return SliderControl(binding: binding as PropertyBinding<double>);
    case PropertyControlType.number:
      return NumberControl(binding: binding as PropertyBinding<double>);
    case PropertyControlType.switcher:
      return SwitchControl(binding: binding as PropertyBinding<bool>);
    case PropertyControlType.enumeration:
      return EnumControl(binding: binding);
    case PropertyControlType.color:
      return ColorControl(binding: binding as PropertyBinding<Color>);
    case PropertyControlType.text:
      return TextControl(binding: binding as PropertyBinding<String>);
  }
}
