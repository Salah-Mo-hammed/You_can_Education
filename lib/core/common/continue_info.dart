import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/core/colors/app_color.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/entities/center_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_general_bloc/center_general_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/center_dashboard_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_general_bloc/bloc/student_general_bloc_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/student_dashboard.dart';

class ContinueInfo extends StatefulWidget {
  final String role;
  final String userId;
  final String email;
  const ContinueInfo({
    super.key,
    required this.role,
    required this.userId,
    required this.email,
  });

  @override
  State<ContinueInfo> createState() => _ContinueInfoState();
}

class _ContinueInfoState extends State<ContinueInfo> {
  final TextEditingController nameController =
      TextEditingController();
  final TextEditingController addressController =
      TextEditingController();
  final TextEditingController phoneController =
      TextEditingController();
  final TextEditingController managerPhoneController =
      TextEditingController();
  final TextEditingController centerPhoneController =
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInUp(
                      delay: Duration(milliseconds: 1700),
                      child: _buildText(
                        "Complete Your Profile",
                        35,
                        Colors.white,
                        FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    FadeInUp(
                      delay: Duration(milliseconds: 1900),
                      child: Text(
                        "Tell us more about yourself",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
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
                          FadeInUp(
                            delay: Duration(milliseconds: 2100),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  25,
                                ),
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
                                  const SizedBox(height: 20),
                                  _buildInfoField(
                                    Icons.person_outline,
                                    widget.role == "student"
                                        ? "Student Name"
                                        : "Center Name",
                                    TextInputType.name,
                                    nameController,
                                  ),
                                  _buildInfoField(
                                    Icons.location_on,
                                    "Adress",
                                    TextInputType.name,
                                    addressController,
                                  ),
                                  _buildInfoField(
                                    Icons.phone,
                                    "Phone number",
                                    TextInputType.number,
                                    phoneController,
                                  ),
                                  if (widget.role == "center")
                                    _buildInfoField(
                                      Icons.manage_accounts_rounded,
                                      "Manager Phone number",
                                      TextInputType.number,
                                      managerPhoneController,
                                    ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          FadeInUp(
                            delay: Duration(milliseconds: 2300),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 50,
                              ),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  50,
                                ),
                                color: Colors.orange[900],
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () => _saveInfo(),

                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Center(
                                      child: const Text(
                                        "Save",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
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

  void _saveInfo() {
    String name = nameController.text.trim();
    String address = addressController.text.trim();
    String phone = phoneController.text.trim();

    if (name.isEmpty || address.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all required fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // تنفيذ منطق الحفظ بناءً على الدور (طالب أو مركز)
    if (widget.role == "student") {
      StudentEntity createStudent = StudentEntity(
        studentId: widget.userId,
        name: name,
        email: widget.email,
        phoneNumber: phone,
        address: address,
        courses: {},
      );
      context.read<StudentGeneralBloc>().add(
        CreateStudentEvent(createStudent: createStudent),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  StudentDashboard(currentStudentId: widget.userId),
        ),
      );
    } else {
      CenterEntity createCenter = CenterEntity(
        centerId: widget.userId,
        name: name,
        email: widget.email,
        phoneNumber: phone,
        address: address,
        description: "no desc for now ",
      );
      context.read<CenterGeneralBloc>().add(
        CreateCenterEvent(createCenter: createCenter),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => CenterDashboard(centerId: widget.userId),
        ),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Information saved successfully!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildInfoField(
    IconData icon,
    String label,
    TextInputType inputType,
    TextEditingController controller,
  ) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange[900]),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: inputType,
              decoration: InputDecoration(
                labelText: label,
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
