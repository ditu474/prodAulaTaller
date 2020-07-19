import 'package:aulataller/injection_container.dart';
import 'package:aulataller/presentation/UI/widgets/defaultBackground.dart';
import 'package:aulataller/presentation/states/account/account_bloc.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuenta'),
      ),
      body: BlocProvider<AccountBloc>(
        create: (context) => getIt<AccountBloc>(),
        child: Body(),
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
    return DefaultBackground(
      child: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state.error != "") {
            CustomSnackBar.showErrorSnackBar(
                ctx: context, leftWidget: Text(state.error));
          }
        },
        builder: (context, state) {
          if (state.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.user != null) {
            return Text(state.user.academicProgram ?? "No Aplica");
          }
          if (AccountState() == state) {
            context.bloc<AccountBloc>().add(GetUserFromDatabase());
          }
          return SizedBox();
        },
      ),
    );
  }
}
