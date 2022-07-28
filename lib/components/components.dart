import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sound_cloud_clone/components/constants.dart';
import 'package:sound_cloud_clone/cubits/theme_manager/cubit.dart';
import 'package:sound_cloud_clone/screens/settings_screen.dart';
import 'package:we_slide/we_slide.dart';

import '../models/track_data.dart';
import '../screens/login_screen.dart';
import '../screens/playback_screen.dart';

void navigateTo(context, nextPage) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextPage,
      ),
    );

void navigateAndFinish(context, nextPage) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => nextPage),
    (route) => false);

Widget defaultTextField({
  required String labeltxt,
  Icon? prefixIcon,
  bool isPass = false,
  IconData? suffix,
  TextEditingController? controller,
  required TextInputType txtinput,
  Function()? SuffixPressed,
  Function(String val)? onSubmit,
  Function(String value)? valid,
  TextStyle? hintStyle,
  enableBorder = false,
}) {
  return TextFormField(
    keyboardType: txtinput,
    controller: controller,
    onFieldSubmitted: onSubmit,
    obscureText: isPass,
    decoration: InputDecoration(
      hintStyle: hintStyle,
      fillColor: Colors.white,
      filled: true,
      hintText: labeltxt,
      border: enableBorder ? null : InputBorder.none,
      enabledBorder: enableBorder
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.black, width: 1),
            )
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white, width: 10),
            ),
      focusedBorder: enableBorder
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.black, width: 1),
            )
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white, width: 10),
            ),
      prefixIcon: prefixIcon,
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
        double? fontSize,
        double? letterSpacing,
        isUpperCase = false,
        textColor,
        double? textHeight,
        linesMax,
        TextOverflow? textOverflow,
        FontStyle? fontStyle,
        TextStyle? hintStyle,
        TextAlign? textAlign,
        TextStyle? myStyle}) =>
    Text(
      isUpperCase ? text.toUpperCase() : text,
      maxLines: linesMax,
      overflow: textOverflow,
      textAlign: textAlign,
      style: myStyle ??
          TextStyle(
              fontSize: fontSize,
              color: textColor,
              height: textHeight,
              fontStyle: fontStyle,
              letterSpacing: letterSpacing),
    );

Widget defaultTextButton(
        {required String text,
        required VoidCallback fn,
        double? fontSize,
        textColor,
        bool isUpper = true}) =>
    TextButton(
        onPressed: fn,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(fontSize: fontSize, color: textColor),
        ));

Widget defaultBtn({
  double left_margin_icon = 1,
  double right_margin_icon = 10,
  double right_margin_text = 20,
  double width = 330,
  Color backgroundcolor = defaultColor,
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

//track tile. or make a list of tracks
Widget trackTile(TrackData trackData) {
  return ListTile(
    leading: CircleAvatar(
      backgroundImage: NetworkImage(trackData.image64URL),
    ),
    title: Text(trackData.name),
    trailing: const Icon(Icons.add),
    onTap: () {
      //navigate to the music player page with this trackData object
      //might want to assign it to some "nowPlaying" variable in bloc?
    },
  );
}

Widget buildSettingsItem(SettingsModel model, context) => Container(
    margin: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
    width: 340,
    height: 60,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(23),
      boxShadow: [
        BoxShadow(color: defaultColor, offset: Offset(3, 3), blurRadius: 6)
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 9, 13, 10),
      child: InkWell(
        onTap: () {
          if (model.darkMode!) return;
          if (!model.signOut!)
            navigateTo(context, model.screen);
          else
            navigateAndFinish(context, LoginScreen());
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[200],
              child: Icon(
                model.iconData,
                size: 25,
                color: defaultColor,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            defaultText(
                text: model.text!, textColor: Colors.black, fontSize: 16),
            Spacer(),
            if (!model.darkMode!)
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.grey[800],
              ),
            if (model.darkMode!)
              Switch(
                  value: ThemeManagerCubit.get(context).isDark,
                  // inactiveThumbColor: Colors.grey[200],
                  // activeTrackColor: defaultColor,
                  onChanged: (bool x) {
                    ThemeManagerCubit.get(context).changeTheme();
                  })
          ],
        ),
      ),
    ));

AppBar myAppBar(BuildContext context,
    {required String title, List<Widget>? myActions}) {
  return AppBar(
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline1,
    ),
    centerTitle: true,
    backgroundColor: defaultColor,
    actions: myActions ?? [],
  );
}

Future myDialog(
        {context,
        required text, declineText, acceptText,
        Widget? content,
        bool isItListView = false,
        void Function()? declineFn,
        void Function()? acceptFn}) =>
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                text,
                style: TextStyle(fontSize: 17),
              ),
              content: isItListView
                  ? content
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: TextButton(
                              onPressed: declineFn,
                              child: defaultText(
                                  text: declineText, textColor: Colors.white)),
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: defaultColor,
                          ),
                        ),
                        Container(
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: defaultColor,
                          ),
                          child: TextButton(
                              onPressed: acceptFn,
                              child: defaultText(
                                  text: acceptText, textColor: Colors.white)),
                        ),
                      ],
                    ));
        });


Widget myPanel({required Widget Screen, required BuildContext context, required cubit}){
  return WeSlide(
    panel: cubit.activeTrackSet ? InkWell(
      onTap: () {
        // cubit.stillPlaying = true;
        cubit.navigatePanel();
        Navigator.push(context, PageTransition(
            child: PlaybackScreen(),
            type: PageTransitionType.bottomToTop));
      },
      child: Container(
          padding: EdgeInsets.fromLTRB(20, 6, 20, 10),
          color: ThemeManagerCubit
              .get(context)
              .isDark
              ? Colors.grey[900]
              : Colors.white,
          child: Row(
            children: [
              Image(
                image: NetworkImage(cubit.activeTrack.image64URL),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    child: defaultText(

                        text: cubit.activeTrack.name,
                        myStyle: Theme
                            .of(context)
                            .textTheme
                            .subtitle2,
                        textOverflow: TextOverflow.ellipsis
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 150,
                    child: defaultText(
                        text: cubit.activeTrack.artistName,
                        myStyle: Theme
                            .of(context)
                            .textTheme
                            .bodyText2,
                        textOverflow: TextOverflow.ellipsis
                    ),
                  ),
                ],
              ),
              Spacer(),
              CircleAvatar(
                backgroundColor: defaultColor,
                child: IconButton(
                  onPressed: () {
                    //cubit.setUrlSrc(cubit.nowPlaying.previewURL);
                    cubit.togglePlayer();
                  },
                  icon: Icon(cubit.playerButtonIcon),
                  color: ThemeManagerCubit
                      .get(context)
                      .isDark
                      ? Colors.white
                      : Colors.black,
                ),
              )
            ],
          )
      ),
    ) : Container(),
    panelMinSize: 85,
    panelMaxSize: 86,
    body: Container(
      color: ThemeManagerCubit
          .get(context)
          .isDark
          ? HexColor('333739')
          : HexColor('e8e6ef'),

      child: Screen,
    ),
  );
}