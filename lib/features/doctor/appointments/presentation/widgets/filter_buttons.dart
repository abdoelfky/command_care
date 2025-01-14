import 'package:command_care/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FilterButtons extends StatefulWidget {
  final Function(String) onFilterSelected;

  const FilterButtons({super.key, required this.onFilterSelected});

  @override
  State<FilterButtons> createState() => _FilterButtonsState();
}

class _FilterButtonsState extends State<FilterButtons> {
  String selectedFilter = 'All';

  final List<String> filters = ['All', 'Latest', 'Pending', 'Completed', 'Cancelled'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(filter),
              selected: selectedFilter == filter,
              onSelected: (bool selected) {
                setState(() {
                  selectedFilter = filter;
                });
                widget.onFilterSelected(filter);
              },
              selectedColor: AppColors.buttonColor,
            ),
          );
        }).toList(),
      ),
    );
  }
}
