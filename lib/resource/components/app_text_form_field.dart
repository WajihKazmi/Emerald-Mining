import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final bool? isPassword;
  final String? hintText;
  final TextInputType? keyboardType;
  Widget? prefixIcon;
  Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool readOnly;
  final void Function()? onTap;
  final Iterable<String>? autofillHints;
  final Color? fillColor;
  final bool obscureText;
  final String obscuringCharacter;
  final FocusNode? focusNode;

  AppTextFormField({
    Key? key,
    this.controller,
    this.isPassword,
    this.hintText,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.readOnly = false,
    this.onTap,
    this.autofillHints,
    this.fillColor,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.focusNode,
  }) : super(key: key);

  @override
  _AppTextFormFieldState createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late TextEditingController _controller;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _obscureText = widget.isPassword!;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isPassword == true) {
      widget.suffixIcon = InkWell(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: GradientBoxBorder(
              width: 2,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.onPrimaryContainer,
                  Theme.of(context).colorScheme.primary,
                ],
                begin: Alignment(0.5, 0),
                end: Alignment(0.5, 1),
              ))),
      child: TextFormField(
        obscureText: _obscureText,
        obscuringCharacter: widget.obscuringCharacter,
        scrollPadding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        autofillHints: widget.autofillHints,
        cursorOpacityAnimates: true,
        focusNode: widget.focusNode,
        onTapOutside: (event) {
          if (widget.focusNode != null) {
            widget.focusNode?.unfocus();
          } else {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        keyboardType: widget.keyboardType,
        textInputAction: TextInputAction.next,
        validator: widget.validator,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          suffixIcon: widget.suffixIcon,
          isDense: true,
          fillColor: Colors.transparent,
          border: InputBorder.none,
          filled: true,
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white.withOpacity(0.4),
              ),
        ),
        controller: _controller,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
