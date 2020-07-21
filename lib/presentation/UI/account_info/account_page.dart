import 'package:aulataller/injection_container.dart';
import 'package:aulataller/presentation/UI/account_info/account_body.dart';
import 'package:aulataller/presentation/UI/widgets/defaultBackground.dart';
import 'package:aulataller/presentation/states/account/account_bloc.dart';
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
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
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
    return DefaultBackground(
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.user != null) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: AccountBody(state.user),
            );
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
