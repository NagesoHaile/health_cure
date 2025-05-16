import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final void Function(String)? onchanged;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final void Function()? onTap;
  final bool? enabled;
  const AppTextField({
    super.key,
    this.controller,
    required this.label,
    this.onchanged,
    this.onSaved,
    this.inputFormatter,
    this.validator,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.maxLength,
    this.onTap,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      inputFormatters: inputFormatter,
      style: Theme.of(context).textTheme.labelMedium,
      onTap: onTap,
      enabled: enabled,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        counterText: "",
        label: Text(label),
        hoverColor: Colors.black,
        prefix: prefix,
        prefixIcon: prefixIcon,
        suffix: suffix,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      onChanged: onchanged,
      onSaved: onSaved,
      validator: validator,
      obscureText: obscureText,
      maxLength: maxLength,
    );
  }
}
