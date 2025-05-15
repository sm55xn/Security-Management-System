import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldProfile extends StatelessWidget {
  const TextFormFieldProfile({
    Key? key,
    required this.hinttext,
    required this.labeltext,
    required this.iconData,
    this.mycontroller,
    required this.valid,
    required this.isNumber,
    this.obscureText,
    this.onTapIcon,
    required this.onChange, 
    required this.sizeText,
  }) : super(key: key);

  final String hinttext;
  final String labeltext;
  final int sizeText;
  final IconData iconData;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final String? Function(String?) onChange;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: SingleChildScrollView(
        // استخدام SingleChildScrollView هنا
        child: TextFormField(
         // textDirection: TextDirection.rtl,
          keyboardType: isNumber
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          decoration: InputDecoration(
                     
            suffixIcon: InkWell(child: Icon(iconData), onTap: onTapIcon),
            hintText: hinttext,
            hintTextDirection: TextDirection.rtl,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
            ),
            focusedBorder: const OutlineInputBorder(
              // ignore: unnecessary_const
              borderSide: const BorderSide(
                color: Color.fromARGB(184, 3, 204, 87),
              ),
            ),
            contentPadding: const EdgeInsets.all(8),
            labelText: labeltext,
          ),

          inputFormatters: [
            //final textInputFormatter = LengthLimitingTextInputFormatter(40) & WhitelistingTextInputFormatter(RegExp("[a-zA-Z\\s]"));
                     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\u0600-\u06FF\s]')),
                      LengthLimitingTextInputFormatter(40),
                            ],
          validator: valid,
          controller: mycontroller,
          obscureText:
              obscureText == null || obscureText == false ? false : true,
          onChanged: onChange,
        ),
      ),
    );
  }
}
