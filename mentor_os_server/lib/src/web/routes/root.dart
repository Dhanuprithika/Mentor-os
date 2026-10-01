import 'package:mentor_os_server/src/cache_busting.dart';
import 'package:mentor_os_server/src/web/widgets/built_with_serverpod_page.dart';
import 'package:serverpod/serverpod.dart';

class RootRoute extends WidgetRoute {
  RootRoute() : super(cacheBustingConfig: cacheBustingConfig);

  @override
  Future<TemplateWidget> build(Session session, Request request) async {
    return BuiltWithServerpodPageWidget();
  }
}
