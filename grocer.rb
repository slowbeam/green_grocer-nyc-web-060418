require "pry"
def consolidate_cart(cart)
  new_cart = {}
  cart.each do |x|
    x.each do |food, info|
      info[:count] = cart.count(x)
    end
    new_cart.merge!(x)
    end
new_cart
  end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.has_key?(coupon[:item]) && cart[coupon[:item]][:count] >= coupon[:num]
      item_withcoupon = coupon[:item] + " W/COUPON"
    if cart.has_key?(item_withcoupon)
      cart[item_withcoupon][:count] += 1
    else
      cart[item_withcoupon] = {price: coupon[:cost], clearance: cart[coupon[:item]][:clearance], count: 1}
    end
    cart[coupon[:item]][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance] == true
      info[:price] = info[:price] - (info[:price] * 0.2)
    end
  end
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each do |item, info|
    total += info[:price] * info[:count]
  end
  if total >= 100
    total = total * 0.9
  end
  total
end
