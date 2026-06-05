import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/custom_button.dart';

class DetailsScreen extends StatefulWidget {
  final ProductModel product;

  const DetailsScreen({super.key, required this.product});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late bool _isFavorite;
  String _selectedOption = '';
  int _selectedColorIndex = 0;

  // Option lists depending on product category
  final List<String> _shoeSizes = ['40', '41', '42', '43', '44'];
  final List<String> _storageSizes = ['64GB', '128GB', '256GB', '512GB'];
  final List<Color> _productColors = [
    const Color(0xFF0F172A), // Midnight Slate
    const Color(0xFFFF6B00), // Accent Orange
    const Color(0xFF64748B), // Space Grey
    const Color(0xFFE2E8F0), // Platinum
  ];

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.product.isFavorite;

    // Set initial custom options
    if (widget.product.category == 'Footwear') {
      _selectedOption = _shoeSizes[2]; // Default to size 42
    } else if (widget.product.category == 'Electronics') {
      _selectedOption = _storageSizes[1]; // Default to 128GB
    }
  }

  void _onFavoriteToggle() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite ? 'Added to Wishlist' : 'Removed from Wishlist',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: _isFavorite
            ? const Color(0xFF0F172A)
            : const Color(0xFF64748B),
      ),
    );
  }

  void _onAddToCart() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.greenAccent,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Added 1x ${widget.product.name} to cart!',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF0F172A),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Scrollable product detail contents
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image header
                  _buildImageHeader(),

                  // Product info sheet
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category + Stock Indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                widget.product.category.toUpperCase(),
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'In Stock',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Title
                        Text(
                          widget.product.name,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Rating & Reviews row
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.product.rating.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: Color(0xFF94A3B8),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.product.reviewCount} customer reviews',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Highlighted Price
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '\$${widget.product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '\$${(widget.product.price * 1.25).toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                '20% OFF',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Dividers & Options
                        const Divider(color: Color(0xFFF1F5F9), height: 1),
                        const SizedBox(height: 20),

                        // Custom Options Picker Section
                        if (widget.product.category == 'Footwear')
                          _buildOptionSelector(
                            'Select Shoe Size (US)',
                            _shoeSizes,
                          )
                        else if (widget.product.category == 'Electronics')
                          _buildOptionSelector(
                            'Select Storage Capacity',
                            _storageSizes,
                          ),

                        if (widget.product.category == 'Footwear' ||
                            widget.product.category == 'Electronics')
                          const SizedBox(height: 20),

                        // Color Options Picker
                        _buildColorSelector(),
                        const SizedBox(height: 24),

                        const Divider(color: Color(0xFFF1F5F9), height: 1),
                        const SizedBox(height: 20),

                        // Description
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.product.description,
                          style: const TextStyle(
                            color: Color(0xFF475569),
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Additional Specifications
                        _buildSpecificationTile(
                          'Free Shipping',
                          'Ships within 24 hours',
                        ),
                        _buildSpecificationTile(
                          'Secure Transaction',
                          'SSL encrypted checkout protection',
                        ),
                        _buildSpecificationTile(
                          'Return Policy',
                          '30-day money-back guarantee',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Custom floating Back and Favorite top header
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                    ),
                    color: const Color(0xFF0F172A),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                // Favorite Button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 20,
                    ),
                    color: _isFavorite
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF0F172A),
                    onPressed: _onFavoriteToggle,
                  ),
                ),
              ],
            ),
          ),

          // Sticky Bottom Buy bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildStickyBottomBar(theme),
          ),
        ],
      ),
    );
  }

  // Hero Product image banner
  Widget _buildImageHeader() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: 'hero-${widget.product.id}',
              child: Container(
                color: const Color(0xFFF8FAFC),
                child: Image.network(
                  widget.product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Gradient Bottom mask shadow for visual blending
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.transparent,
                    Colors.white.withValues(alpha: 0.15),
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.4, 0.85, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Horizontal Option Selector (Size / Storage)
  Widget _buildOptionSelector(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 42,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];
              final isSelected = _selectedOption == option;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedOption = option;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : const Color(0xFFE2E8F0),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      option,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF475569),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Horizontal Color Selector
  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Color',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(_productColors.length, (index) {
            final col = _productColors[index];
            final isSelected = _selectedColorIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColorIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(2),
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    width: 2.0,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: col,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: col == const Color(0xFFE2E8F0)
                              ? Colors.black
                              : Colors.white,
                        )
                      : null,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // Row Specs
  Widget _buildSpecificationTile(String leading, String title) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Icon(
            leading == 'Free Shipping'
                ? Icons.local_shipping_outlined
                : leading == 'Secure Transaction'
                ? Icons.security_rounded
                : Icons.autorenew_rounded,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Text(
            leading,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Color(0xFF0F172A),
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Sticky bottom action buttons
  Widget _buildStickyBottomBar(ThemeData theme) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        14,
        20,
        MediaQuery.of(context).padding.bottom + 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFF1F5F9), width: 1.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Add to Cart
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _onAddToCart,
              icon: Icon(
                Icons.add_shopping_cart_rounded,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              label: Text(
                'Add To Cart',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: theme.colorScheme.primary, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Buy Now
          Expanded(
            child: CustomButton(
              text: 'Buy Now',
              onPressed: () {
                // Trigger order placement flow
              },
              borderRadius: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
