//Crud de firebase
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firebaseDatabase = FirebaseFirestore.instance;

//Client section----------------------------------------------------
Future<List> getEmployees() async {
  List employees = [];

  CollectionReference collectionOfEmployees =
      firebaseDatabase.collection('Empleados');
  QuerySnapshot queryEmployees = await collectionOfEmployees.get();

  queryEmployees.docs.forEach((doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final employee = {
      "idEmpleado": data["idEmpleado"],
      "Nombre": data["Nombre"],
      "Apellido": data["Apellido"],
      "Correo": data["Correo"],
      "Imagen": data["Imagen"],
      "Telefono": data["Telefono"],
      "uid": doc.id,
    };
    employees.add(employee);
  });

  return employees;
}

Future<Map<String, dynamic>> getEmployeeInfo(String employeeName) async {
  Map<String, dynamic> employee = <String, dynamic>{};

  CollectionReference collectionOfEmployees =
      firebaseDatabase.collection("Juegos");
  QuerySnapshot queryEmployee = await collectionOfEmployees.get();

  queryEmployee.docs.forEach((employeer) {
    final dynamic data = employeer.data();
    if (data["Nombre"] == employeeName) {
      employee = {
        "idEmpleado": data["idEmpleado"],
        "Nombre": data["Nombre"],
        "Apellido": data["Apellido"],
        "Correo": data["Correo"],
        "Imagen": data["Imagen"],
        "Telefono": data["Telefono"],
        "uid": employeer.id,
      };
    } else {
      employee = {
        "idEmpleado": "Empleado no Encontrado",
        "Nombre": "Empleado no Encontrado",
        "Apellido": "Empleado no Encontrado",
        "Correo": "Empleado no Encontrado",
        "Imagen": "Empleado no Encontrado",
        "Telefono": "Empleado no Encontrado",
        "uid": employeer.id,
      };
    }
    print(employeer["Nombre"]);
  });
  return employee;
}

Future<bool> addEmployee(String name, String lastName, String email,
    String image, String phone, String id) async {
  try {
    await firebaseDatabase.collection("Empleados").add({
      "Nombre": name,
      "Apellido": lastName,
      "Correo": email,
      "Imagen": image,
      "Telefono": phone,
      "idEmpleado": id,
    });
  } catch (e) {
    print(e.toString());
    return false;
  }
  return false;
}

Future<void> updateEmployee(String uid, String name, String lastName,
    String email, String image, String phone, String id) async {
  await firebaseDatabase.collection("Empleados").doc(uid).set({
    "Nombre": name,
    "Apellido": lastName,
    "Correo": email,
    "Imagen": image,
    "Telefono": phone,
    "idEmpleado": id,
  });
}

Future<void> deleteEmployee(String uid) async {
  await firebaseDatabase.collection("Empleados").doc(uid).delete();
}
