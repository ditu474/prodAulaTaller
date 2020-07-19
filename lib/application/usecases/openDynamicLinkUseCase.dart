import 'package:aulataller/application/boundaries/open_dynamic_link/iOpenDynamicLink.dart';
import 'package:aulataller/domain/entities/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:aulataller/application/boundaries/open_dynamic_link/openDynamicLinkOutput.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenDynamicLinkUseCase extends IOpenDynamicLink {
  @override
  Future<Either<Failure, OpenDynamicLinkOutput>> execute(String input) async {
    if (await canLaunch(input)) {
      launch(input);
      return Right(OpenDynamicLinkOutput('Success'));
    } else {
      return Left(Failure('Error launching $input'));
    }
  }
}
