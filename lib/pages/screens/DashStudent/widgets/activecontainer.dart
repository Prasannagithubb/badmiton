// import 'package:badmiton_app/constant/Screen.dart';
// import 'package:badmiton_app/controller/dashbatchconroller/batch_list_provider.dart';
// import 'package:badmiton_app/controller/dashstudentcontroller.dart/add_student_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ActiveContainerList extends StatelessWidget {
//   const ActiveContainerList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: Screens.bodyheight(context) * 0.12,
//       width: Screens.width(context),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15), // Smoother rounded corners
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child:
//       ListView.builder(
//         itemCount: context.read<AddStudentProvider>().addstudents.length,
//         itemBuilder: (context, index) {
//           var student = context.watch<AddStudentProvider>().addstudents[index];
//           var batchName = context.watch<BatchListProvider>().batches[index];
//           return
//           Container(
//             margin: const EdgeInsets.all(8),  // Adds space around each row for better clarity
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.grey.shade100,  // Light grey color for each list item for better contrast
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Theme.of(context).primaryColor,
//                   child: Text(
//                     student.studentname[0],  // First letter of the student's name
//                     style: const TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           student.studentname,
//                           style: const TextStyle(
//                               color: Colors.black87,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         Text(
//                           batchName.name,
//                           style: const TextStyle(color: Colors.black54),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.secondary),
//                   onPressed: () {
                    
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.redAccent),
//                   onPressed: () {
                    
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
