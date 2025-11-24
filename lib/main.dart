import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/start_screen.dart';
import 'controllers/progress_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ProgressController(), permanent: true);
  runApp(const TapQuestApp());
}

class TapQuestApp extends StatelessWidget {
  const TapQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tap Quest',
      home: const StartScreen(),
    );
  }
}
