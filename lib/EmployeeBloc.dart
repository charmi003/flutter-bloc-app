//TODO: imports
//TODO: List of employees
//TODO: Stream controllers
//TODO: Stream Sink Getter
//TODO: Constructor-add data, listen to changes
//TODO: Core functions
//TODO: dispose


import 'dart:async';
import './Employee.dart';

class EmployeeBloc{

  //* LIST OF EMPLOYEES
  List<Employee> employeeList=[
    Employee(id: 1, name: 'Employee 1', salary: 45000),
    Employee(id: 2, name: 'Employee 2', salary: 50000),
    Employee(id: 3, name: 'Employee 3', salary: 67000),
    Employee(id: 4, name: 'Employee 4', salary: 35000),
    Employee(id: 5, name: 'Employee 5', salary: 54000)
  ];


  //* STREAM CONTROLLERS
  final employeeListStreamController=StreamController<List<Employee>>();

  //? for inc and dec
  final employeeSalaryIncController=StreamController<Employee>();
  final employeeSalaryDecController=StreamController<Employee>();

  //*GETTERS
  Stream<List<Employee>> get employeeListStream => employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink => employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncSink => employeeSalaryIncController.sink;

  StreamSink<Employee> get employeeSalaryDecSink => employeeSalaryDecController.sink;


  //*CONSTRUCTOR
  EmployeeBloc(){
    employeeListStreamController.add(employeeList);
    employeeSalaryIncController.stream.listen(incrementSalary);
    employeeSalaryDecController.stream.listen(decrementSalary);
  } 

  //*CORE FUNCTIONS
  incrementSalary(Employee emp){
    String newSalaryString=(emp.salary + (20/100)*emp.salary).toStringAsFixed(2);
    double newSalary=double.parse(newSalaryString);
    employeeList[emp.id-1].salary=newSalary;
    employeeListSink.add(employeeList);
  }

  decrementSalary(Employee emp){
    String newSalaryString=(emp.salary - (20/100)*emp.salary).toStringAsFixed(2);
    double newSalary=double.parse(newSalaryString);
    employeeList[emp.id-1].salary=newSalary;
    employeeListSink.add(employeeList);
  }

  //* DISPOSE
  void dispose(){
    employeeListStreamController.close();
    employeeSalaryIncController.close();
    employeeSalaryDecController.close();
  }
}

