using Newtonsoft.Json;
using OnlineShoppingApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace OnlineShoppingApp.Services
{
    public class CartService:ICartService
    {
        private readonly HttpClient client;

        public CartService(HttpClient client)
        {
            this.client = client;
            //this.client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", "5db4e7423b5f45238df44d2ac524baf7");
        }
        public async Task<IEnumerable<CartItemLine>> List()
        {
            List<CartItemLine> cartLineItems = null;
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync("http://localhost:32772/carts"))
                {
                    string apiResponse = await response.Content.ReadAsStringAsync();
                    cartLineItems = JsonConvert.DeserializeObject<List<CartItemLine>>(apiResponse);
                    
                }
            }

            //using (var response = await this.client.GetAsync("/carts"))
            //{
            //    string apiResponse = await response.Content.ReadAsStringAsync();
            //    cart = JsonConvert.DeserializeObject<Cart>(apiResponse);
            //}
            return cartLineItems;
        }
        public async Task<CartItemLine> AddToCart(CartItemLine cartItemLine)
        {
            CartItemLine cart = null;
            string cartJson = JsonConvert.SerializeObject(cartItemLine);
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.PostAsync("http://localhost:32772/carts", new StringContent(cartJson, Encoding.UTF8, "application/json")))
                {
                    string apiResponse = await response.Content.ReadAsStringAsync();
                    cart = JsonConvert.DeserializeObject<CartItemLine>(apiResponse);
                }
            }
            //using (var response = await this.client.PostAsync("/carts", new StringContent(cartJson, Encoding.UTF8, "application/json")))
            //{
            //    string apiResponse = await response.Content.ReadAsStringAsync();
            //    cart = JsonConvert.DeserializeObject<CartItemLine>(apiResponse);
            //}
            return cart;
        }

        public async Task<Cart> PlaceOrder(Cart cartModel)
        {
            Cart cart = null;
            string cartCheckoutJson = JsonConvert.SerializeObject(cartModel);

            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.PostAsync("http://localhost:32772/carts/checkout", new StringContent(cartCheckoutJson, Encoding.UTF8, "application/json")))
                {
                    string apiResponse = await response.Content.ReadAsStringAsync();
                    cart = JsonConvert.DeserializeObject<Cart>(apiResponse);
                }
            }

            //using (var response = await this.client.PostAsync("carts/checkout", new StringContent(cartCheckoutJson, Encoding.UTF8, "application/json")))
            //{
            //    string apiResponse = await response.Content.ReadAsStringAsync();
            //    cart = JsonConvert.DeserializeObject<Cart>(apiResponse);
            //}
            return cart;
        }
    }
}