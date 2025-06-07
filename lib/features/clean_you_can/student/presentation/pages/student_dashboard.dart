// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/core/splash_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_general_bloc/bloc/student_general_bloc_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/student_profile_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/certificates_widget.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/my_learning_widget.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/notifications_widget.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/show_available_courses.dart';

// ignore: must_be_immutable
class StudentDashboard extends StatefulWidget {
  String currentStudentId;
  StudentDashboard({super.key, required this.currentStudentId});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedIndex = 0;
  bool _isSearchExpanded = false;
  StudentEntity? currentStudent;

  @override
  void initState() {
    super.initState();
    context.read<StudentGeneralBloc>().add(
      GetStudentInfoEvent(studentId: widget.currentStudentId),
    );
  }

  void _onTapBottomBar(int tempIndex) {
    setState(() {
      _selectedIndex = tempIndex;
    });
  }

  Widget _getSelectedPage(int index) {
    switch (index) {
      case 0:
        return ShowAvailableCoursesWidget(
          studentId: widget.currentStudentId,
        );
      case 1:
        return MyLearningWidget(studentId: widget.currentStudentId);
      case 2:
        return CertificatesWidget();
      case 3:
        return NotificationsWidget();
      default:
        return ShowAvailableCoursesWidget(
          studentId: widget.currentStudentId,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<StudentGeneralBloc, StudentGeneralState>(
        listener: (context, state) {
          if (state is StudentGeneralGotInfoState) {
            setState(() {
              currentStudent = state.currentStudent;
            });
          }
        },
        child: Column(
          children: [
            const SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => StudentProfilePage(
                          studentId: widget.currentStudentId,
                        ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 2,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                      0.08,
                                    ),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.deepPurple
                                    .withOpacity(0.2),
                                child: ClipOval(
                                  child:
                                      (currentStudent?.photoUrl ==
                                              null)
                                          ? Image.asset(
                                            'assets/images/grad_logo.png',
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          )
                                          : Image.network(
                                            currentStudent!.photoUrl!,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) => Image.asset(
                                                  'assets/images/grad_logo.png',
                                                  width: 30,
                                                  height: 30,
                                                  fit: BoxFit.cover,
                                                ),
                                            loadingBuilder: (
                                              context,
                                              child,
                                              loadingProgress,
                                            ) {
                                              if (loadingProgress ==
                                                  null)
                                                return child;
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  value:
                                                      loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              (loadingProgress.expectedTotalBytes ??
                                                                  1)
                                                          : null,
                                                ),
                                              );
                                            },
                                          ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentStudent?.name ??
                                      "جار التحميل...",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),

                      ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SplashPage(),
                            ),
                          );
                        },
                        child: Text("Sign out"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: _getSelectedPage(_selectedIndex)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTapBottomBar,
        selectedItemColor: Colors.deepPurple[500],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            label: "Courses",
            icon: Icon(Icons.menu_book_rounded),
          ),
          BottomNavigationBarItem(
            label: "My Learning",
            icon: Icon(Icons.bookmark_border),
          ),
          BottomNavigationBarItem(
            label: "Certificates",
            icon: Icon(Icons.done_outline_rounded),
          ),
          BottomNavigationBarItem(
            label: "Notifications",
            icon: Icon(Icons.notifications_none),
          ),
        ],
      ),
    );
  }
}
/**
   Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSearchExpanded = !_isSearchExpanded;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: 50,
                          width: _isSearchExpanded ? 220 : 50,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              AnimatedCrossFade(
                                duration: Duration(milliseconds: 200),
                                firstChild: Icon(Icons.search),
                                secondChild: Icon(
                                  Icons.arrow_forward_ios,
                                ),
                                crossFadeState:
                                    !_isSearchExpanded
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                              ),
                              if (_isSearchExpanded) ...[
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "search courses...",
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                
 */

// this is old widget , before the exception incorrect use of parent data widget
/*
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/student_profile_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/certificates_widget.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/my_learning_widget.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/notifications_widget.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/show_available_courses.dart';

// ignore: must_be_immutable
class StudentDashboard extends StatefulWidget {
  String currentStudentId;
  StudentDashboard({super.key, required this.currentStudentId});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedIndex = 0;
  bool _isSearchExpanded = false;

  void _onTapBottomBar(int tempIndex) {
    setState(() {
      _selectedIndex = tempIndex;
    });
  }

  Widget _getSelectedPage(int index) {
    switch (index) {
      case 0:
        return ShowAvailableCoursesWidget(
          studentId: widget.currentStudentId,
        );
      case 1:
        return MyLearningWidget(studentId: widget.currentStudentId);
      case 2:
        return CertificatesWidget();
      case 3:
        return NotificationsWidget();
      default:
        return ShowAvailableCoursesWidget(
          studentId: widget.currentStudentId,
          
        );
    }
  }

 

  @override
  Widget build(BuildContext context) {
    print(
      "**************************************************************-------------------------**************-------------------****************** this is studnet id in student Dashboard ${widget.currentStudentId}",
    );
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          InkWell(
            onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => StudentProfilePage(studentId:widget.currentStudentId),)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                elevation: 2,
                child: Row(
                  children: [
                    // User Info
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.orange,
                            child: Icon(Icons.person_off_outlined),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Salah Mohammed",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "Intermediate Level",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    // Search bar
                  ],
                ),
              ),
            ),
          ),

          // Selected Page
          _getSelectedPage(_selectedIndex),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTapBottomBar,
        selectedItemColor: Colors.deepPurple[500],
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            label: "Courses",
            icon: Icon(Icons.menu_book_rounded),
          ),
          BottomNavigationBarItem(
            label: "My Learning",
            icon: Icon(Icons.bookmark_border),
          ),
          BottomNavigationBarItem(
            label: "Certificates",
            icon: Icon(Icons.done_outline_rounded),
          ),
          BottomNavigationBarItem(
            label: "Notifications",
            icon: Icon(Icons.notifications_none),
          ),
        ],
      ),
    );
  }
}
/**
   Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSearchExpanded = !_isSearchExpanded;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: 50,
                          width: _isSearchExpanded ? 220 : 50,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              AnimatedCrossFade(
                                duration: Duration(milliseconds: 200),
                                firstChild: Icon(Icons.search),
                                secondChild: Icon(
                                  Icons.arrow_forward_ios,
                                ),
                                crossFadeState:
                                    !_isSearchExpanded
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                              ),
                              if (_isSearchExpanded) ...[
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "search courses...",
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                
 */
 */
