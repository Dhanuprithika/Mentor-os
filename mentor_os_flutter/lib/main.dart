import 'package:flutter/material.dart';

import 'app.dart';
import 'client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initializeClient sets up the Serverpod client and fires an unawaited
  // client.auth.initialize(). On a frontend-only deployment (no backend
  // running), the async auth init may fail. We wrap in try/catch so that
  // any network error does not prevent the landing page from rendering.
  try {
    await initializeClient();
  } catch (_) {
    // Backend unavailable — continue rendering the landing page.
  }
  runApp(const MentorOSApp());
}
