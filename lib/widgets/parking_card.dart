// import 'package:flutter/material.dart';
// import '../core/constants/colors.dart';
// import '../models/parking_option.dart';

// class ParkingCard extends StatelessWidget {
//   final Parking vehicle;
//   final int quantity;
//   final VoidCallback onAdd;
//   final VoidCallback onRemove;
//   final VoidCallback onAddToCart;

//   const ParkingCard({
//     super.key,
//     required this.vehicle,
//     required this.quantity,
//     required this.onAdd,
//     required this.onRemove,
//     required this.onAddToCart,
//   });

//   IconData _getIcon() {
//     switch (vehicle.vehicleType.toLowerCase()) {
//       case 'car':
//         return Icons.directions_car;
//       case 'bike':
//         return Icons.pedal_bike;
//       case 'bus':
//         return Icons.directions_bus;
//       default:
//         return Icons.local_parking;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 4,
//       margin: const EdgeInsets.all(8),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             Icon(_getIcon(), size: 40, color: AppColors.blue),
//             const SizedBox(height: 8),
//             Text(vehicle.vehicleType,
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Text("₹${vehicle.price}",
//                 style: const TextStyle(fontSize: 16, color: Colors.grey)),
//             const SizedBox(height: 12),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(onPressed: onRemove, icon: const Icon(Icons.remove)),
//                 Text('$quantity', style: const TextStyle(fontSize: 16)),
//                 IconButton(onPressed: onAdd, icon: const Icon(Icons.add)),
//               ],
//             ),
//             const SizedBox(height: 8),
//             ElevatedButton.icon(
//               onPressed: onAddToCart,
//               icon: const Icon(Icons.add),
//               label: const Text('Add'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.blue,
//                 foregroundColor: AppColors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../models/parking_option.dart';

// class ParkingCard extends StatelessWidget {
//   final ParkingOption option;
//   final int quantity;
//   final VoidCallback onAdd;
//   final VoidCallback onRemove;

//   const ParkingCard({
//     super.key,
//     required this.option,
//     required this.quantity,
//     required this.onAdd,
//     required this.onRemove,
//   });

//   String getLabel(String type) {
//     switch (type) {
//       case 'two_wheeler':
//         return "Two-Wheeler";
//       case 'four_wheeler':
//         return "Four-Wheeler";
//       case 'school_bus':
//         return "School Bus";
//       default:
//         return type;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 3,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(children: [
//           Icon(Icons.local_parking, size: 48, color: Colors.deepPurple),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(getLabel(option.vehicleType),
//                     style: const TextStyle(fontWeight: FontWeight.bold)),
//                 Text("₹${option.price}", style: const TextStyle(fontSize: 16)),
//               ],
//             ),
//           ),
//           Column(
//             children: [
//               IconButton(icon: const Icon(Icons.add), onPressed: onAdd),
//               Text('$quantity'),
//               IconButton(icon: const Icon(Icons.remove), onPressed: onRemove),
//             ],
//           )
//         ]),
//       ),
//     );
//   }
// }

