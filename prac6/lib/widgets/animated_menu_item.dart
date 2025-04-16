import 'package:flutter/material.dart';

class AnimatedMenuItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const AnimatedMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<AnimatedMenuItem> createState() => _AnimatedMenuItemState();
}

class _AnimatedMenuItemState extends State<AnimatedMenuItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) => _controller.reverse());
        widget.onTap();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(
            horizontal: widget.isSelected ? 20 : 15,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: widget.isSelected ? widget.color.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.isSelected ? widget.color : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.icon,
                  color: widget.isSelected ? Colors.white : Colors.grey,
                  size: 20,
                ),
              ),
              
              // Title (only show if selected)
              if (widget.isSelected) ...[
                const SizedBox(width: 8),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

