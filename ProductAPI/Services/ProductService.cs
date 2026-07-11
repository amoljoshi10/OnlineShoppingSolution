using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using DemoAPI.Interfaces;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;


namespace DemoAPI.Services
{
    public class ProductService : IProductService
    {

        public static List<Product> _products;
        private readonly IConfiguration _configuration;
        private IWebHostEnvironment _hostingEnvironment;
        public ProductService(IConfiguration configuration,IWebHostEnvironment env)
        {
            _configuration = configuration;
            _hostingEnvironment = env;
        }
        public Product GetProductById(int productID)
        {
            return GetProducts().FirstOrDefault(p => p.ProductID == productID);
        }
//write a metod to get product for a given category
        // public IEnumerable<Product> GetProductsByCategory(string category)
        // {
        //     return GetProducts().Where(p => p.ProductCategory == category);
        // }

        public IEnumerable<Product> GetProducts()
        {
            if(_products!=null)
            {
                return _products;
            }
            //_products =new List<Product>();
            //var productPrefix = _configuration.GetValue<string>("ProductPrefix");
            ////_logger.LogInformation("ProductAPI ProductService GetProducts productPrefix {productPrefix} ", productPrefix);
            //for (int i = 1; i <= 20; i++)
            //{
            //    _products.Add(new Product { ProductID = i, ProductCategory = "Cateory" + i, ProductDescription = productPrefix + i, Price =   i *100  } );
            //}

            //...................With Test Data.....................
            _products = new List<Product>();

            var folderDetails = Path.Combine(_hostingEnvironment.ContentRootPath, "TestData\\productstestdata.json");

            var jsonString = System.IO.File.ReadAllText(folderDetails);

            _products = Newtonsoft.Json.JsonConvert.DeserializeObject<List<Product>>(jsonString);

            return _products;
        }
        public void AddProduct(Product product)
        {
            _products.Add(product);
        }
        public void UpdateProduct(Product product,Product updatedProduct)
        {
            _products.Remove(product);
            _products.Add(updatedProduct);
        }
        public void DeletProduct(Product product)
        {
            _products.Remove(product);
        }

    }
}
