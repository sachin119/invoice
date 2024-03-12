import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {this.fieldKey,
        this.hintText,
        this.mandatory = false,
        this.labelText,
        this.helperText,
        this.onSaved,
        this.validator,
        this.onFieldSubmitted,
        this.filled,
        this.prefixIcon,
        this.controller,
        this.enabled,
        this.focusNode,
        this.textCapitalization,
        this.onTap,
        this.maxLines,
        this.initialValue,
        this.style,
        this.maxLength,
        this.inputType,
        this.keyboardType});

  final TextInputType? inputType;

  final Key? fieldKey;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final bool? filled;
  final Icon? prefixIcon;
  final bool? mandatory;
  final TextEditingController? controller;
  final bool? enabled;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final GestureTapCallback? onTap;
  final int? maxLines;
  final String? initialValue;
  final TextStyle? style;
  final int? maxLength;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: 800
      ),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType ?? TextInputType.text,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        focusNode: focusNode,
        enabled: enabled,
        key: fieldKey,
        controller: controller,
        onSaved: onSaved,
        validator: validator,
        onTap: onTap,
        onFieldSubmitted: onFieldSubmitted,
        maxLines: maxLines,
        style: style,
        maxLength: maxLength,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
          filled: filled,
          hintText: hintText,
          labelText: labelText,
          helperText: helperText,
        ),
      ),
    );
  }
}
