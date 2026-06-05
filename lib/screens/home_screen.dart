import 'dart:async';
import 'package:flutter/material.dart';

import '../data/dummy_products.dart';
import '../models/product_model.dart';
import '../widgets/category_chip.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Products and filtered list
  late List<ProductModel> _allProducts;
  List<ProductModel> _filteredProducts = [];

  // State filters
  String _selectedCategory = 'All';
  String _searchQuery = '';
  int _cartCount = 0;
  bool _isLoading = false;
  bool _isGridView = true;

  // Search controller and debounce timer
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  // Available categories with icons
  final List<Map<String, dynamic>> _categories = [
    {'name': 'All', 'icon': Icons.grid_view_rounded},
    {'name': 'Electronics', 'icon': Icons.devices_other_rounded},
    {'name': 'Footwear', 'icon': Icons.brush_rounded}, // represents shoes/style
    {'name': 'Accessories', 'icon': Icons.watch_rounded},
    {'name': 'Fashion', 'icon': Icons.checkroom_rounded},
    {'name': 'Home', 'icon': Icons.home_max_rounded},
  ];

  // Active Promo Banner Index for the carousel
  int _currentPromoIndex = 0;
  late final PageController _promoPageController;
  late final Timer _promoTimer;

  final List<Map<String, String>> _promos = [
    {
      'title': 'Summer Super Sale',
      'subtitle': 'Up to 50% Off on Premium Gadgets',
      'code': 'SUMMER50',
      'image':
          'https://images.unsplash.com/photo-1540959733332-eab4deceeaf7?q=80&w=800&auto=format&fit=crop',
    },
    {
      'title': 'Trendy Footwear',
      'subtitle': 'Step up your style with outdoor gear',
      'code': 'STEPUP20',
      'image':
          'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?q=80&w=800&auto=format&fit=crop',
    },
    {
      'title': 'Smart Home Comforts',
      'subtitle': 'Modernize your living space today',
      'code': 'SMARTHOME',
      'image':
          'https://images.unsplash.com/photo-1558002038-1055907df827?q=80&w=800&auto=format&fit=crop',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize products from dummy list
    _allProducts = List.from(dummyProducts);
    _filteredProducts = List.from(_allProducts);

    _promoPageController = PageController(initialPage: 0);

    // Auto scroll promotion banners every 4 seconds
    _promoTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_promoPageController.hasClients) {
        setState(() {
          _currentPromoIndex = (_currentPromoIndex + 1) % _promos.length;
        });
        _promoPageController.animateToPage(
          _currentPromoIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    _promoTimer.cancel();
    _promoPageController.dispose();
    super.dispose();
  }

  // Filter application method
  void _applyFilters() {
    List<ProductModel> temp = List.from(_allProducts);

    // Filter by Category
    if (_selectedCategory != 'All') {
      temp = temp
          .where(
            (p) => p.category.toLowerCase() == _selectedCategory.toLowerCase(),
          )
          .toList();
    }

    // Filter by Search Query
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      temp = temp
          .where(
            (p) =>
                p.name.toLowerCase().contains(query) ||
                p.description.toLowerCase().contains(query) ||
                p.category.toLowerCase().contains(query),
          )
          .toList();
    }

    _filteredProducts = temp;
  }

  // Handle category selected
  void _onCategorySelected(String category) {
    if (_selectedCategory == category) return;
    setState(() {
      _selectedCategory = category;
      _isLoading = true;
    });

    // Simulate network latency
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _applyFilters();
          _isLoading = false;
        });
      }
    });
  }

  // Handle search text changed (with 300ms debounce)
  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _searchQuery = query;
          _isLoading = true;
        });

        // Simulate network latency for search
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) {
            setState(() {
              _applyFilters();
              _isLoading = false;
            });
          }
        });
      }
    });
  }

  // Handle favorite toggled
  void _onFavoriteToggle(int index) {
    setState(() {
      final product = _filteredProducts[index];
      // Update in local filtered list
      final updatedProduct = product.copyWith(isFavorite: !product.isFavorite);
      _filteredProducts[index] = updatedProduct;

      // Update in master list
      final masterIndex = _allProducts.indexWhere((p) => p.id == product.id);
      if (masterIndex != -1) {
        _allProducts[masterIndex] = updatedProduct;
      }
    });

    final isFav = _filteredProducts[index].isFavorite;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFav ? 'Added to Wishlist' : 'Removed from Wishlist',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isFav
            ? const Color(0xFF0F172A)
            : const Color(0xFF64748B),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Theme.of(context).colorScheme.primary,
          onPressed: () => _onFavoriteToggle(index),
        ),
      ),
    );
  }

  // Handle add to cart
  void _onAddToCart(ProductModel product) {
    setState(() {
      _cartCount++;
    });

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
                '${product.name} added to cart!',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF0F172A),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            // Placeholder for Cart screen navigation
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, size: 26),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_bag_rounded,
              color: theme.colorScheme.primary,
              size: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              'Siddiq SHOP',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                letterSpacing: 1.2,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        actions: [
          // Dynamic Shopping Cart Badge
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, size: 26),
                onPressed: () {
                  // Action for cart
                },
              ),
              if (_cartCount > 0)
                Positioned(
                  right: 4,
                  top: 4,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 200),
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Center(
                            child: Text(
                              '$_cartCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: const Drawer(child: Center(child: Text('Menu Options Drawer'))),
      body: SafeArea(
        child: Column(
          children: [
            // Search header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: ProductSearchBar(
                controller: _searchController,
                onChanged: _onSearchChanged,
                onFilterPressed: () {
                  // Filter bottom sheet triggers
                  _showFilterBottomSheet();
                },
              ),
            ),

            // Main Scrollable Area
            Expanded(
              child: RefreshIndicator(
                color: theme.colorScheme.primary,
                onRefresh: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await Future<void>.delayed(const Duration(milliseconds: 600));
                  if (mounted) {
                    setState(() {
                      _allProducts = List.from(dummyProducts);
                      _applyFilters();
                      _isLoading = false;
                    });
                  }
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  slivers: [
                    // Promo Banners Section (only show if not active search or category filtered for clean UX)
                    if (_selectedCategory == 'All' && _searchQuery.isEmpty)
                      SliverToBoxAdapter(child: _buildPromoCarousel()),

                    // Categories Horizontal Slider
                    SliverToBoxAdapter(child: _buildCategoriesSection()),

                    // Grid/List header title and toggles
                    SliverToBoxAdapter(child: _buildSectionHeader()),

                    // Products List/Grid layout with skeleton/loader state
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: _isLoading
                          ? _buildSkeletonGrid(size)
                          : _filteredProducts.isEmpty
                          ? SliverToBoxAdapter(child: _buildEmptyState())
                          : _isGridView
                          ? _buildProductGrid(size)
                          : _buildProductList(),
                    ),

                    // Bottom padding spacer
                    const SliverToBoxAdapter(child: SizedBox(height: 30)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Builds the Horizontal Promo Carousel Slider
  Widget _buildPromoCarousel() {
    final theme = Theme.of(context);

    return Container(
      height: 180,
      margin: const EdgeInsets.only(top: 8, bottom: 20),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _promoPageController,
            onPageChanged: (index) {
              setState(() {
                _currentPromoIndex = index;
              });
            },
            itemCount: _promos.length,
            itemBuilder: (context, index) {
              final promo = _promos[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0F172A).withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Stack(
                    children: [
                      // Background Image
                      Positioned.fill(
                        child: Image.network(
                          promo['image']!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF0F172A),
                                    Color(0xFFFF6B00),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Colors.white,
                                  size: 80,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Dark Overlay for text legibility
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withValues(alpha: 0.7),
                                Colors.black.withValues(alpha: 0.1),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                      // Promotional Texts
                      Positioned(
                        left: 24,
                        top: 24,
                        bottom: 24,
                        right: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'CODE: ${promo['code']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              promo['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              promo['subtitle']!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // Carousel Indicators
          Positioned(
            bottom: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _promos.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPromoIndex == index ? 20 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _currentPromoIndex == index
                        ? theme.colorScheme.primary
                        : Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Category Selector Slider Row
  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 54,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final cat = _categories[index];
              final isSelected = _selectedCategory == cat['name'];
              return CategoryChip(
                label: cat['name'] as String,
                icon: cat['icon'] as IconData,
                isSelected: isSelected,
                onTap: () => _onCategorySelected(cat['name'] as String),
              );
            },
          ),
        ),
      ],
    );
  }

  // Section Header (Products count + Toggle Grid/List layout)
  Widget _buildSectionHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Explore Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${_filteredProducts.length} items found',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          // Toggle grid/list icons
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isGridView = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _isGridView ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: _isGridView
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      Icons.grid_view_rounded,
                      size: 18,
                      color: _isGridView
                          ? Theme.of(context).colorScheme.primary
                          : const Color(0xFF64748B),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isGridView = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: !_isGridView ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: !_isGridView
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      Icons.view_list_rounded,
                      size: 18,
                      color: !_isGridView
                          ? Theme.of(context).colorScheme.primary
                          : const Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Grid Responsive Product Listing
  Widget _buildProductGrid(Size size) {
    // Columns responsive logic
    int crossAxisCount = 2;
    if (size.width >= 1200) {
      crossAxisCount = 5;
    } else if (size.width >= 850) {
      crossAxisCount = 4;
    } else if (size.width >= 600) {
      crossAxisCount = 3;
    }

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
        childAspectRatio:
            0.58, // optimized to prevent overflow of name/price/ratings
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final product = _filteredProducts[index];
        return ProductCard(
          product: product,
          onTap: () => _navigateToDetails(product),
          onAddToCart: () => _onAddToCart(product),
          onFavoriteToggle: () => _onFavoriteToggle(index),
        );
      }, childCount: _filteredProducts.length),
    );
  }

  // List Layout Product Listing
  Widget _buildProductList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final product = _filteredProducts[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: _HorizontalProductListTile(
            product: product,
            onTap: () => _navigateToDetails(product),
            onAddToCart: () => _onAddToCart(product),
            onFavoriteToggle: () => _onFavoriteToggle(index),
          ),
        );
      }, childCount: _filteredProducts.length),
    );
  }

  // Simulated Shimmer Grid Loader
  Widget _buildSkeletonGrid(Size size) {
    int crossAxisCount = 2;
    if (size.width >= 1200) {
      crossAxisCount = 5;
    } else if (size.width >= 850) {
      crossAxisCount = 4;
    } else if (size.width >= 600) {
      crossAxisCount = 3;
    }

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
        childAspectRatio: 0.58,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => const _SkeletonCard(),
        childCount: 4,
      ),
    );
  }

  // Navigate to product details
  void _navigateToDetails(ProductModel product) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DetailsScreen(product: product),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.15, 0.0),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }

  // Filter Sheet Trigger
  void _showFilterBottomSheet() {
    final theme = Theme.of(context);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Filter Options',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Sort By',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: [
                  ChoiceChip(
                    label: const Text('Popularity'),
                    selected: true,
                    onSelected: (val) {},
                  ),
                  ChoiceChip(
                    label: const Text('Price: Low to High'),
                    selected: false,
                    onSelected: (val) {},
                  ),
                  ChoiceChip(
                    label: const Text('Price: High to Low'),
                    selected: false,
                    onSelected: (val) {},
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Search Empty State Widget
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7ED), // Subtle orange bg
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 48,
                color: Color(0xFFFF6B00),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'No Products Found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "We couldn't find matches for your selection. Try typing something else or changing categories.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Horizontal layout tile for List view option
class _HorizontalProductListTile extends StatefulWidget {
  final ProductModel product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;
  final VoidCallback onFavoriteToggle;

  const _HorizontalProductListTile({
    required this.product,
    required this.onTap,
    required this.onAddToCart,
    required this.onFavoriteToggle,
  });

  @override
  State<_HorizontalProductListTile> createState() =>
      _HorizontalProductListTileState();
}

class _HorizontalProductListTileState
    extends State<_HorizontalProductListTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? theme.colorScheme.primary.withValues(alpha: 0.25)
                : const Color(0xFFF1F5F9),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(
                0xFF0F172A,
              ).withValues(alpha: _isHovered ? 0.08 : 0.03),
              blurRadius: _isHovered ? 16 : 8,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // Product image left
                    Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: const Color(0xFFF8FAFC),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.network(
                              widget.product.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.broken_image_rounded,
                                  color: Color(0xFF94A3B8),
                                );
                              },
                            ),
                          ),
                        ),
                        // Favorite dot overlay
                        Positioned(
                          top: 4,
                          right: 4,
                          child: InkWell(
                            onTap: widget.onFavoriteToggle,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                widget.product.isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: widget.product.isFavorite
                                    ? Colors.red
                                    : Colors.grey,
                                size: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    // Details middle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  widget.product.category,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF475569),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 14,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                widget.product.rating.toString(),
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF64748B),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Right price & Add to Cart button
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${widget.product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: widget.onAddToCart,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            minimumSize: Size.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart_rounded,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Shimmer Loader Card Component
class _SkeletonCard extends StatefulWidget {
  const _SkeletonCard();

  @override
  State<_SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<_SkeletonCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _opacityAnim = Tween<double>(
      begin: 0.4,
      end: 0.85,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnim,
      builder: (context, child) {
        return Opacity(opacity: _opacityAnim.value, child: child);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image grey box skeleton
            AspectRatio(
              aspectRatio: 1.1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(22.5),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rating block skeleton
                    Container(
                      width: 50,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Name block skeleton line 1
                    Container(
                      width: double.infinity,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Name block skeleton line 2
                    Container(
                      width: 80,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const Spacer(),
                    // Price & button skeleton row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60,
                          height: 18,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
