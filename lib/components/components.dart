import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navigateTo(context, nextPage) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );

void navigateAndFinish(context, nextPage) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => nextPage),
    (route) => false);

Widget defaultTextField({
  required String labeltxt,
  required Icon prefixicon,
  bool isPass = false,
  IconData? suffix,
  TextEditingController? controller,
  required TextInputType txtinput,
  Function()? SuffixPressed,
  Function(String val)? onSubmit,
  Function(String value)? valid,
  TextStyle? hintStyle,
}) {
  return TextFormField(
    keyboardType: txtinput,
    controller: controller,
    onFieldSubmitted: onSubmit,
    obscureText: isPass,
    decoration: InputDecoration(hintStyle: hintStyle,
      fillColor: Colors.white,
      filled: true,
      hintText: labeltxt,
      border: InputBorder.none,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.white,
          width: 10
        ),
      ),

      focusedBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
            color: Colors.white,
            width: 10
        ),
      ),
      prefixIcon: prefixicon,
      suffixIcon: IconButton(
        icon: Icon(suffix),
        onPressed: SuffixPressed,
      ),
    ),
    validator: (value) {
      valid!;
    },
  );
}

Widget defaultText(
        {required String text,
        double? fontsize,
        isUpperCase = false,
        textColor,
        double? textHeight,linesMax,TextOverflow? textOverflow,FontStyle? fontStyle,TextStyle? hintStyle,TextAlign? textAlign}) =>
    Text(
      isUpperCase ? text.toUpperCase() : text,
      maxLines:linesMax,
      overflow: textOverflow,
      textAlign: textAlign,
      style:
          TextStyle(fontSize: fontsize, color: textColor, height: textHeight,
          fontStyle: fontStyle,),
    );

Widget defaultTextButton(
        {required String text, required VoidCallback fn, double? fontSize,textColor,bool isUpper=true}) =>
    TextButton(
        onPressed: fn,

        child: Text(
         isUpper ? text.toUpperCase() : text,
          style: TextStyle(fontSize: fontSize,color: textColor),
        ));

Widget defaultBtn({
  double left_margin_icon = 1,
  double right_margin_icon = 10,
  double right_margin_text = 20,
  double width = 330,
  Color backgroundcolor = Colors.blue,
  bool isUpperCase = true,
  double BorderRadValue = 31,
  required String txt,
  required VoidCallback function,
  IconData? icon,
  double fontSize = 20,
}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(BorderRadValue),
      color: backgroundcolor,
    ),
    child: TextButton.icon(
      icon: Container(
        margin:
            EdgeInsets.only(right: right_margin_icon, left: left_margin_icon),
        child: Icon(
          icon,
          color: Colors.white,
          size: 38,
        ),
      ),
      onPressed: function,
      label: Container(
        margin:
            EdgeInsets.only(right: right_margin_text, left: left_margin_icon),
        child: Text(
          isUpperCase ? txt.toUpperCase() : txt,
          style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
      ),
    ),
  );
}

Widget myDivider() => Container(
      width: double.infinity,
      color: Colors.grey,
      height: 1,
    );

