import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../HomeScreen.dart';

class ScanCard extends StatefulWidget {
  final ScanOption scan;
  final double screenWidth;
  final String latLang;
  final String? categoryId;

  const ScanCard({
    required this.scan,
    required this.screenWidth,
    required this.latLang,
    this.categoryId,
  });

  @override
  _ScanCardState createState() => _ScanCardState();
}

class _ScanCardState extends State<ScanCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.scan.name,
      button: true,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: () {
          if (widget.scan.categoryId != null) {
            context.push(
              '/all_tests?catId=${widget.scan.categoryId}&lat_lang=${widget.latLang}&catName=${widget.scan.name}',
            );
          } else {
            context.push(
              '/categories?query=${widget.scan.query}&latlngs=${widget.latLang}',
            );
          }
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: widget.screenWidth * 0.42,
            height: widget.screenWidth * 0.33,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xff2D3894), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              gradient: const LinearGradient(
                colors: [Color(0xffF5F7FA), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    widget.scan.imagePath,
                    fit: BoxFit.cover,
                    height: widget.screenWidth * 0.2,
                    width: widget.screenWidth * 0.2,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.broken_image,
                      size: widget.screenWidth * 0.2,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.scan.name,
                  style: const TextStyle(
                    color: Color(0xff000000),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
