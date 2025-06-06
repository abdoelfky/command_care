import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../data/doctor_model.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctorModel;
  final VoidCallback onDelete; // Callback for delete action
  final VoidCallback onEdit;   // Callback for edit action

  const DoctorCard({
    super.key,
    required this.doctorModel,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(doctorModel.id.toString()), // Unique key for each patient
      direction: DismissDirection.horizontal,
      background: _buildSwipeAction(
        context,
        icon: Icons.edit,
        color: Colors.blue,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        label: 'Edit',
      ),
      secondaryBackground: _buildSwipeAction(
        context,
        icon: Icons.delete,
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        label: 'Delete',
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onEdit(); // Trigger edit action
        } else if (direction == DismissDirection.endToStart) {
          onDelete(); // Trigger delete action
        }
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green.shade100,
            child: Text(
              doctorModel.name[0],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  'Dr ${doctorModel.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: Dimensions.paddingSizeExtraSmall,
              ),
              Chip(
                label: Text(
                  'View',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12, // Smaller font for compact design
                  ),
                ),
                backgroundColor: AppColors.nexusShadowGreen,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Increased radius
                ),
                materialTapTargetSize:
                MaterialTapTargetSize.shrinkWrap, // Reduces height
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeAction(
      BuildContext context, {
        required IconData icon,
        required Color color,
        required Alignment alignment,
        required EdgeInsets padding,
        required String label,
      }) {
    return Container(
      alignment: alignment,
      color: color,
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
