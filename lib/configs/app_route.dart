import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  static const String home = '/home';
  static const String guestHome = '/guest';
  static const String guestFavorite = '/guest/favorite';
  static const String guestCart = '/guest/cart';
  static const String guestOrder = '/guest/order';
  static const String guestProductDetail = '/guest/productDetail';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String forgotPw = '/forgotPw';
  static const String search = '/search';
  static const String productDetail = '/productDetail';
  static const String favorite = '/favorite';
  static const String order = '/order';
  static const String pay = '/pay';
  static const String user = '/user';
  static const String address = '/user/address';
  static const String orderDetail = '/orderDetail';
  static const String cart = '/cart';
  static const String cartConfirm = '/cart/confirm';
  static const String credit = '/credit';
  static const String creditAdd = '/creditAdd';
  static const String creditEdit = '/creditEdit';
  static const String checkout = '/checkout';
  static const String productFeedback = '/product/feedback';
  static const String changePass = '/user/changePass';
  static const String coupon = '/order/coupon';

  static const List<String> mainRoutes = [
    AppRoute.home,
    AppRoute.favorite,
    AppRoute.order,
    AppRoute.user
  ];

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return AppRoute().withNavigationRoute(
          settings,
          AppRoute.home,
          MultiBlocProvider(
            providers: [
              BlocProvider<CategoryBloc>(
                create: (context) => AppBloc.categoryBloc,
              ),
              BlocProvider<ProductBloc>(
                create: (context) => AppBloc.productBloc,
              )
            ],
            child: HomeScreen(),
          ),
        );
      case guestHome:
        return AppRoute().guestWithNavigationRoute(
          settings,
          AppRoute.guestHome,
          MultiBlocProvider(
            providers: [
              BlocProvider<CategoryBloc>(
                create: (context) => AppBloc.categoryBloc,
              ),
              BlocProvider<ProductBloc>(
                create: (context) => AppBloc.productBloc,
              )
            ],
            child: HomeScreen(),
          ),
        );
      case guestCart:
        return AppRoute().guestCartLayoutRoute(
          settings,
          BlocProvider<CartCheckBloc>(
            create: (context) => AppBloc.cartCheckBloc,
            child: CartScreen(),
          ),
        );
      case guestOrder:
        return AppRoute().guestWithNavigationRoute(
          settings,
          AppRoute.guestOrder,
          GuestOrderScreen(),
        );
      case guestFavorite:
        return AppRoute().guestWithNavigationRoute(
          settings,
          AppRoute.guestFavorite,
          BlocProvider<FavoriteCheckBloc>(
            create: (context) => AppBloc.favoriteCheckBloc,
            child: FavoriteScreen(),
          ),
        );
      case guestProductDetail:
        Map params = settings.arguments as Map;
        return AppRoute().guestWithNavigationRoute(
          settings,
          AppRoute.guestProductDetail,
          BlocProvider<ProductDetailBloc>(
            create: (context) => AppBloc.productDetailBloc,
            child: ProductDetailScreen(productId: params['id']),
          ),
        );
      case favorite:
        return AppRoute().withNavigationRoute(
          settings,
          AppRoute.favorite,
          BlocProvider<FavoriteCheckBloc>(
            create: (context) => AppBloc.favoriteCheckBloc,
            child: FavoriteScreen(),
          ),
        );
      case order:
        return AppRoute().withNavigationRoute(
          settings,
          AppRoute.order,
          BlocProvider<OrderBloc>(
            create: (context) => AppBloc.orderBloc,
            child: OrderScreen(),
          ),
        );
      case orderDetail:
        Map params = settings.arguments as Map;
        return AppRoute().withoutNavigationRoute(
          settings,
          OrderDetailScreen(order: params['order']),
        );
      case user:
        return AppRoute().withNavigationRoute(
          settings,
          AppRoute.user,
          BlocProvider(
            create: (context) => AppBloc.profileBloc,
            child: UserScreen(),
          ),
        );
      case address:
        Map params = settings.arguments as Map;
        return AppRoute().withoutNavigationRoute(
          settings,
          MultiBlocProvider(
            providers: [
              BlocProvider<CheckoutBloc>(
                create: (context) => AppBloc.checkoutBloc,
              ),
              BlocProvider<ProfileBloc>(
                create: (context) => AppBloc.profileBloc,
              ),
            ],
            child: AddressScreen(address: params['address']),
          ),
        );
      case login:
        return AppRoute().loginLayoutRoute(
          settings,
          LoginScreen(),
        );
      case signUp:
        return AppRoute().loginLayoutRoute(
          settings,
          BlocProvider<UserBloc>(
            create: (context) => AppBloc.userBloc,
            child: SignupScreen(),
          ),
        );
      case forgotPw:
        return AppRoute().loginLayoutRoute(
          settings,
          BlocProvider<ForgotPasswordBloc>(
            create: (context) => AppBloc.forgotPasswordBloc,
            child: ForgotPwScreen(),
          ),
        );
      case search:
        return AppRoute().withoutNavigationRoute(
          settings,
          BlocProvider<SearchBloc>(
            create: (context) => AppBloc.searchBloc,
            child: SearchScreen(),
          ),
        );
      case cart:
        return AppRoute().cartLayoutRoute(
          settings,
          BlocProvider<CartCheckBloc>(
            create: (context) => AppBloc.cartCheckBloc,
            child: CartScreen(),
          ),
        );
      case cartConfirm:
        return AppRoute().cartLayoutRoute(
          settings,
          CartScreenConfirm(),
        );
      case pay:
        Map params = settings.arguments as Map;
        return AppRoute().webRoute(
          settings,
          PayScreen(link: params['link']),
        );
      case productDetail:
        Map params = settings.arguments as Map;
        if (AppBloc.authBloc.state is AuthSuccess) {
          return AppRoute().withNavigationRoute(
            settings,
            AppRoute.productDetail,
            BlocProvider<ProductDetailBloc>(
              create: (context) => AppBloc.productDetailBloc,
              child: ProductDetailScreen(productId: params['id']),
            ),
          );
        }
        return AppRoute().guestWithNavigationRoute(
          settings,
          AppRoute.guestProductDetail,
          BlocProvider<ProductDetailBloc>(
            create: (context) => AppBloc.productDetailBloc,
            child: ProductDetailScreen(productId: params['id']),
          ),
        );
      case credit:
        return AppRoute().cardLayoutRoute(
          settings,
          BlocProvider(
            create: (context) => AppBloc.creditCardBloc,
            child: CreditScreen(),
          ),
        );
      case creditAdd:
        return AppRoute().cardLayoutRoute(
          settings,
          BlocProvider(
            create: (context) => AppBloc.creditCardBloc,
            child: CreditAddScreen(),
          ),
        );
      case creditEdit:
        Map params = settings.arguments as Map;
        return AppRoute().cardLayoutRoute(
          settings,
          CreditEditScreen(creditCard: params['creditCard']),
        );
      case checkout:
        return AppRoute().withoutNavigationRoute(
          settings,
          MultiBlocProvider(
            providers: [
              BlocProvider<CheckoutBloc>(
                create: (context) => AppBloc.checkoutBloc,
              ),
              BlocProvider<ProfileBloc>(
                create: (context) => AppBloc.profileBloc,
              )
            ],
            child: CheckoutScreen(),
          ),
        );
      case productFeedback:
        Map params = settings.arguments as Map;
        return AppRoute().withoutNavigationRoute(
          settings,
          BlocProvider<FeedbackBloc>(
            create: (context) => AppBloc.feedbackBloc,
            child: ProductFeedbackScreen(productId: params['id']),
          ),
        );
      case changePass:
        return AppRoute().withoutNavigationRoute(
          settings,
          BlocProvider(
            create: (context) => AppBloc.userBloc,
            child: ChangePassScreen(),
          ),
        );
      case coupon:
        return AppRoute().withoutNavigationRoute(
          settings,
          BlocProvider(
            create: (context) => AppBloc.couponBloc,
            child: CouponScreen(),
          ),
        );
      default:
        return AppRoute().loginLayoutRoute(
          settings,
          Center(
            child: Text('Page Not Found'),
          ),
        );
    }
  }

  PageRouteBuilder withNavigationRoute(
    RouteSettings settings,
    String routeName,
    Widget screen,
  ) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return SuperScreen(
          child: LayoutWithNavigation(
            child: screen,
            animation: animation,
          ),
        );
      },
      settings: settings,
      fullscreenDialog: true,
    );
  }

  PageRouteBuilder guestWithNavigationRoute(
    RouteSettings settings,
    String routeName,
    Widget screen,
  ) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return SuperScreen(
          child: GuestWithNavigation(
            child: screen,
            animation: animation,
          ),
        );
      },
      settings: settings,
      fullscreenDialog: true,
    );
  }

  MaterialPageRoute withoutNavigationRoute(RouteSettings settings, Widget screen) {
    return MaterialPageRoute(
      builder: (context) {
        return SuperScreen(
          child: LayoutWithoutNavigation(
            child: screen,
          ),
        );
      },
      settings: settings,
      fullscreenDialog: true,
    );
  }

  MaterialPageRoute webRoute(RouteSettings settings, Widget screen) {
    return MaterialPageRoute(
      builder: (context) {
        return SuperScreen(child: screen);
      },
      settings: settings,
      fullscreenDialog: true,
    );
  }

  MaterialPageRoute loginLayoutRoute(RouteSettings settings, Widget screen) {
    return MaterialPageRoute(
      builder: (context) {
        return SuperScreen(
          child: LayoutLogin(
            child: screen,
          ),
        );
      },
      settings: settings,
      fullscreenDialog: true,
    );
  }

  MaterialPageRoute cardLayoutRoute(RouteSettings settings, Widget screen) {
    return MaterialPageRoute(
      builder: (context) {
        return SuperScreen(
          child: CardLayout(
            child: screen,
          ),
        );
      },
      settings: settings,
      fullscreenDialog: true,
    );
  }

  MaterialPageRoute cartLayoutRoute(RouteSettings settings, Widget screen) {
    return MaterialPageRoute(
      builder: (context) {
        return SuperScreen(
          child: LayoutCart(
            child: screen,
          ),
        );
      },
      settings: settings,
      fullscreenDialog: true,
    );
  }

  MaterialPageRoute guestCartLayoutRoute(RouteSettings settings, Widget screen) {
    return MaterialPageRoute(
      builder: (context) {
        return SuperScreen(
          child: GuestLayoutCart(
            child: screen,
          ),
        );
      },
      settings: settings,
      fullscreenDialog: true,
    );
  }

  static final AppRoute _instance = AppRoute._internal();

  factory AppRoute() {
    return _instance;
  }

  AppRoute._internal();
}
