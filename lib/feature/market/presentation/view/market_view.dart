import 'dart:async';

import 'package:agri_guide_app/feature/market/presentation/manger/cubit/product_cubit.dart';
import 'package:agri_guide_app/feature/market/presentation/widgets/product_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketView extends StatefulWidget {
  const MarketView({super.key});

  @override
  State<MarketView> createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getProducts();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      context.read<ProductCubit>().searchProducts(value);
    });

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // Header container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 52, 16, 20),
            decoration: BoxDecoration(
              color: cs.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Stack(
              children: [
                // Decoration circle
                Positioned(
                  top: -20,
                  right: -20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.07),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button + title
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Directionality.of(context) ==
                                      TextDirection.RTL
                                  ? Icons.arrow_forward_ios_rounded
                                  : Icons.arrow_back_ios_new_rounded,
                              color: cs.onPrimary,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          'agriMarket'.tr(),
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: cs.onPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Search bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _controller,
                        onChanged: _onSearchChanged,
                        style: theme.textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: 'searchProducts'.tr(),
                          hintStyle: TextStyle(
                            color: cs.onSurfaceVariant,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: cs.primary,
                          ),
                          suffixIcon: _controller.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: cs.onSurfaceVariant,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    _controller.clear();

                                    context
                                        .read<ProductCubit>()
                                        .searchProducts('');

                                    setState(() {});
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: cs.primary,
                      ),
                    );
                  }

                  if (state is ProductFailure) {
                    return Center(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: cs.error.withOpacity(0.6),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            state.errmessage,
                            style: TextStyle(color: cs.error),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is ProductSuccess) {
                    final products = state.products;

                    if (products.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 56,
                              color: cs.onSurfaceVariant
                                  .withOpacity(0.4),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'noProductsFound'.tr(),
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: products[index],
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}