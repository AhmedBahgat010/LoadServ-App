import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;

  SearchSection({required this.searchController, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search here',
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Icon(Icons.search, size: 32),
                suffixIcon: IconButton(
                  icon: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 12,
                    child: Center(child: Icon(Icons.close, color: Colors.black, size: 20)),
                  ),
                  onPressed: () {
                    searchController.clear();
                    onSearch(''); // Clear the filter when the close icon is clicked
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: onSearch,
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(8),
            child: Center(child: Icon(Icons.filter_list, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
