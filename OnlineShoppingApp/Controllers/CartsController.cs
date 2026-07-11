using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Net.Http;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using OnlineShoppingApp.Models;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using OnlineShoppingApp.Services;

namespace OnlineShoppingApp.Controllers
{
    public class CartsController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly ILogger<CartsController> _logger;
        private readonly ICartService _cartService;
        private static Cart _cart =null; 
        public CartsController(ICartService cartService,
                               IConfiguration configuration,
                               ILogger<CartsController> logger)
        {
            _cartService = cartService;
            _configuration = configuration;
            _logger = logger;
        }


        public async Task<IActionResult> List()
        {
            IEnumerable<CartItemLine> cartLineItems = null;
            var cartViewModel = new ShoppingCartViewModel();
            var cart = new Cart();
            var orderItems = new List<CartItemLine>();

            try
            {

                cartLineItems = await _cartService.List();
                if(cartLineItems!=null) {
                    cartViewModel.Items = cartLineItems;

                    //foreach (var item in cartLineItems)
                    //{
                    //    var orderLineItem = new CartItemLine();
                    //    orderLineItem.ItemId = item.ItemId;
                    //    orderLineItem.Description = item.Description;
                    //    orderLineItem.Price = item.Price;
                    //    orderLineItem.Discount = item.Discount;
                    //    orderItems.Add(orderLineItem);
                    //}
                    cart.Items = cartLineItems;

                    /*TempData["Cart"] = JsonConvert.SerializeObject(order);*/

                    //TempData.Keep("CartsViewModel");
                    _cart = cart;
                    _logger.LogInformation("Carts {CartsCount} served from API", cartLineItems.Count());
                    var cachedDataString = JsonConvert.SerializeObject(cartLineItems);
                }
                

            }
            catch (Exception ex)
            {
                //_logger.LogError(ex, ex.Message, ex.Source);
                //throw;
            }
            return View(cartViewModel);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Consumes("application/x-www-form-urlencoded")]
        public async Task<IActionResult> ProceedToBuy(ShoppingCartViewModel shoppingCartViewModel)
        {
            return RedirectToAction("Buy", "Carts");
        }

        [HttpGet]
        public async Task<IActionResult> Buy()
        {
            return View();
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        [Consumes("application/x-www-form-urlencoded")]
        public async Task<IActionResult> Buy(ShoppingCartViewModel shoppingCartViewModel)
        {
            string orderLineItemsJson;
            //Cart cartModel = JsonConvert.DeserializeObject<Cart>(TempData["Cart"].ToString());
            Cart cartModel = _cart;
            cartModel.FirstName = shoppingCartViewModel.FirstName;
            cartModel.LastName = shoppingCartViewModel.LastName;
            cartModel.Email = shoppingCartViewModel.Email;
            cartModel.Address = shoppingCartViewModel.Address;
            cartModel.Country = shoppingCartViewModel.Country;
            cartModel.CardNumber = shoppingCartViewModel.CardNumber;
            cartModel.CardExpiration = shoppingCartViewModel.CardExpiration;
            
            try
            {
                orderLineItemsJson = JsonConvert.SerializeObject(cartModel);
                cartModel = await _cartService.PlaceOrder(cartModel);
                //cartModel = JsonConvert.DeserializeObject<List<CartItemLine>>(apiResponse);
            }
            catch (Exception ex)
            {
            }

            return RedirectToAction("BuyComplete", "Orders");
        }

    }
}