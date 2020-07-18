import 'package:aulataller/injection_container.dart';
import 'package:aulataller/presentation/UI/widgets/defaultBackground.dart';
import 'package:aulataller/presentation/states/all_services/allServices_bloc.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AllServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text('Todos Los Servicios')),
      ),
      body: BlocProvider<AllServicesBloc>(
        create: (context) => getIt<AllServicesBloc>(),
        child: Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return BlocConsumer<AllServicesBloc, AllServicesState>(
      listener: (context, state) {
        if (state.error != "") {
          CustomSnackBar.showErrorSnackBar(
              ctx: context, leftWidget: Text(state.error));
        }
      },
      builder: (context, state) {
        if (state.services != null) {
          return DefaultBackground(
            child: Padding(
              padding: EdgeInsets.only(
                left: responsive.widthPercent(5),
                right: responsive.widthPercent(5),
                top: responsive.heigthPercent(2),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    state.services.map((e) => e.name).toList().toString(),
                    style: TextStyle(
                      fontSize: responsive.inchPercent(2.5),
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        if (state.services == null &&
            state.loading == false &&
            state.error == "") {
          context.bloc<AllServicesBloc>().add(FetchServices());
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
