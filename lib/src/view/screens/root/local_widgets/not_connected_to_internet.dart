import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gooloads/src/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotConnectedToInternetScreen extends StatelessWidget {
  const NotConnectedToInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<ConnectivityBloc>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              KNoInternetIco,
              height: 200,
            ),
            LARGE_VSPACING,
            MyText(
              txt:
                  "Make sure that you are connected\nto the internet and restart again.",
              alignment: TextAlign.center,
              clr: Palette.KBlackClr,
            ),
            TextButton(
              onPressed: () {
               blocProvider.add(CheckConnectivityEvent());
              },
              child: Text("Restart"),
            )
          ],
        ),
      ),
    );
  }
}
