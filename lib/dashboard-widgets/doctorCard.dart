import 'package:flutter/material.dart';

class Doctor extends StatelessWidget {
  final String id;
  final String name;
  final String specialization;
  final String description;
  final String address;
  final double rating;
  final String? imageUrl;
  final VoidCallback? onTap;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.rating,
    required this.description,
    required this.address,
    this.imageUrl,
    this.onTap,
    super.key,
  });

  static const String defaultImageUrl =
      'https://images.freeimages.com/images/large-previews/711/medical-doctor-1236694.jpg';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl!)
                        : NetworkImage(defaultImageUrl),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200, // Adjust the width as needed
                        child: Text(
                          name.length > 20
                              ? '${name.substring(0, 20)}...'
                              : name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                      Container(
                        width: 200, // Adjust the width as needed
                        child: Text(
                          specialization.length > 20
                              ? '${specialization.substring(0, 20)}...'
                              : specialization,
                          style: TextStyle(color: Colors.grey[700]),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                      // Text(
                      //   specialization,
                      //   style: TextStyle(color: Colors.grey[700]),
                      // ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      const SizedBox(width: 5),
                      Text(
                        rating.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Implement appointment functionality here
                      // For example, navigate to an appointment screen
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Appointment'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
