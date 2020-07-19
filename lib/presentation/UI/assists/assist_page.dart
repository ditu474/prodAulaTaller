import 'package:aulataller/injection_container.dart';
import 'package:aulataller/presentation/UI/widgets/defaultBackground.dart';
import 'package:aulataller/presentation/states/assists/assists_bloc.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssistsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asistencias'),
      ),
      body: DefaultBackground(
        child: BlocProvider<AssistsBloc>(
          create: (context) => getIt<AssistsBloc>(),
          child: Body(),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssistsBloc, AssistsState>(
      listener: (context, state) {
        if (state.error != "") {
          CustomSnackBar.showErrorSnackBar(
              ctx: context, leftWidget: Text(state.error));
        }
      },
      builder: (context, state) {
        if (state.assists != null) {
          if (state.assists.length > 0) {
            return Column(
              children:
                  state.assists.map((element) => Text(element.date)).toList(),
            );
          } else {
            return Center(
              child: Text('No Haz Registrado Ninguna Asistencia Aún'),
            );
          }
        }
        if (AssistsState() == state) {
          context.bloc<AssistsBloc>().add(GetAssists());
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
