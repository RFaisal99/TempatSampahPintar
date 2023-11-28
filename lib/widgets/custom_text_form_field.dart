import 'package:flutter/material.dart';
import 'package:stb/core/app_export.dart';

class CustomTextFormField extends StatefulWidget {
  final Alignment? alignment;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  final bool hideText;

  CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.hideText = true,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
      alignment: widget.alignment ?? Alignment.center,
      child: textFormFieldWidget,
    )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => Container(
    width: widget.width ?? double.maxFinite,
    margin: widget.margin,
    child: TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode ?? FocusNode(),
      autofocus: widget.autofocus!,
      style: widget.textStyle?.copyWith(
        color: Colors.black, // Set text color to black
      ) ??
          theme.textTheme.titleMedium?.copyWith(color: Colors.black),
      obscureText: widget.hideText ? _obscureText : false,
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      maxLines: widget.maxLines ?? 1,
      decoration: decoration,
      validator: widget.validator,
    ),
  );

  InputDecoration get decoration => InputDecoration(
    hintText: widget.hintText ?? "",
    hintStyle: widget.hintStyle ?? theme.textTheme.titleMedium,
    prefixIcon: widget.prefix,
    prefixIconConstraints: widget.prefixConstraints,
    suffixIcon: widget.hideText ? buildSuffixIcon() : null,
    suffixIconConstraints: widget.suffixConstraints,
    isDense: true,
    contentPadding: widget.contentPadding ?? EdgeInsets.all(14.h),
    fillColor: widget.fillColor ?? appTheme.gray100,
    filled: widget.filled,
    border: widget.borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(
            color: appTheme.gray200,
            width: 1,
          ),
        ),
    enabledBorder: widget.borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(
            color: appTheme.gray200,
            width: 1,
          ),
        ),
    focusedBorder: widget.borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(
            color: appTheme.gray200,
            width: 1,
          ),
        ),
  );

  Widget buildSuffixIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      child: Icon(
        _obscureText ? Icons.visibility : Icons.visibility_off,
      ),
    );
  }
}
