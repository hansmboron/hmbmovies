import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 124,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withAlpha(15),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  'https://www.startpage.com/av/proxy-image?piurl=https%3A%2F%2Fi.pinimg.com%2Foriginals%2Fbe%2Fde%2Ff5%2Fbedef590b9bc6e4680fe8685c3b5418e.jpg&sp=1633734611Tb2efd0c4ed3a421d135ad361b9dc409df71a99e995c2e644713b0762f9b254e6',
                  height: 184,
                  width: 124,
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(),
              Text(
                'Coringa çskdgnsdçg lsdf lsdf psdf osfosdf osf  fsjo fsdfsdf  f',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '2019',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 2)
            ],
          ),
          Positioned(
            bottom: 38,
            right: -6,
            child: Material(
              color: Colors.white.withAlpha(240),
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              shape: CircleBorder(),
              child: SizedBox(
                height: 30,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
