import 'package:flutter/material.dart';
import './Employee.dart';
import 'EmployeeBloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeBloc employeeBloc = EmployeeBloc();

  @override
  void dispose(){
    super.dispose();
    employeeBloc.dispose();  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Employee App')
      ),
      body:StreamBuilder<List<Employee>>(
        stream:employeeBloc.employeeListStream,
        builder: (BuildContext context,AsyncSnapshot<List<Employee>> snapshot){
          if(snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
          if(snapshot.connectionState==ConnectionState.waiting) {
            return const Center(
              child:CircularProgressIndicator()
            );
          } else {
            var empList=snapshot.data!;
            return ListView.builder(
            itemCount: empList.length,
            itemBuilder: (BuildContext context,int index) => Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('${empList[index].id}.', style:TextStyle(fontSize: 20)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text('${empList[index].name}', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text('\u{20B9} ${empList[index].salary.toStringAsFixed(2)}', style:TextStyle(fontSize: 16),)
                      ]
                    ),
                    IconButton(
                      onPressed:(){
                        employeeBloc.employeeSalaryIncSink.add(empList[index]);
                      },
                      icon: Icon(Icons.thumb_up_alt, color: Colors.green, size: 28,)
                    ),
                    IconButton(
                      onPressed:(){
                        employeeBloc.employeeSalaryDecSink.add(empList[index]);
                      },
                      icon: Icon(Icons.thumb_down_alt, color: Colors.red, size: 28,)
                    ),
                  ],
                ),
              ),
            ),

          );
          }
        }
      )
    );
  }
}