import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validation/form_validation.dart';
import 'package:shopyee/config/widgets/custom_button.dart';
import 'package:shopyee/config/widgets/custom_textform__field.dart';
import 'package:shopyee/config/widgets/toast_alert.dart';
import 'package:shopyee/provider/auth_provider/auth_provider.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final _form = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObstruct = true;

  @override
  Widget build(BuildContext context) {
    ref.listen(userRegisterProvider, (previous, next) {
      if (next.isError) {
        Toasts.showFailure(context, next.errMessage);
      } else if (next.isSuccess) {
        Navigator.of(context).pop();
        Toasts.showSuccess(context, 'Sign up Successful');
      }
    });
    final registerProvider = ref.watch(userRegisterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 150.w,
                    height: 130.h,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Text(
                  'SHOPYEE',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                SizedBox(height: 12.h),
                CustomTextFormFiedl(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: 'Full Name',
                    validator: (val) {
                      final validator = Validator(validators: [
                        const RequiredValidator(),
                      ]);
                      return validator.validate(
                        label: 'Full Name',
                        value: val,
                      );
                    }),
                SizedBox(height: 25.h),
                CustomTextFormFiedl(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    hintText: 'Email',
                    validator: (val) {
                      final validator = Validator(validators: [
                        const RequiredValidator(),
                        const EmailValidator(),
                      ]);
                      return validator.validate(
                        label: 'Email',
                        value: val,
                      );
                    }),
                SizedBox(height: 25.h),
                CustomTextFormFiedl(
                  controller: passwordController,
                  obscureText: isObstruct,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  hintText: 'Password',
                  validator: (val) {
                    final validator = Validator(validators: [
                      const RequiredValidator(),
                      const MinLengthValidator(length: 6)
                    ]);
                    return validator.validate(
                      label: 'Password',
                      value: val,
                    );
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObstruct = !isObstruct;
                      });
                    },
                    icon: Icon(
                      isObstruct ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                SizedBox(height: 35.h),
                CustomButton(
                  isLoading: registerProvider.isLoad,
                  text: 'SIGN UP',
                  onTap: () {
                    _form.currentState!.save();
                    FocusScope.of(context).unfocus();
                    if (_form.currentState!.validate()) {
                      ref.read(userRegisterProvider.notifier).userRegister(
                            fullName: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                    }
                  },
                ),
                SizedBox(height: 60.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already a member? ',
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Login now',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
