import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/blocs/order/coupon_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc {
  static final AuthBloc authBloc = AuthBloc();
  static final UserBloc userBloc = UserBloc();
  static final CategoryBloc categoryBloc = CategoryBloc();
  static final ProductBloc productBloc = ProductBloc();
  static final FavoriteBloc favoriteBloc = FavoriteBloc();
  static final CartBloc cartBloc = CartBloc();
  static final ViewBloc viewBloc = ViewBloc();
  static final SearchBloc searchBloc = SearchBloc();
  static final FavoriteCheckBloc favoriteCheckBloc = FavoriteCheckBloc();
  static final CartCheckBloc cartCheckBloc = CartCheckBloc();
  static final ProductDetailBloc productDetailBloc = ProductDetailBloc();
  static final ProfileBloc profileBloc = ProfileBloc();
  static final FeedbackBloc feedbackBloc = FeedbackBloc();
  static final LanguageBloc languageBloc = LanguageBloc();
  static final UserAddressBloc userAddressBloc = UserAddressBloc();
  static final CheckoutBloc checkoutBloc = CheckoutBloc();
  static final OrderBloc orderBloc = OrderBloc();
  static final CreditCardBloc creditCardBloc = CreditCardBloc();
  static final ForgotPasswordBloc forgotPasswordBloc = ForgotPasswordBloc();
  static final CouponBloc couponBloc = CouponBloc();
  static final ShippingBloc shippingBloc = ShippingBloc();

  static final List<BlocProvider> providers = [
    BlocProvider<LanguageBloc>(
      create: (context) => languageBloc,
    ),
    BlocProvider<AuthBloc>(
      create: (context) => authBloc,
    ),
    BlocProvider<FavoriteBloc>(
      create: (context) => favoriteBloc,
    ),
    BlocProvider<CartBloc>(
      create: (context) => cartBloc,
    ),
    BlocProvider<ViewBloc>(
      create: (context) => viewBloc,
    ),
  ];

  static void dispose() {
    authBloc.close();
    userBloc.close();
    categoryBloc.close();
    productBloc.close();
    favoriteBloc.close();
    cartBloc.close();
    viewBloc.close();
    searchBloc.close();
    favoriteBloc.close();
    cartCheckBloc.close();
    productDetailBloc.close();
    profileBloc.close();
    feedbackBloc.close();
    languageBloc.close();
    userAddressBloc.close();
    checkoutBloc.close();
    orderBloc.close();
    creditCardBloc.close();
    forgotPasswordBloc.close();
    couponBloc.close();
    shippingBloc.close();
  }

  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
