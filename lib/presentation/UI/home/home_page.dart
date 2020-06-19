import 'package:aulataller/presentation/states/authentication/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc,AuthState>(
      builder: (context, state){
        if(state is AuthenticationSuccess){
          return Scaffold(
            body: Center(
              child: Column(
                children: <Widget>[
                  Text(state.displayName),
                  RaisedButton(
                    child: Text('Salir'),
                    onPressed: (){
                      context.bloc<AuthBloc>().add(AuthenticationLoggedOut());
                    },
                  )
                ],
              )
            ),
          );
        }
        return Center(
          child: Text('error')
        );
      },
    );
  }
}