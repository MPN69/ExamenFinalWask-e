import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:waske_final_exam/firebase/services/employeeServices.dart';
import 'package:waske_final_exam/views/Employees/addEmployeePage.dart';
import 'package:waske_final_exam/views/Employees/employeeViewPage.dart';

import '../../widgets/gameCardWidget.dart';
import '../../widgets/loadingWidget.dart';
import 'editEmployeePage.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({Key? key}) : super(key: key);

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  Future<List<dynamic>> getEmployeeInfo() async {
    final List<dynamic> employees = await getEmployees();
    return employees;
  }

  Future<bool> isSignedIn() async {
    GoogleSignIn signIn = GoogleSignIn();
    bool isSignedIn = await signIn.isSignedIn();
    return isSignedIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<dynamic>>(
          future: getEmployeeInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingWidget();
            } else if (snapshot.hasError) {
              return const Text('Error al cargar los juegos');
            } else {
              final EmployeeList = snapshot.data!;
              return ListView.builder(
                itemCount: EmployeeList.length,
                itemBuilder: (context, index) {
                  final Employee = EmployeeList[index];
                  return SizedBox(
                    height: 200,
                    child: GestureDetector(
                      onTap: () async {
                        final isSigned = await isSignedIn();
                        if (isSigned) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditEmployeePage(
                                id: Employee["idEmpleado"].toString(),
                                name: Employee["Nombre"].toString(),
                                lastName: Employee["Apellido"].toString(),
                                email: Employee["Correo"].toString(),
                                image: Employee["Imagen"].toString(),
                                phone: Employee["Telefono"].toString(),
                                uid: Employee["uid"].toString(),
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmployeeViewPage(
                                employeeName: Employee['Nombre'].toString(),
                                employeeLastName:
                                    Employee['Apellido'].toString(),
                                employeeMail: Employee['Correo'].toString(),
                                employeePicture: Employee['Imagen'].toString(),
                                employeePhone: Employee['Telefono'].toString(),
                              ),
                            ),
                          );
                        }
                      },
                      child: GameCardWidget(
                        gameTitle: Employee["Nombre"],
                        gameImage: Employee["Imagen"],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FutureBuilder<bool>(
          future: isSignedIn(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddEmployeePage(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
