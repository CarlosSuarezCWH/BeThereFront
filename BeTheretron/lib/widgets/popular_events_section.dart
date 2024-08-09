import 'package:flutter/material.dart';
import 'package:betherapp/models/event_model.dart';
import 'package:betherapp/models/category_model.dart';

class PopularEventsSection extends StatelessWidget {
  final List<Category> categories;
  final Function(Event) onEventTap;

  const PopularEventsSection({
    Key? key,
    required this.categories,
    required this.onEventTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: categories.map((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 200, // Ajusta la altura de cada fila
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Desplazamiento horizontal
                  itemCount: category.events.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => onEventTap(category.events[index]),
                      child: _buildEventItem(category.events[index]),
                    );
                  },
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEventItem(Event event) {
    return Container(
      width: 180, // Ajusta el ancho de cada evento
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              event.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              loadingBuilder: (context, child, progress) {
                return progress == null
                    ? child
                    : const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.white,
                    size: 50,
                  ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              event.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
