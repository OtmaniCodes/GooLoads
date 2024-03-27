// import 'package:flutter/material.dart';
// import 'package:widgetbook/widgetbook.dart';

// void main() {
//   runApp(HotReload());
// }

// class HotReload extends StatelessWidget {
//   const HotReload({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Widgetbook(
//       categories: [
//         Category(
//           name: 'widgets',
//           widgets: [
//             WidgetElement(
//               name: '$CustomWidget',
//               stories: [
//                 Story(
//                   name: 'My App',
//                   builder: (context) => CustomWidget(),
//                 ),
//               ],
//             ),
//           ],
         
//         ),
//       ],
//       appInfo: AppInfo(
//         name: 'Widget book',
//       ),
//     );
//   }
// }


// class CustomWidget extends StatelessWidget {
//   const CustomWidget({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       decoration: BoxDecoration(color: Colors.red),
//       height: 200,
//       width: 150,
//       alignment: Alignment.center,
//       child: Column(
//         children: [
//           Text("Ahmed El.O"),
//           Spacer(),
//           Text("Ahmed El.O"),
//           Spacer(),
//           Text("Ahmed El.O"),
//         ],
//       ),
//     );
//   }
// }