import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:grad_project_ver_1/core/colors/app_color.dart';
import 'package:grad_project_ver_1/features/auth/presintation/widgets/auth_widget.dart';

class UserTypeSelectionPage extends StatelessWidget {
  const UserTypeSelectionPage({super.key});

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
                AppColors.brown,
                AppColors.bronze,
                AppColors.taupe,
                Color(0xFFBD9B69),

                // Colors.orange[900]!,
                // Colors.orange[800]!,
                // Colors.orange[400]!,
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 80),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    FadeInUp(
                      delay: Duration(milliseconds: 1700),
                      child: _buildText(
                        "Choose Your Role",
                        35,
                        Colors.white,
                        FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    FadeInUp(
                      delay: Duration(milliseconds: 1900),
                      child: Text(
                        "Select how you want to join our learning community",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
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
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Row(
                          children: [
                            _buildRoleCard(
                              context,
                              "Student",
                              Icons.person,
                              "Join as a student to access courses and start learning",
                              2100,
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => AuthWidget(
                                          doRegister: true,
                                          role: 'student',
                                        ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 15),
                            _buildRoleCard(
                              context,
                              "Center",
                              Icons.school,
                              "Join as an educational center to share knowledge",
                              2300,
                              () {
                                // Navigate to center signup
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => AuthWidget(
                                          doRegister: true,
                                          role: 'center',
                                        ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        FadeInUp(
                          delay: Duration(milliseconds: 2500),
                          child: TextButton(
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
                                  color: AppColors.gold,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Go Back",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: AppColors.brown,
                                    fontWeight: FontWeight.bold,
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }

  Text _buildText(
    String title,
    double size,
    Color color,
    FontWeight weight,
  ) {
    return Text(
      title,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
      textAlign: TextAlign.center,
    );
  }

  Expanded _buildRoleCard(
    BuildContext context,
    String title,
    IconData icon,
    String description,
    int milliseconds,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: FadeInUp(
        delay: Duration(milliseconds: milliseconds),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 30, color: AppColors.brown),
                ),
                SizedBox(height: 15),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.brown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
