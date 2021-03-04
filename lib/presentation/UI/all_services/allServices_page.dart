import 'package:aulataller/injection_container.dart';
import 'package:aulataller/presentation/UI/all_services/service_item.dart';
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
        child: DefaultBackground(child: Body()),
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
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                left: responsive.widthPercent(5),
                right: responsive.widthPercent(5),
                top: responsive.heigthPercent(2),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    'A continuación se encuentra el listado de todos los servicios ofrecidos en el aula taller, si quieres saber mas acerca de ellos, escribenos al correo: aulataller@elpoli.edu.co',
                    style: TextStyle(
                      fontSize: responsive.inchPercent(2.5),
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: responsive.heigthPercent(2)),
                  ListView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: state.services.length,
                    itemBuilder: (ctx, index) => ServiceItem(
                      name: state.services[index].name,
                      privacy: state.services[index].privacy,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (AllServicesState() == state) {
          context.bloc<AllServicesBloc>().add(FetchServices());
        }
        if (state.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SizedBox();
      },
    );
  }
}
