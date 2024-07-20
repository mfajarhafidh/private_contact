import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testtrinity/domain/core/constants/color_constants.dart';
import 'package:testtrinity/domain/core/constants/text_style_constants.dart';

enum TextFieldState { focus, error, disabled, none }

class TextFieldUtils extends StatefulWidget {
  const TextFieldUtils({
    Key? key,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.color,
    this.textColor = ColorConstants.black,
    this.margin,
    this.padding,
    this.enable = true,
    this.disableShadow = false,
    this.enableBorderline = false,
    this.reduceBorderRadius = false,
    this.controller,
    this.validation,
    this.inputFormatters,
    this.hint = 'Type Here...',
    this.validationText = "",
    this.textStyle,
    this.hintStyle,
    this.errorTextStyle,
    this.keyboardType,
    this.maxLength = 1000,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.obsecureText = false,
    this.cursorColor = ColorConstants.blue,
    this.suffixWidget,
    this.isReadOnly = false,
    this.isMaxlines = false,
    this.requiredText = false,
    this.textInputAction,
  }) : super(key: key);

  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? color;
  final Color textColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool enable;
  final bool disableShadow;
  final bool enableBorderline;
  final bool reduceBorderRadius;
  final TextEditingController? controller;
  final bool? Function(String value)? validation;
  final List<TextInputFormatter>? inputFormatters;
  final String hint;
  final String validationText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorTextStyle;
  final TextInputType? keyboardType;
  final int maxLength;
  final ValueSetter<String>? onChanged;
  final TextCapitalization textCapitalization;
  final bool obsecureText;
  final Color cursorColor;
  final Widget? suffixWidget;
  final bool isReadOnly;
  final bool isMaxlines;
  final bool requiredText;
  final TextInputAction? textInputAction;

  @override
  State<TextFieldUtils> createState() => _TextFieldUtilsState();
}

class _TextFieldUtilsState extends State<TextFieldUtils> {
  TextFieldState tState = TextFieldState.none;
  bool isValid = true;
  bool isFocus = false;
  List<TextInputFormatter> formatter = [];

  @override
  void initState() {
    super.initState();
    if (widget.inputFormatters == null) {
      formatter.add(LengthLimitingTextInputFormatter(widget.maxLength));
    } else {
      formatter = widget.inputFormatters!;
      formatter.add(LengthLimitingTextInputFormatter(widget.maxLength));
    }
  }

  _decor() {
    switch (tState) {
      case TextFieldState.focus:
        return _outline(borderColor: ColorConstants.blue);
      case TextFieldState.error:
        return _outline(borderColor: Colors.red);
      case TextFieldState.disabled:
        return _outline(borderColor: Colors.black);
      default:
        return _outline(borderColor: ColorConstants.darkGray);
    }
  }

  _outline({required Color borderColor}) {
    return BoxDecoration(
      color: !widget.enable
          ? Colors.grey[100]
          : widget.color ?? Colors.transparent,
      borderRadius: BorderRadius.circular(15.r),
      border: Border.all(width: 1, color: borderColor),
    );
  }

  _onFocusChange(bool value) {
    setState(() {
      isFocus = value;
      if (!isValid) {
        tState = TextFieldState.error;
      } else if (value) {
        tState = TextFieldState.focus;
      } else {
        tState = TextFieldState.none;
      }
    });
  }

  _onChanged(String value) async {
    if (widget.validation != null) {
      setState(
        () {
          isValid = widget.validation!(value)!;
          if (!isValid) {
            tState = TextFieldState.error;
          } else {
            if (isFocus) {
              tState = TextFieldState.focus;
            } else {
              tState = TextFieldState.none;
            }
          }
        },
      );
    }

    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: widget.requiredText == true
                ? RichText(
                    text: TextSpan(
                        style: TextStyleConstants.defaultText,
                        children: [
                          TextSpan(
                            text: widget.label,
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyleConstants.defaultText
                                .copyWith(color: ColorConstants.red),
                          ),
                        ]),
                  )
                : Text(
                    widget.label!,
                    style: TextStyleConstants.defaultText,
                  ),
          ),
        10.verticalSpace,
        Container(
          width: Get.width,
          decoration: _decor(),
          child: Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: Center(
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Focus(
                    child: TextField(
                      textInputAction: widget.textInputAction,
                      maxLines: widget.isMaxlines ? null : 1,
                      enabled: widget.enable,
                      readOnly: widget.isReadOnly,
                      controller: widget.controller,
                      style: widget.textStyle ??
                          TextStyleConstants.defaultText.copyWith(),
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: widget.keyboardType ?? TextInputType.text,
                      textCapitalization: widget.textCapitalization,
                      obscureText: widget.obsecureText,
                      decoration: inputDecoration(
                        prefixIcon: widget.prefixIcon,
                        hintText: widget.hint,
                        suffixIcon: widget.suffixIcon,
                        hintStyle: widget.hintStyle,
                      ),
                      cursorColor: widget.cursorColor,
                      onChanged: _onChanged,
                      inputFormatters: formatter,
                    ),
                    onFocusChange: _onFocusChange,
                  ),
                  if (widget.suffixWidget != null)
                    Positioned(
                      right: 4,
                      child: GestureDetector(
                        onTap: () {},
                        child: widget.suffixWidget,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (!isValid && widget.validationText.isNotEmpty)
          Text(widget.validationText,
              style: widget.errorTextStyle ??
                  TextStyleConstants.defaultText
                      .copyWith(color: ColorConstants.red)),
      ],
    );
  }

  InputDecoration inputDecoration({
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextStyle? hintStyle,
  }) {
    return InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      hintText: hintText,
      border: InputBorder.none,
      errorMaxLines: 5,
      prefixIcon: prefixIcon,
      prefixIconConstraints: BoxConstraints(minHeight: 44.h, minWidth: 44.w),
      suffixIconConstraints: BoxConstraints(minHeight: 44.h, minWidth: 44.w),
      suffixIcon: suffixIcon,
      hintStyle: hintStyle ??
          TextStyleConstants.thinText
              .copyWith(fontSize: 14.sp, color: ColorConstants.darkGray),
    );
  }
}
