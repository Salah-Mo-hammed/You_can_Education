// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:grad_project_ver_1/core/colors/app_color.dart';
import 'package:grad_project_ver_1/core/splash_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_courses_bloc/center_courses_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_general_bloc/center_general_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_requests_bloc/center_requests_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_state.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/add_course_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/add_trainer_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/center_course_details_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/edit_center_profil_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

class CenterDashboard extends StatefulWidget {
  final String centerId;
  late List<TrainerEntity> availableTrainers;
  CenterDashboard({super.key, required this.centerId});

  @override
  _CenterDashboardState createState() => _CenterDashboardState();
}

class _CenterDashboardState extends State<CenterDashboard> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    //!get the center from the firestore
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Gradient background using your gold/bronze tones
    return Scaffold(
      appBar: AppBar(
        title: FadeInDown(
          duration: Duration(milliseconds: 700),
          child: Text(
            "Center Dashboard",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.darkGray,
              fontSize: 22,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 9,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gold, AppColors.bronze],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.brown),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF7EEDD), // pastel beige (matches gold)
              Color(0xFFFDF6EE), // lighter peach
              Colors.white,
            ],
          ),
        ),
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildCoursesPage(),
            _buildJoinRequestsPage(),
            _buildTrainersPage(),
            _buildProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gold.withOpacity(0.18), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.bronze.withOpacity(0.09),
              blurRadius: 16,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Courses',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pending_actions),
              label: 'Requests',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined),
              label: 'trainers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.bronze,
          unselectedItemColor: AppColors.silverGray,
          onTap: _onItemTapped,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
      floatingActionButton: FadeInUp(
        duration: const Duration(milliseconds: 420),
        child: FloatingActionButton(
          backgroundColor: AppColors.bronze,
          elevation: 7,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => AddCoursePage(
                      centerId: widget.centerId,
                      availableTrainers: widget.availableTrainers,
                    ),
              ),
            );
          },
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
    );
  }

  //! done Scaffold**********************************************************************
  Widget _buildCoursesPage() {
    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 650),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 8,
                color: AppColors.gold.withOpacity(0.14),
                shadowColor: AppColors.brown.withOpacity(0.17),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Courses",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColors.brown,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        "Manage your courses efficiently!",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.mediumGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Expanded(
              child: BlocBuilder<
                CenterCoursesBloc,
                CenterCoursesState
              >(
                builder: (context, state) {
                  if (state is CenterGotCoursesState) {
                    if (state.courses.isEmpty) {
                      return Center(
                        child: FadeInUp(
                          child: Text(
                            "There are no courses yet.",
                            style: TextStyle(
                              color: AppColors.bronze,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      separatorBuilder:
                          (_, __) => const SizedBox(height: 14),
                      itemCount: state.courses.length,
                      itemBuilder:
                          (context, index) => FadeInUp(
                            duration: Duration(
                              milliseconds: 300 + index * 90,
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  14,
                                ),
                              ),
                              color: Colors.white,
                              elevation: 6,
                              shadowColor: AppColors.taupe
                                  .withOpacity(0.16),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: AppColors.taupe
                                      .withOpacity(0.14),
                                  radius: 24,
                                  child: const Icon(
                                    Icons.school,
                                    color: AppColors.bronze,
                                    size: 29,
                                  ),
                                ),
                                title: Text(
                                  state.courses[index].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: AppColors.brown,
                                  ),
                                ),
                                subtitle: Text(
                                  state.courses[index].description,
                                  style: TextStyle(
                                    color: AppColors.mediumGray,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.gold.withOpacity(
                                      0.18,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "${state.courses[index].price}\$",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.bronze,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (
                                            context,
                                          ) => CourseDetailsForCenter(
                                            course:
                                                state.courses[index],
                                            trainers:
                                                widget
                                                    .availableTrainers,
                                            isForTrainer: false,
                                          ),
                                      // CourseDetailsPage(
                                      //   course:
                                      //       state.courses[index],
                                      //   isStudent: false,
                                      //   trainers:
                                      //       widget
                                      //           .availableTrainers,
                                      // ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                    );
                  } else if (state is CenterCoursesExceptionState) {
                    return FadeIn(
                      duration: const Duration(milliseconds: 350),
                      child: Center(
                        child: Text(
                          state.message.toString(),
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  } else {
                    context.read<CenterCoursesBloc>().add(
                      GetCenterCoursesEvent(
                        centerId: widget.centerId,
                      ),
                    );
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePage() {
    return FadeIn(
      duration: const Duration(milliseconds: 520),
      child: BlocBuilder<CenterGeneralBloc, CenterGeneralState>(
        builder: (context, state) {
          if (state is CenterGeneralLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.deepPurple,
                ),
              ),
            );
          } else if (state is CenterGeneralGotInfoState) {
            final info = state.centerInfo;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Column(
                children: [
                  // Profile Card with more compact design
                  Card(
                    elevation: 6,
                    shadowColor: Colors.deepPurple.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Avatar
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // Background circle
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.deepPurple
                                      .withOpacity(0.1),
                                ),
                              ),

                              // Avatar icon
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
                                  radius: 42,
                                  backgroundColor: Colors.deepPurple
                                      .withOpacity(0.2),
                                  child: ClipOval(
                                    child:
                                        info.imageUrl == null
                                            ? Image.asset(
                                              'assets/images/grad_logo.png',
                                              width: 84,
                                              height: 84,
                                              fit: BoxFit.cover,
                                            )
                                            : Image.network(
                                              info.imageUrl!,
                                              width: 84,
                                              height: 84,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => Image.asset(
                                                    'assets/images/grad_logo.png',
                                                    width: 84,
                                                    height: 84,
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
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Center Name
                          Text(
                            info.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Info Cards - Using separate cards for each piece of information
                  // Address Card
                  _buildInfoCard(
                    icon: Icons.location_on,
                    iconColor: Colors.redAccent.shade400,
                    title: "Address",
                    content: info.address,
                    delay: 100,
                  ),

                  const SizedBox(height: 10),

                  // Email Card
                  _buildInfoCard(
                    icon: Icons.email,
                    iconColor: Colors.blue.shade700,
                    title: "Email",
                    content: info.email,
                    delay: 200,
                  ),

                  const SizedBox(height: 10),

                  // Phone Card
                  _buildInfoCard(
                    icon: Icons.phone,
                    iconColor: Colors.green.shade600,
                    title: "Phone Number",
                    content: info.phoneNumber,
                    delay: 300,
                  ),

                  const SizedBox(height: 12),

                  // Description Card
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: Duration(milliseconds: 400),
                    child: Card(
                      elevation: 4,
                      shadowColor: Colors.deepPurple.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 18,
                                  color: Colors.deepPurple.shade600,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "About Us",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple.shade700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              info.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Edit Profile Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FadeInUp(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SplashPage(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.exit_to_app,
                            size: 20,
                          ),
                          label: const Text("Sign out"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                            shadowColor: Colors.deepPurple
                                .withOpacity(0.3),
                          ),
                        ),
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: Duration(milliseconds: 500),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => EditCenterProfilePage(
                                      centerInfo: info,
                                    ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit, size: 20),
                          label: const Text("Edit Profile"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                            shadowColor: Colors.deepPurple
                                .withOpacity(0.3),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Add some bottom padding to ensure space between content and bottom nav bar
                  const SizedBox(height: 16),
                ],
              ),
            );
          } else if (state is CenterGeneralExceptionState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 50,
                      color: Colors.red.shade700,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<CenterGeneralBloc>().add(
                          GetCenterInfoEvent(
                            centerId: widget.centerId,
                          ),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text("Try Again"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is CenterGeneralInitial ||
              state is CenterGeneralCreatedState) {
            context.read<CenterGeneralBloc>().add(
              GetCenterInfoEvent(centerId: widget.centerId),
            );

            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Fetching center info...",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Fetching center info... Unknown state: $state",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Helper method to build info cards
  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
    required int delay,
  }) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: Duration(milliseconds: delay),
      child: Card(
        elevation: 4,
        shadowColor: Colors.deepPurple.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 22, color: iconColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple.shade900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build information items
  Widget _buildInfoItem(
    IconData icon,
    Color iconColor,
    String title,
    String value,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(icon, size: 22, color: iconColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJoinRequestsPage() {
    return BlocBuilder<CenterRequestsBloc, CenterRequestsState>(
      builder: (context, state) {
        print("---------------------***** state in requests $state");
        // Trigger event once when widget is built
        if (state is CenterRequestsInitial) {
          context.read<CenterRequestsBloc>().add(
            GetCenterRequestsEvent(centerId: widget.centerId),
          );
          return const Center(child: Text("wait please...."));
        }

        if (state is CenterRequestsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CenterRequestsDoneState) {
          final requests = state.requests;

          if (requests.isEmpty) {
            return const Center(
              child: Text("No join requests found."),
            );
          }

          return FadeIn(
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 650),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 8,
                      color: AppColors.gold.withOpacity(0.14),
                      shadowColor: AppColors.brown.withOpacity(0.17),
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Check Requests",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: AppColors.brown,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              "Review and approve student requests.",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.mediumGray,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder:
                          (_, __) => const SizedBox(height: 14),
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final request = requests[index];
                        return FadeInUp(
                          duration: Duration(
                            milliseconds: 300 + index * 90,
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 6,
                            color: Colors.white,
                            shadowColor: AppColors.taupe.withOpacity(
                              0.16,
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppColors.taupe
                                    .withOpacity(0.14),
                                radius: 24,
                                child: const Icon(
                                  Icons.person,
                                  color: AppColors.bronze,
                                  size: 26,
                                ),
                              ),
                              title: Text(
                                request['studentName'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.brown,
                                ),
                              ),
                              subtitle: Text(
                                "Requested to join: ${request['courseName']}",
                                style: TextStyle(
                                  color: AppColors.mediumGray,
                                ),
                              ),
                              trailing: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.gold,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  context
                                      .read<CenterRequestsBloc>()
                                      .add(
                                        ApproveJoinRequestEvent(
                                          requestMap: request,
                                        ),
                                      );
                                },
                                child: const Text(
                                  "Approve",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is CenterRequestsExceptionState) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  // Widget _buildJoinRequestsPage() {
  //   final dummyRequests = [
  //     {
  //       "studentName": "Alice Johnson",
  //       "courseTitle": "Flutter Development",
  //     },
  //     {"studentName": "Bob Smith", "courseTitle": "Advanced Java"},
  //   ];

  //   return FadeIn(
  //     duration: const Duration(milliseconds: 500),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           FadeInDown(
  //             duration: const Duration(milliseconds: 650),
  //             child: Card(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18),
  //               ),
  //               elevation: 8,
  //               color: AppColors.gold.withOpacity(0.14),
  //               shadowColor: AppColors.brown.withOpacity(0.17),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(22.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       "Join Requests",
  //                       style: TextStyle(
  //                         fontSize: 25,
  //                         fontWeight: FontWeight.bold,
  //                         color: AppColors.brown,
  //                       ),
  //                     ),
  //                     const SizedBox(height: 7),
  //                     Text(
  //                       "Review and approve student requests.",
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         color: AppColors.mediumGray,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 22),
  //           Expanded(
  //             //! requests in center
  //             child: ListView.separated(
  //               separatorBuilder:
  //                   (_, __) => const SizedBox(height: 14),
  //               itemCount: dummyRequests.length,
  //               itemBuilder: (context, index) {
  //                 final request = dummyRequests[index];
  //                 return FadeInUp(
  //                   duration: Duration(
  //                     milliseconds: 300 + index * 90,
  //                   ),
  //                   child: Card(
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(14),
  //                     ),
  //                     elevation: 6,
  //                     color: Colors.white,
  //                     shadowColor: AppColors.taupe.withOpacity(0.16),
  //                     child: ListTile(
  //                       leading: CircleAvatar(
  //                         backgroundColor: AppColors.taupe
  //                             .withOpacity(0.14),
  //                         radius: 24,
  //                         child: const Icon(
  //                           Icons.person,
  //                           color: AppColors.bronze,
  //                           size: 26,
  //                         ),
  //                       ),
  //                       title: Text(
  //                         request["studentName"]!,
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 18,
  //                           color: AppColors.brown,
  //                         ),
  //                       ),
  //                       subtitle: Text(
  //                         "Requested to join: ${request["courseTitle"]}",
  //                         style: TextStyle(
  //                           color: AppColors.mediumGray,
  //                         ),
  //                       ),
  //                       trailing: ElevatedButton(
  //                         style: ElevatedButton.styleFrom(
  //                           backgroundColor: AppColors.gold,
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(8),
  //                           ),
  //                         ),
  //                         onPressed: () {
  //                           // Approve action placeholder
  //                         },
  //                         child: const Text(
  //                           "Approve",
  //                           style: TextStyle(
  //                             color: AppColors.bronze,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildChatChannelPage() {
  //   return FadeIn(
  //     duration: const Duration(milliseconds: 520),
  //     child: Center(
  //       child: Card(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         elevation: 6,
  //         color: const Color(0xFFF7EEDD),
  //         shadowColor: AppColors.bronze.withOpacity(0.14),
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(
  //             horizontal: 36,
  //             vertical: 35,
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               const Icon(
  //                 Icons.chat,
  //                 size: 55,
  //                 color: AppColors.softBrown,
  //               ),
  //               const SizedBox(height: 15),
  //               Text(
  //                 "Chat Channel",
  //                 style: TextStyle(
  //                   fontSize: 23,
  //                   fontWeight: FontWeight.bold,
  //                   color: AppColors.brown,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildTrainersPage() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 650),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            AddTrainerPage(centerId: widget.centerId),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 8,
                color: AppColors.gold.withOpacity(0.14),
                shadowColor: AppColors.brown.withOpacity(0.17),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add a Trainer",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColors.brown,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        "Manage your trainers efficiently!",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.mediumGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<CenterTrainerBloc, CenterTrainerState>(
              builder: (context, state) {
                if (state is CenterGotTrainersState) {
                  final currentTrainers = state.trainers;
                  widget.availableTrainers = state.trainers;
                  if (currentTrainers.isEmpty) {
                    return Center(
                      child: Text(
                        "no trainers has been added for now !",
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: currentTrainers.length,
                      itemBuilder:
                          (context, index) => Card(
                            child: ListTile(
                              title: Text(
                                currentTrainers[index].name,
                              ),
                            ),
                          ),
                    );
                  }
                } else if (state is CenterTrainerExceptionState) {
                  return Center(child: Text(state.message));
                } else {
                  context.read<CenterTrainerBloc>().add(
                    FetchCenterTrainers(centerId: widget.centerId),
                  );
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text(
                          "state now in trainer in center dashboard is ${state}",
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
