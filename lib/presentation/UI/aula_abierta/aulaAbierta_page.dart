import 'package:aulataller/domain/entities/service.dart';
import 'package:aulataller/injection_container.dart';
import 'package:aulataller/presentation/UI/aula_abierta/daySection.dart';
import 'package:aulataller/presentation/states/aula_abierta/aulaAbierta_bloc.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AulaAbiertaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aula Abierta'),
      ),
      body: BlocProvider<AulaAbiertaBloc>(
        create: (context) => getIt<AulaAbiertaBloc>(),
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
    return BlocConsumer<AulaAbiertaBloc, AulaAbiertaState>(
      listener: (context, state) {
        if (state.error != "") {
          CustomSnackBar.showErrorSnackBar(
              ctx: context, leftWidget: Text(state.error));
        }
      },
      builder: (context, state) {
        if (state.services == null && state.loading == false) {
          context.bloc<AulaAbiertaBloc>().add(FetchServices());
        }
        if (state.services != null) {
          Map<String, List<Service>> servicesMap =
              _separateServicesByDay(state.services);
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey[200],
                  Colors.grey[400],
                  Colors.grey[200],
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _createSections(servicesMap),
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

Map<String, List<Service>> _separateServicesByDay(List<Service> services) {
  Map<String, List<Service>> servicesPerDay = {};
  for (Service element in services) {
    if (!servicesPerDay.containsKey(element.day)) {
      servicesPerDay[element.day] = [element];
    } else {
      servicesPerDay[element.day].add(element);
    }
  }
  return servicesPerDay;
}

List<DaySection> _createSections(Map<String, List<Service>> map) {
  List<DaySection> sections = [];
  for (String key in map.keys) {
    sections.add(
      DaySection(
        day: key,
        services: map[key],
      ),
    );
  }
  return sections;
}