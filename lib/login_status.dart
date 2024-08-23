import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopyee/config/widgets/navigation.dart';
import 'package:shopyee/config/widgets/toast_alert.dart';
import 'package:shopyee/provider/auth_provider/auth_provider.dart';
import 'package:shopyee/view/auth/login.dart';
import 'package:shopyee/view/home/home.dart';

class LoginStatus extends ConsumerWidget {
  const LoginStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(userLoginProvider);

    if (auth.user.isNotEmpty) {
      final token = auth.user[0].token;

      final tokenState = ref.watch(checkTokenStatusProvider(token));

      if (tokenState.isLoad) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else if (tokenState.isError) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(userLoginProvider.notifier).userLogOut();
          Toasts.showFailure(context, tokenState.errMessage);
        });
        return const Scaffold();
      } else if (tokenState.isSuccess) {
        return Home(); // Navigate to Home on success
      } else {
        return const Login(); // Default fallback (or could be another state)
      }
    } else {
      return const Login(); // Show login if user is not authenticated
    }
  }
}
