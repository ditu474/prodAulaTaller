import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/presentation/UI/widgets/info_item.dart';
import 'package:aulataller/presentation/UI/account_info/change_password_form.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';

class AccountBody extends StatelessWidget {
  final User user;

  const AccountBody(this.user);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.of(context).inchPercent(2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InfoItem(
            label: 'Nombre',
            value: user.name,
          ),
          InfoItem(
            label: 'Tipo de documento',
            value: user.typeOfDocument,
          ),
          InfoItem(
            label: 'Documento',
            value: user.document,
          ),
          InfoItem(
            label: 'Correo',
            value: user.email,
          ),
          InfoItem(
            label: 'Tipo de usuario',
            value: user.rol,
          ),
          InfoItem(
            label: 'Sede',
            value: user.campus,
          ),
          InfoItem(
            label: 'Programa académico',
            value: user.academicProgram,
          ),
          InfoItem(
            label: 'Semestre',
            value: user.semester == null ? null : user.semester.toString(),
          ),
          ChangePasswordForm(),
        ],
      ),
    );
  }
}
