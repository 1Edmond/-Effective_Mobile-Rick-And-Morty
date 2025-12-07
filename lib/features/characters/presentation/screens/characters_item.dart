import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/shared/services/di_service.dart';

class CharactersItem extends StatefulWidget {
  const CharactersItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.characterId,
    required this.tag,
    required this.type,
    this.isAnimationEnable = false,
    this.page = "list"
  });

  final String title;
  final String type;
  final String imageUrl;
  final String tag;
  final String page;
  final bool isAnimationEnable;
  final int characterId;

  @override
  State<CharactersItem> createState() => _CharactersItemState();
}

class _CharactersItemState extends State<CharactersItem> {
  late ConfettiController _controllerCenterLeft;

  @override
  void initState() {
    super.initState();
    _controllerCenterLeft = ConfettiController(
        duration: const Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    _controllerCenterLeft.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final characterController = DIService.getDependency(tag: widget.page);

    return RepaintBoundary(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
                leading: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SizedBox(
                      width: 60,
                      height: 60,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/icon.png"),
                    ),
                  ),
                ),
                title: Text(
                  widget.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: widget.type.isNotEmpty
                    ? Text(
                  '${widget.tag} • ${widget.type}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
                    : Text(
                  widget.tag,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Obx(() {
                  final isFav = characterController.isFavorite(widget.characterId);
                  return IconButton(
                    icon: Icon(
                      isFav ? Icons.star : Icons.star_border,
                      color: isFav ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      characterController.toggleFavorite(widget.characterId);
                      if (widget.isAnimationEnable &&
                          characterController.isFavorite(widget.characterId)) {
                        _controllerCenterLeft.play();
                      }
                    },
                  );
                })
            ),
          ),
          if (widget.isAnimationEnable)
            Positioned.fill(
              child: IgnorePointer(
                child: Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                    confettiController: _controllerCenterLeft,
                    blastDirectionality: BlastDirectionality.explosive,
                    shouldLoop: false,
                    numberOfParticles: 20,
                    maxBlastForce: 10,
                    minBlastForce: 5,
                    emissionFrequency: 0.05,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}