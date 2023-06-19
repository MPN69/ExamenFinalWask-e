import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:examenfinalwask_e/firebase/services/employeeServices.dart';
import 'package:examenfinalwask_e/views/Employees/addEmployeePage.dart';
import 'package:examenfinalwask_e/views/Employees/employeeViewPage.dart';

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
            return const Text('Error al cargar los empleados');
          } else {
            final employeeList = snapshot.data!;
            return ListView.builder(
              itemCount: employeeList.length,
              itemBuilder: (context, index) {
                final employee = employeeList[index];
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
                              id: employee["idEmpleado"].toString(),
                              name: employee["Nombre"].toString(),
                              lastName: employee["Apellido"].toString(),
                              email: employee["Correo"].toString(),
                              image: employee["Imagen"].toString(),
                              phone: employee["Telefono"].toString(),
                              uid: employee["uid"].toString(),
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmployeeViewPage(
                              employeeName: employee['Nombre'].toString(),
                              employeeLastName: employee['Apellido'].toString(),
                              employeeMail: employee['Correo'].toString(),
                              employeePicture: employee['Imagen'].toString(),
                              employeePhone: employee['Telefono'].toString(),
                            ),
                          ),
                        );
                      }
                    },
                    child: GameCardWidget(
                      gameTitle: employee["Nombre"],
                      gameImage: employee["Imagen"],
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
      ),
    );
  }
}
