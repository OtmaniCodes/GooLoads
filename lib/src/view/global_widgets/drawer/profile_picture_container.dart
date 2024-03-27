import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gooloads/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gooloads/src/blocs/image_picker_bloc/image_picker_bloc.dart';
import 'package:gooloads/src/services/authentication/auth_service.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/reuesed_widgets.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:animate_do/animate_do.dart' as animatedo;

class ProfilePictureContainer extends StatelessWidget {
  const ProfilePictureContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ImagePickerBloc>().add(UpdateProfilePhotoEvent(initial: true, fromCamera: false));
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getProfilePicture(context),
          SMALL_VSPACING,
          getNameAndEmailTexts(),
        ],
      ),
    );
  }

  Widget getProfilePicture(context) {
    final AuthService _authLocator = serviceLocator<AuthService>();
    final Icon personIcon = Icon(
      Icons.person,
      color: Palette.KKGreyShade01Clr,
      size: 35,
    );
    final Widget _loading = Container(
      alignment: Alignment.center,
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Palette.KWhitishClr,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [ReusedWidgets.defaultBoxShadow],
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
              children: [
                animatedo.Pulse(infinite: true, child: Icon(Icons.upload)),
                MyText(txt: "Uploading...",
                size: 14,
                clr: Palette.KBlackClr,
                isBold: true,
                alignment: TextAlign.center
                )
              ],
            ));
    final Widget _profileImage = Container(
        height: 100, width: 100,
        decoration: BoxDecoration(
          color: Palette.KWhitishClr,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [ReusedWidgets.defaultBoxShadow],
        ),
        child: (_authLocator.getUserCredentials()?.photoURL != null && _authLocator.getUserCredentials()?.photoURL != '')
            ? ClipRRect(borderRadius: BorderRadius.circular(9999),
                child: CachedNetworkImage(fit: BoxFit.cover,
                  imageUrl: _authLocator.getUserCredentials()?.photoURL ?? '',
                  placeholder: (ctx, url) => ReusedWidgets.shimmerLoading,
                  errorWidget: (ctx, url, error) => ReusedWidgets.shimmerLoading,
                ),
              )
            : Center(child: personIcon));
    return Stack(alignment: Alignment.bottomLeft, children: [
      BlocBuilder<ImagePickerBloc, ImagePickerState>(builder: (context, state) {
        if (state is UpdateProfilePhotoResult) {
          return _profileImage;
        } else if(state is PickedPhotoLoading){
          return _loading;
        }else {
          return  Container(
        height: 100, width: 100,
        decoration: BoxDecoration(
          color: Palette.KWhitishClr,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [ReusedWidgets.defaultBoxShadow],
        ),
        child: Center(child: personIcon));
        }
      }),
      _getProfileEditButton(context),
    ]);
  }

  Widget _getProfileEditButton(context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.elliptical(9999, 9999)),
        color: Palette.KWhiteClr,
        boxShadow: [ReusedWidgets.defaultBoxShadow],
      ),
      child: ReusedWidgets.materialEffect(
        Padding(
          padding: const EdgeInsets.all(KSmallPadd),
          child: Icon(
            Icons.edit,
            size: 10,
          ),
        ),
        isCircle: true,
        onPress: () {
          HapticFeedback.lightImpact();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return chooseImagePicker(context);
            },
          );
        },
      ),
    );
  }

  BlocBuilder<AuthenticationBloc, AuthenticationState> getNameAndEmailTexts() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (oldState, newState) =>
          (newState is UserCredentialsRequestResult),
      builder: (context, state) {
        Widget retVal = Text("Loading..");
        if (state is UserCredentialsRequestResult) {
          retVal = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                txt: state.userName ?? "Guest",
                size: 25,
                boldness: FontWeight.bold,
                clr: Palette.KBlackClr,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.email,
                    color: Palette.KKGreyShade01Clr,
                  ),
                  SMALL_HSPACING,
                  MyText(
                    txt: state.email ?? "guest@mail.com",
                    clr: Palette.KKGreyShade01Clr,
                  ),
                ],
              ),
            ],
          );
        }
        return retVal;
      },
    );
  }

  Widget chooseImagePicker(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: ReusedWidgets.blurryBg(
        widget: MyContainer(
          givenMarg: EdgeInsets.symmetric(
              horizontal: ScreenCredentials.screenWidth(context) * 0.1),
          kiddo: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                  txt: "Pick an image source",
                  clr: Palette.KBlackClr,
                  boldness: FontWeight.bold),
              SMALL_VSPACING,
              Row(
                children: [
                  animatedo.FadeInLeft(
                      child: getImagePickerOptionButton(context, true)),
                  Spacer(),
                  MyText(txt: "or", clr: Palette.KBlackClr),
                  Spacer(),
                  animatedo.FadeInRight(
                      child: getImagePickerOptionButton(context, false))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImagePickerOptionButton(BuildContext context, bool isCamera) {
    return MyContainer(
        withBorder: true,
        givenPadd: EdgeInsets.zero,
        kiddo: ClipRRect(
          borderRadius: ReusedWidgets.defaultBorRadCir,
          child: ReusedWidgets.materialEffect(
              Padding(
                padding: const EdgeInsets.all(KDefaultPadd),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyText(
                      txt: isCamera ? "Camera" : "Gallery",
                      clr: Palette.KBlackClr,
                    ),
                    Icon(
                      isCamera ? Icons.camera_alt : Icons.image,
                      size: 60.0,
                    )
                  ],
                ),
              ), onPress: () {
            HapticFeedback.lightImpact();
            context
                .read<ImagePickerBloc>()
                .add(UpdateProfilePhotoEvent(fromCamera: isCamera));
            Navigator.pop(context);
          }),
        ));
  }
}
