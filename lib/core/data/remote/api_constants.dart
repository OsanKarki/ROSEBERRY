
class ApiConstants {
  static const featuredCategory =
      "/rest/V1/homepage/sliders?filter=qmb-slider-banners";
  static const login = "/rest/V1/customer/login";
  static const register = "/rest/V1/customer/register";
  static const addToCart = "/rest/V1/cart/add";
  static const getCartItem = "/rest/V1/cart";
  static const deleteCartItem = "/rest/V1/cart/remove";
  static const deleteAllCartItem = '/rest/V1/cart/delete';
  static const updateCartItem = '/rest/V1/cart/update';
  static const getCategories = "/rest/V1/categories";
  static const multipleImageBanner =
      "/rest/V1/homepage/sliders?filter=qmb-col-banners";
  static const getImageSlider = "/rest/V1/homepage/sliders?filter=qmb-sliders";
  static const getSingleBannerImage =
      "/rest/V1/homepage/sliders?filter=qmb-single-banner";
  static const products = "/rest/V1/custom/products";
  static const getProductDetails = "/rest/V1/product";
  static const getUserInfo = "/rest/V1/customer/me";
  static const updateUserInfo = "/rest/V1/customer/update";
  static const setShippingInfo = "/rest/V1/checkout/shipping";
  static const getPaymentMethod = "/rest/V1/checkout/payment-method";
  static const setPaymentMethod = "/rest/V1/checkout/payment-method";
  static const getOrderSummary = "/rest/V1/checkout/order-summary";
  static const placeOrder = "/rest/V1/checkout/place-order";
  static const initiateTransaction  = "/transaction/initialize";
  static const getPlacedOrdersInfo  = "/rest/V1/customer/order";
}
