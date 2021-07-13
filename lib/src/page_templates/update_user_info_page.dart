import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../constant/app_dimension.dart';
import '../constant/style_decoration.dart';
import '../ui/widgets/buttons/primary_button.dart';
import '../ui/widgets/form_input/primary_dropdown_button.dart';
import '../ui/widgets/form_input/primary_text_field.dart';
import '../ui/widgets/ui_helper.dart';
import '../utils/exception_handler.dart';

class UpdateUserInfoPage extends StatefulWidget {
  UpdateUserInfoPage({Key? key}) : super(key: key);
  @override
  _UpdateUserInfoPageState createState() => _UpdateUserInfoPageState();
}

class _UpdateUserInfoPageState extends State<UpdateUserInfoPage> with SuraFormMixin, AfterBuildMixin {
  late TextEditingController firstNameTC;
  late TextEditingController lastNameTC;
  late TextEditingController dobTC;
  late TextEditingController countryTC;

  String? gender;
  List<String> genders = ["Male", "Female"];
  late DateTime selectedDOB;

  Future<void> onSubmit() async {
    if (isFormValidated) {
      await ExceptionWatcher(context, () async {
        String firstname = firstNameTC.text.trim();
        String lastname = lastNameTC.text.trim();
        String country = countryTC.text.trim();
      });
    }
  }

  void onPickDob() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      selectedDOB = pickedDate;
      dobTC.text = selectedDOB.formatDate();
    }
  }

  @override
  void initState() {
    gender = genders[0];
    firstNameTC = TextEditingController();
    lastNameTC = TextEditingController();
    dobTC = TextEditingController();
    countryTC = TextEditingController();
    super.initState();
  }

  @override
  void afterBuild(BuildContext context) {
    // TODO: implement afterBuild
  }

  @override
  void dispose() {
    firstNameTC.dispose();
    lastNameTC.dispose();
    dobTC.dispose();
    countryTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: ""),
      body: SingleChildScrollView(
        padding: AppDimension.pageSpacing,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Update your info", style: kHeaderStyle),
            SpaceY(24),
            buildForm(),
          ],
        ),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          PrimaryTextField(
            controller: firstNameTC,
            hint: "First name",
          ),
          PrimaryTextField(
            controller: lastNameTC,
            hint: "Last name",
          ),
          PrimaryTextField(
            controller: dobTC,
            hint: "Date of birth",
            onTap: onPickDob,
          ),
          PrimaryDropDownButton(
            options: genders,
            value: gender,
            onChanged: (dynamic value) {
              setState(() {
                gender = value;
              });
            },
          ),
          PrimaryButton(
            onPressed: onSubmit,
            child: Text("Change Password"),
          ),
        ],
      ),
    );
  }
}
