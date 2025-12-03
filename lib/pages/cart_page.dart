import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/order_history.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(),
            Container(
              padding: const EdgeInsets.all(16),
              child: const CartContent(),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class CartContent extends StatelessWidget {
  const CartContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    if (cart.items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 24),
            const Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Add some items to your cart to continue shopping',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text(
                'CONTINUE SHOPPING',
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Text(
          'Your Shopping Cart',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${cart.itemCount} item${cart.itemCount == 1 ? '' : 's'} in your cart',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 32),
        isMobile
            ? _buildMobileCartItems(cart, context)
            : _buildDesktopCartItems(cart, context),
        const SizedBox(height: 32),
        _buildCartSummary(cart, context),
      ],
    );
  }

  Widget _buildMobileCartItems(Cart cart, BuildContext context) {
    return Column(
      children: cart.items
          .map((item) => _buildMobileCartItem(item, context))
          .toList(),
    );
  }

  Widget _buildMobileCartItem(CartItem item, BuildContext context) {
    // Debug: Print the image URL to console
    debugPrint('Cart Item Image URL: ${item.imageUrl}');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  item.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (item.size != null || item.color != null)
                      Text(
                        '${item.size ?? ''}${item.size != null && item.color != null ? ' • ' : ''}${item.color ?? ''}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      '£${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4d2963),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuantityControls(item, context),
              IconButton(
                onPressed: () {
                  Provider.of<Cart>(context, listen: false).removeItem(
                    item.productId,
                    size: item.size,
                    color: item.color,
                  );
                },
                icon: const Icon(Icons.delete_outline),
                color: Colors.grey[600],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopCartItems(Cart cart, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header row
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'PRODUCT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'PRICE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'QUANTITY',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'TOTAL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 48), // Space for delete button
              ],
            ),
          ),
          // Cart items
          ...cart.items.map((item) => _buildDesktopCartItem(item, context)),
        ],
      ),
    );
  }

  Widget _buildDesktopCartItem(CartItem item, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    item.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      if (item.size != null || item.color != null)
                        Text(
                          '${item.size ?? ''}${item.size != null && item.color != null ? ' • ' : ''}${item.color ?? ''}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              '£${item.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Center(
              child: _buildQuantityControls(item, context),
            ),
          ),
          Expanded(
            child: Text(
              '£${item.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4d2963),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () {
              Provider.of<Cart>(context, listen: false).removeItem(
                item.productId,
                size: item.size,
                color: item.color,
              );
            },
            icon: const Icon(Icons.delete_outline),
            color: Colors.grey[600],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControls(CartItem item, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 16),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
            onPressed: () {
              Provider.of<Cart>(context, listen: false).decrementQuantity(
                item.productId,
                size: item.size,
                color: item.color,
              );
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              item.quantity.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 16),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
            onPressed: () {
              Provider.of<Cart>(context, listen: false).incrementQuantity(
                item.productId,
                size: item.size,
                color: item.color,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCartSummary(Cart cart, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                '£${cart.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shipping',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Calculated at checkout',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                '£${cart.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4d2963),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final cartProvider = Provider.of<Cart>(context, listen: false);
                final orderHistory =
                    Provider.of<OrderHistory>(context, listen: false);

                orderHistory.addOrder(cartProvider);
                cartProvider.clear();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order placed successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );

                context.go('/order-history');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'PROCEED TO CHECKOUT',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => context.go('/'),
              child: const Text(
                'Continue Shopping',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4d2963),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
