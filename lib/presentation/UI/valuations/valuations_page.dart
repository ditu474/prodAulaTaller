import 'package:aulataller/injection_container.dart';
import 'package:aulataller/presentation/UI/valuations/valuation_item.dart';
import 'package:aulataller/presentation/UI/widgets/defaultBackground.dart';
import 'package:aulataller/presentation/states/valuations/valuations_bloc.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValuationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Valoraciones'),
      ),
      body: DefaultBackground(
        child: BlocProvider<ValuationsBloc>(
          create: (context) => getIt<ValuationsBloc>(),
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
    return BlocConsumer<ValuationsBloc, ValuationsState>(
      listener: (context, state) {
        if (state.error != "") {
          CustomSnackBar.showErrorSnackBar(
              ctx: context, leftWidget: Text(state.error));
        }
      },
      builder: (context, state) {
        if (state.valuations != null) {
          if (state.valuations.length > 0) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (ctx, i) => ValuationItem(state.valuations[i]),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: state.valuations.length,
            );
          } else {
            return Center(
              child: Text('No Haz Valorado Ningún Servicio Aún'),
            );
          }
        }
        if (ValuationsState() == state) {
          context.bloc<ValuationsBloc>().add(FetchServices());
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
