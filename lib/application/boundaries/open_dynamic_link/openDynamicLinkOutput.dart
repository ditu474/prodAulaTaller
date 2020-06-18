import 'package:equatable/equatable.dart';

class OpenDynamicLinkOutput extends Equatable{
  final String message;

  OpenDynamicLinkOutput(this.message);

  @override
  List<Object> get props => [message];
}