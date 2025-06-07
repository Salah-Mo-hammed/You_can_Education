// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/core/colors/app_color.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_courses_bloc/center_courses_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:animate_do/animate_do.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

// ignore: must_be_immutable
class AddCoursePage extends StatefulWidget {
  String centerId;
  List<TrainerEntity> availableTrainers;
  AddCoursePage({
    super.key,
    required this.centerId,
    required this.availableTrainers,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final TextEditingController titleController =
      TextEditingController();
  final TextEditingController descriptionController =
      TextEditingController();
  final TextEditingController maxStudentsController =
      TextEditingController();
  final TextEditingController priceController =
      TextEditingController();
  final TextEditingController imageUrlController =
      TextEditingController();
  String? selectedTrainerId;
  String? selectedTrainerName;
  DateTime? startDate;
  DateTime? endDate;
  Future<void> _selectDate(
    BuildContext context,
    bool isStartDate,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = AppColors.brown;

    return Scaffold(
      appBar: AppBar(
        title: FadeInDown(
          duration: Duration(milliseconds: 700),
          child: Text(
            "Add Course",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
        width: double.infinity,
        color: Colors.grey[50],
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Card(
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FadeInDown(
                        duration: Duration(milliseconds: 450),
                        child: Text(
                          "Create New Course",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: mainColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 18),
                      FadeInUp(
                        delay: Duration(milliseconds: 80),
                        child: _buildTextField(
                          titleController,
                          'Title',
                          icon: Icons.title,
                        ),
                      ),
                      FadeInUp(
                        delay: Duration(milliseconds: 160),
                        child: _buildTextField(
                          descriptionController,
                          'Description',
                          icon: Icons.description,
                          maxLines: 3,
                        ),
                      ),
                      FadeInUp(
                        delay: Duration(milliseconds: 240),
                        child: _buildTextField(
                          maxStudentsController,
                          'Max Students',
                          isNumber: true,
                          icon: Icons.group,
                        ),
                      ),
                      FadeInUp(
                        delay: Duration(milliseconds: 320),
                        child: _buildTextField(
                          priceController,
                          'Price',
                          isNumber: true,
                          icon: Icons.attach_money,
                        ),
                      ),
                      FadeInUp(
                        delay: Duration(milliseconds: 400),
                        child: _buildDatePickerField(
                          label: "Start Date",
                          selectedDate: startDate,
                          icon: Icons.calendar_today,
                          onTap: () => _selectDate(context, true),
                        ),
                      ),
                      FadeInUp(
                        delay: Duration(milliseconds: 480),
                        child: _buildDatePickerField(
                          label: "End Date",
                          selectedDate: endDate,
                          icon: Icons.event,
                          onTap: () => _selectDate(context, false),
                        ),
                      ),
                      FadeInUp(
                        delay: Duration(milliseconds: 560),
                        child: _buildTextField(
                          imageUrlController,
                          'image url (optional)',
                          icon: Icons.image,
                        ),
                      ),
                      FadeInUp(
                        delay: Duration(milliseconds: 640),

                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await showModalBottomSheet<
                              String
                            >(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              isScrollControlled: true,
                              builder: (context) {
                                return SafeArea(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Container(
                                            width: 40,
                                            height: 4,
                                            margin: EdgeInsets.only(
                                              bottom: 16,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    2,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Select a Trainer',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Flexible(
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            itemCount:
                                                widget
                                                    .availableTrainers
                                                    .length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    Divider(),
                                            itemBuilder: (
                                              context,
                                              index,
                                            ) {
                                              final trainer =
                                                  widget
                                                      .availableTrainers[index];
                                              return ListTile(
                                                leading: CircleAvatar(
                                                  child: Icon(
                                                    Icons.person,
                                                  ),
                                                ),
                                                title: Text(
                                                  trainer.name,
                                                ),
                                                trailing: Icon(
                                                  Icons
                                                      .arrow_forward_ios,
                                                  size: 16,
                                                ),
                                                onTap: () {
                                                  selectedTrainerName =
                                                      trainer.name;
                                                  Navigator.pop(
                                                    context,
                                                    trainer.uid,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );

                            if (result != null) {
                              setState(() {
                                selectedTrainerId = result;
                              });
                            }
                          },
                          child: Text(
                            selectedTrainerName ?? 'select trainer',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                        delay: Duration(milliseconds: 720),
                        child: BlocBuilder<
                          CenterCoursesBloc,
                          CenterCoursesState
                        >(
                          builder: (context, state) {
                            if (state is CenterCoursesLoadingState) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: mainColor,
                                ),
                              );
                            } else if (state
                                is CenterAddedCourseState) {
                              return Center(
                                child: Text(
                                  "Course created successfully!",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  25,
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.gold,
                                    AppColors.bronze,
                                  ],
                                ),
                              ),
                              child: ElevatedButton.icon(
                                icon: Icon(
                                  Icons.save,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                label: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 11.0,
                                  ),
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(16),
                                  ),
                                  elevation: 3,
                                  shadowColor: mainColor.withOpacity(
                                    0.3,
                                  ),
                                ),
                                onPressed: () {
                                  print(
                                    "*-*-*--*-*-*--*-*-*-*-*-*-**-*-*-${imageUrlController.text}",
                                  );
                                  final course = CourseEntity(
                                    imageUrl: imageUrlController.text,
                                    title: titleController.text,
                                    description:
                                        descriptionController.text,
                                    centerId: widget.centerId,
                                    startDate:
                                        startDate ?? DateTime.now(),
                                    endDate:
                                        endDate ?? DateTime.now(),
                                    maxStudents:
                                        int.tryParse(
                                          maxStudentsController.text,
                                        ) ??
                                        0,
                                    price:
                                        double.tryParse(
                                          priceController.text,
                                        ) ??
                                        0,
                                    courseId: '',
                                    trainerId: selectedTrainerId!,
                                  );
                                  context
                                      .read<CenterCoursesBloc>()
                                      .add(
                                        AddCourseEvent(
                                          addCourseEntity: course,
                                        ),
                                      );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isNumber = false,
    int maxLines = 1,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: TextField(
        controller: controller,
        keyboardType:
            isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon:
              icon != null ? Icon(icon, color: Colors.black) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerField({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            prefixIcon:
                icon != null ? Icon(icon, color: Colors.black) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 14,
            ),
          ),
          child: Text(
            selectedDate == null
                ? "Select Date"
                : "${selectedDate.toLocal()}".split(' ')[0],
            style: TextStyle(
              fontSize: 16,
              color:
                  selectedDate == null ? Colors.grey : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
