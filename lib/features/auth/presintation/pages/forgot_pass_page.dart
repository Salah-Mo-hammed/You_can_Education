import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_bloc.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_event.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_state.dart';
import 'package:grad_project_ver_1/features/auth/presintation/widgets/auth_widget.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController emailController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeInDown(
        delay: Duration(milliseconds: 1500),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [
                Color(0xFFF7EEDD), // pastel beige (matches gold)
                Color(0xFFFDF6EE), // lighter peach
                Colors.white,
                //   Colors.orange[900]!,
                //   Colors.orange[800]!,
                //   Colors.orange[400]!,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildText(
                      "Reset Password",
                      35,
                      Colors.white,
                      FontWeight.bold,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Enter your email address to reset your password",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60),
                      topLeft: Radius.circular(60),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          SizedBox(height: 40),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(
                                    225,
                                    95,
                                    27,
                                    .3,
                                  ),
                                  blurRadius: 10,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                _buildEmailField(),
                                BlocConsumer<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    if (state is AuthStateException) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            state.exceptionMessage ??
                                                "An error occurred",
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else if (state
                                        is AuthStateSuccessReset) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Password reset email sent successfully.",
                                          ),
                                          backgroundColor:
                                              Colors.green,
                                        ),
                                      );
                                      Future.delayed(
                                        const Duration(seconds: 2),
                                        () {
                                          Navigator.pushReplacement(
                                            // ignore: use_build_context_synchronously
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      AuthWidget(
                                                        doRegister:
                                                            false,
                                                      ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding:
                                              const EdgeInsets.symmetric(
                                                vertical: 14.0,
                                              ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                  12.0,
                                                ),
                                          ),
                                        ),
                                        onPressed:
                                            state is AuthStateLoading
                                                ? null
                                                : () {
                                                  final email =
                                                      emailController
                                                          .text
                                                          .trim();
                                                  if (email
                                                      .isNotEmpty) {
                                                    context
                                                        .read<
                                                          AuthBloc
                                                        >()
                                                        .add(
                                                          AuthResetPassEvent(
                                                            email:
                                                                email,
                                                          ),
                                                        );
                                                  }
                                                },
                                        child:
                                            state is AuthStateLoading
                                                ? const CircularProgressIndicator()
                                                : const Text(
                                                  "Reset Password",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 30),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 50,
                              ),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  50,
                                ),
                                border: Border.all(
                                  color: Colors.orange[900]!,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Go Back",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.orange[900],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Icon(Icons.email_outlined, color: Colors.orange[900]),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email Address",
                border: InputBorder.none,
                labelStyle: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text _buildText(
    String text,
    double size,
    Color color,
    FontWeight weight,
  ) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
      ),
    );
  }
}
