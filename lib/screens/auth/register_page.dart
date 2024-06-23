import 'package:flutter/material.dart';
import 'package:personalfinanceapp/constants/colors.dart';
import 'package:personalfinanceapp/models/user_model.dart';
import 'package:personalfinanceapp/services/auth_service.dart';
import 'package:personalfinanceapp/widgets/appbutton.dart';
import 'package:personalfinanceapp/widgets/apptext.dart';
import 'package:personalfinanceapp/widgets/cutomtextformfield.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _regKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Form(
            key: _regKey,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        data: "Create an Account",
                        color: Colors.white,
                        size: 22,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is Mandatory";
                            }
                            return null;
                          },
                          controller: _emailController,
                          hintText: "Email"),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is Mandatory";
                            }
                            if (value.length < 6) {
                              return "Password Should be grater than 6 characters";
                            }
                            return null;
                          },
                          obscureText: true,
                          controller: _passwordController,
                          hintText: "Password"),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name Mandatory";
                            }

                            return null;
                          },
                          controller: _nameController,
                          hintText: "Name"),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          type: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone Mandatory";
                            }

                            return null;
                          },
                          controller: _phoneController,
                          hintText: "Phone"),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: AppButton(
                            height: 52,
                            width: 250,
                            color: Colors.deepOrange,
                            onTap: () async {
                              //creating a unique id
                              var uuid = const Uuid().v1();

                              if (_regKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    });

                                UserModel user = UserModel(
                                    id: uuid,
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    name: _nameController.text,
                                    phone: _phoneController.text,
                                    status: 1);

                                final res =
                                    await authService.registerUser(user);
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);

                                if (res == true) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                }
                              }
                            },
                            child: AppText(
                              data: "Register",
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            data: "Already have an Account?",
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: AppText(
                                data: "Login",
                                color: Colors.white,
                              ))
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
