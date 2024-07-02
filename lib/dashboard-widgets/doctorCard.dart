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

  static const String defaultImageUrl = 'assets/hospital.jpeg';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin:
            const EdgeInsets.all(8), // Add margin for the shadow to be visible
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
              color: Color(0xFFEBE7E7), width: 1), // Add grey border
        ),
        color: Colors.white, // Set the card background color to white
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/doctor1.png'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.length > 20
                              ? '${name.substring(0, 20)}...'
                              : name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        ),
                        Text(
                          specialization.length > 20
                              ? '${specialization.substring(0, 20)}...'
                              : specialization,
                          style: const TextStyle(
                            color: Color(0xFF7D8BB7),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      const SizedBox(width: 5),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement appointment functionality here
                        // For example, navigate to an appointment screen
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 40),
                        backgroundColor: const Color(0xFFEBE7E7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ), // Background color set to grey
                      ),
                      child: const Text(
                        'Appointment',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight:
                                FontWeight.w500 // Text color set to black
                            ),
                      ),
                    ),
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
