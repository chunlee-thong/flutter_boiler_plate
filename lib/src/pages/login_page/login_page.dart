import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../api/index.dart';
import '../../constant/locale_keys.dart';
import '../../models/response/user/auth_response.dart';
import '../../services/auth_service.dart';
import '../../utils/exception_handler.dart';
import '../../pages/root_page/root_page.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/social_auth_buttons.dart';
import '../../widgets/form_input/primary_text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SuraFormMixin {
  TextEditingController? emailTC;
  TextEditingController? passwordTC;

  void onLogin() async {
    if (isFormValidated) {
      await ExceptionWatcher(context, () async {
        AuthResponse loginResponse = await userRepository.loginUser(
          email: emailTC!.text.trim(),
          password: passwordTC!.text.trim(),
        );
        await AuthService.onLoginSuccess(context, loginResponse);
        PageNavigator.pushReplacement(context, RootPage());
      });
    }
  }

  @override
  void initState() {
    emailTC = TextEditingController(text: "admin@gmail.com");
    passwordTC = TextEditingController(text: "123456");
    super.initState();
  }

  @override
  void dispose() {
    emailTC!.dispose();
    passwordTC!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 200, horizontal: 12),
          children: <Widget>[
            PrimaryTextField(
              textInputType: TextInputType.emailAddress,
              controller: emailTC,
              label: tr(LocaleKeys.email),
            ),
            SpaceY(16),
            PrimaryTextField(
              textInputType: TextInputType.visiblePassword,
              controller: passwordTC,
              obsecure: true,
              label: tr(LocaleKeys.password),
            ),
            PrimaryButton(
              onPressed: onLogin,
              child: Text(tr(LocaleKeys.login)),
            ),
            SpaceY(100),
            SocialAuthButtons(onLoginCompleted: (data) {}),
          ],
        ),
      ),
    );
  }
}
