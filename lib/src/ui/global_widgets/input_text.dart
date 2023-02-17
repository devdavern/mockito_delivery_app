import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import 'custom_form.dart';

class InputText extends StatefulWidget {
  final String? Function(String)? validator;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final Widget prefixIcon;
  final bool obscureText;
  final String label;

  const InputText({
    this.obscureText = false,
    required this.prefixIcon,
    required this.textInputAction,
    required this.label,
    this.keyboardType,
    this.onSubmitted,
    this.onChanged,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  State<InputText> createState() => InputTextState();
}

class InputTextState extends State<InputText> {
  late bool _obscureText;
  CustomFormState? _formState;
  String? get errorText => _errorText;
  String? _errorText = '';

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formState = CustomForm.formOf(context);
      //if (_formState != null) print('FORM STATE');
      _formState?.register(this);
    });
  }

  @override
  void deactivate() {
    _formState?.remove(this);
    super.deactivate();
  }

  void _validate(String text) {
    if (widget.validator != null) {
      _errorText = widget.validator!(text);
      setState(() {});
    }

    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

  void _onVisibleChanged() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: TextField(
        onChanged: _validate,
        obscureText: _obscureText,
        onSubmitted: widget.onSubmitted,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          label: Text(widget.label),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.obscureText
              ? CupertinoButton(
                  minSize: 20,
                  onPressed: _onVisibleChanged,
                  padding: const EdgeInsets.all(8),
                  child: _obscureText
                      ? const Icon(Icons.visibility_off_outlined,
                          color: Colors.grey)
                      : const Icon(Icons.visibility_outlined),
                )
              : Icon(
                  Icons.check_circle_outline,
                  color: _errorText == null ? primaryColor : Colors.grey,
                ),
        ),
      ),
    );
  }
}
