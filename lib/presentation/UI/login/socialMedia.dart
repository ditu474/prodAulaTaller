import 'package:aulataller/presentation/UI/widgets/svgButton.dart';
import 'package:aulataller/presentation/states/login/login_bloc.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state.linkError) {
        CustomSnackBar.showErrorSnackBar(
          ctx: context,
          leftWidget: Text(state.error),
        );
      }
    }, builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SVGButton(
            tapHandler: () {
              context.bloc<LoginBloc>().add(FacebookButtonPressed());
            },
            size: responsive.inchPercent(7),
            url: "assets/icons/facebook.svg",
            label: 'Facebook',
          ),
          SVGButton(
            tapHandler: () {
              context.bloc<LoginBloc>().add(InstagramButtonPressed());
            },
            size: responsive.inchPercent(7),
            url: "assets/icons/instagram.svg",
            label: 'Instagram',
          ),
        ],
      );
    });
  }
}
