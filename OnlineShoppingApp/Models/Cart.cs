using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace OnlineShoppingApp.Models
{
    [JsonArrayAttribute]
    public class Cart 
        //: ICollection<CartItemLine>
    {
        
        public IEnumerable<CartItemLine> Items { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }
        public string Country { get; set; }
        public string CardNumber { get; set; }
        public string CardExpiration { get; set; }

        /*public int Count { get;  }

        public bool IsReadOnly { get;  }

        public void Add(CartItemLine item)
        {
        }

        public void Clear()
        {
            
        }

        public bool Contains(CartItemLine item)
        {
            return false;
        }
        public void CopyTo(CartItemLine[] array, int arrayIndex)
        {
            
        }

        public IEnumerator<CartItemLine> GetEnumerator()
        {
            return Items.GetEnumerator();
        }

        public bool Remove(CartItemLine item)
        {
            return false;
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return Items.GetEnumerator();
        }*/
    }
}