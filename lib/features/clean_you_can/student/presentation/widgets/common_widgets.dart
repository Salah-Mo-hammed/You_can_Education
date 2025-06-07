import 'package:flutter/material.dart';
import 'package:grad_project_ver_1/features/chat/presintation/pages/chat_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/center_course_details_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/course_details_for_student_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/course_sessions_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/enrolled_course_content_page.dart';

class CommonWidgets {
  // available courses or recent courses
  Padding buildHeaderText(String title, bool needWeight) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight:
              needWeight ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Padding buildSubTitleText(String subTitle) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Text(
        subTitle,
        style: TextStyle(color: Colors.grey[900]),
      ),
    );
  }

  InkWell buildCourseCard({
    required String currentStudentId,
    required List<CourseEntity> courses,
    required int index,
    required bool inMyLearning,
    required BuildContext context,
    String? currentStudentName,
  }) {
    return courses.isEmpty
        ? InkWell(
          child: Center(child: Text(" no courses syudepid student")),
        )
        : InkWell(
          onTap:
              () =>
                  !inMyLearning
                      ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => CourseDetailsForStudent(
                                course: courses[index],
                                studentId: currentStudentId,
                                // isInMyLearning: inMyLearning,
                              ),
                        ),
                      )
                      : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => CourseSessionsPage(
                                courseUrls: courses[index].urls,
                              ),
                        ),
                      ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 1.5,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.network(
                      courses[index].imageUrl == null
                          ? "https://imgs.search.brave.com/yFciH0dtD8HJZlPdobHcujhNe6DDXsC8M8_2AOwakCs/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9kM2Yx/aXlmeHh6OGkxZS5j/bG91ZGZyb250Lm5l/dC9jb3Vyc2VzL2Nv/dXJzZV9pbWFnZS81/YWUwZTA2MjQ0OTMu/anBn"
                          : courses[index].imageUrl!,
                      height: 100,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!inMyLearning) ...[
                          Text("  Technology"),
                          SizedBox(height: 8),
                        ],
                        Text(
                          courses[index].title,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.view_carousel_outlined,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              inMyLearning
                                  ? "$index lesson  of 20"
                                  // ignore: unnecessary_brace_in_string_interps
                                  : "${index} Lessons",
                            ),
                            if (!inMyLearning) ...[
                              SizedBox(width: 10),
                              Icon(
                                Icons.access_time_rounded,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text("6 weeks"),
                            ],
                          ],
                        ),
                        SizedBox(height: 8),
                        inMyLearning
                            ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 5,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                    children: [
                                      Text("progress"),
                                      Text("%70"),
                                    ],
                                  ),
                                ),
                                LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(
                                    25,
                                  ),
                                  value: 0.70,
                                  color: Colors.blue,
                                  minHeight: 10,
                                  backgroundColor: Colors.grey[300],
                                ),
                              ],
                            )
                            : Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "4.8 (245)",
                                  style: TextStyle(
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                      ],
                    ),
                  ),
                ),
                if (inMyLearning)
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ChatPage(
                                studentId: currentStudentId,
                                trainerId: courses[index].trainerId,
                                // courseId: courses[index].courseId,
                                currentUserId: currentStudentId,
                                currentUserName: currentStudentName!,
                              ),
                        ),
                      );
                    },
                    icon: Icon(Icons.chat),
                  ),
              ],
            ),
          ),
        );
  }

  Padding buildStack(bool inCertificates) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 12,
      ),
      child: Container(
        height: inCertificates ? 230 : 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Image.network(
                "https://imgs.search.brave.com/0YgVtL1osBsMJ2uF4LmlLE_N-_lr8dyCCR_Q7Gf4swU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAxLzkyLzAzLzg3/LzM2MF9GXzE5MjAz/ODczMl9ZYTdXSnRi/cldxYWoxb2lFOHF5/WExBYmZwT1V5MXl3/UC5qcGc",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: inCertificates ? 85 : 65,
                left: 15,
                child:
                    inCertificates
                        ? CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.star,
                            color: Colors.black,
                          ),
                        )
                        : Text(
                          "Featured",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
              ),
              Positioned(
                bottom: inCertificates ? 60 : 40,
                left: 15,
                child: Text(
                  "Modern Web Development",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),

              Positioned(
                left: 15,
                bottom: 20,
                child: Row(
                  children:
                      inCertificates
                          ? [
                            SizedBox(
                              height: 35,
                              width: 110,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "Preview",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              height: 35,
                              width: 120,

                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.file_download_outlined,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "download",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]
                          : [
                            Icon(
                              Icons.person_outline_sharp,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "325 Students",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.access_time_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "6 weeks",
                              style: TextStyle(color: Colors.white),
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
}
