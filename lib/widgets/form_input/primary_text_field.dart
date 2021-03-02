import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/style_decoration.dart';
import '../../utils/form_validator.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget prefixIcon;
  final String Function(String) validator;
  final void Function(String) onChanged;
  final double marginBottom;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final VoidCallback onTap;
  final bool isRequired;
  final bool obsecure;
  final bool readOnly;
  final int maxLines;
  final String label;
  final int lengthValidator;

  const PrimaryTextField({
    Key key,
    @required this.controller,
    this.hint = "",
    this.prefixIcon,
    this.validator,
    this.obsecure = false,
    this.isRequired = true,
    this.marginBottom = 16,
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.onTap,
    this.readOnly,
    this.maxLines = 1,
    this.label,
    this.lengthValidator,
    this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text("$label ${isRequired ? "*" : ""}", style: kTitleStyle.medium)
                .paddingValue(horizontal: 4),
            SpaceY(),
          ],
          TextFormField(
            keyboardType: textInputType,
            textCapitalization: textCapitalization,
            controller: controller,
            autocorrect: false,
            maxLines: maxLines,
            onChanged: onChanged,
            readOnly: readOnly ?? onTap != null ? true : false,
            obscureText: obsecure,
            onTap: onTap,
            validator: isRequired
                ? (value) {
                    if (validator != null) return validator(value);
                    return FormValidator.validateField(
                      value,
                      field: label ?? hint,
                      length: lengthValidator,
                    );
                  }
                : null,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(),
              prefixIcon: prefixIcon,
              //labelText: label,
            ),
          ),
        ],
      ),
    );
  }
}
