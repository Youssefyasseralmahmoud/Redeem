
//   CountdownTimer(
//                       endTime: endTime,
//                       widgetBuilder: (_, CurrentRemainingTime? time) {
//                         return Row(
//                           children: [
//                             Container(
//                               width: 40,
//                               height: 40,
//                               margin: EdgeInsetsDirectional.only(end: 10),
//                               child: Stack(
//                                 children: [
//                                   Container(
//                                     width: 40,
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       border: Border.all(
//                                           width: 1.5,
//                                           color: Colors.grey.shade300),
//                                     ),
//                                   ),
//                                   Container(
//                                     padding:
//                                         EdgeInsetsDirectional.only(start: 7),
//                                     alignment: AlignmentDirectional.centerStart,
//                                     child: Text(time!.days != null
//                                         ? time.days.toString()
//                                         : "0"),
//                                   ),
//                                   PositionedDirectional(
//                                       child: Container(
//                                         color: Colors.white,
//                                         width: 10,
//                                         height: 25,
//                                         child: Text("d"),
//                                         padding: EdgeInsetsDirectional.only(
//                                             bottom: 5),
//                                       ),
//                                       end: 0,
//                                       top: 7),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               width: 40,
//                               height: 40,
//                               margin: EdgeInsetsDirectional.only(end: 10),
//                               child: Stack(
//                                 children: [
//                                   Container(
//                                     width: 40,
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       border: Border.all(
//                                           width: 1.5,
//                                           color: Colors.grey.shade300),
//                                     ),
//                                   ),
//                                   Container(
//                                     padding:
//                                         EdgeInsetsDirectional.only(start: 7),
//                                     alignment: AlignmentDirectional.centerStart,
//                                     child: Text(time.hours != null
//                                         ? time.hours.toString()
//                                         : "0"),
//                                   ),
//                                   PositionedDirectional(
//                                       child: Container(
//                                         color: Colors.white,
//                                         width: 10,
//                                         height: 25,
//                                         child: Text("h"),
//                                         padding: EdgeInsetsDirectional.only(
//                                             bottom: 5),
//                                       ),
//                                       end: 0,
//                                       top: 7),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               width: 40,
//                               height: 40,
//                               margin: EdgeInsetsDirectional.only(end: 10),
//                               child: Stack(
//                                 children: [
//                                   Container(
//                                     width: 40,
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       border: Border.all(
//                                           width: 1.5,
//                                           color: Colors.grey.shade300),
//                                     ),
//                                   ),
//                                   Container(
//                                     padding:
//                                         EdgeInsetsDirectional.only(start: 7),
//                                     alignment: AlignmentDirectional.centerStart,
//                                     child: Text(time.min != null
//                                         ? time.min.toString()
//                                         : "0"),
//                                   ),
//                                   PositionedDirectional(
//                                       child: Container(
//                                         color: Colors.white,
//                                         width: 10,
//                                         height: 25,
//                                         child: Text("m"),
//                                         padding: EdgeInsetsDirectional.only(
//                                             bottom: 5),
//                                       ),
//                                       end: 0,
//                                       top: 7),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               width: 40,
//                               height: 40,
//                               margin: EdgeInsetsDirectional.only(end: 10),
//                               child: Stack(
//                                 children: [
//                                   Container(
//                                     width: 40,
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       border: Border.all(
//                                           width: 1.5,
//                                           color: Colors.grey.shade300),
//                                     ),
//                                   ),
//                                   Container(
//                                     padding:
//                                         EdgeInsetsDirectional.only(start: 7),
//                                     alignment: AlignmentDirectional.centerStart,
//                                     child: Text(time.sec != null
//                                         ? time.sec.toString()
//                                         : "0"),
//                                   ),
//                                   PositionedDirectional(
//                                       child: Container(
//                                         color: Colors.white,
//                                         width: 10,
//                                         height: 25,
//                                         child: Text("s"),
//                                         padding: EdgeInsetsDirectional.only(
//                                             bottom: 5),
//                                       ),
//                                       end: 0,
//                                       top: 7),
//                                 ],
//                               ),
//                             )
//                           ],
//                         );
//                       },
//                     )
// apps-fileview.texmex_20240314.01_p3
// CountdownTimer.txt
// Displaying CountdownTimer.txt.