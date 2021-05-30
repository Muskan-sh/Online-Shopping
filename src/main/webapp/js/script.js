
function add_to_cart(id,name,price)
{
    let cart= localStorage.getItem("cart");
    if(cart==null)
    {
        // cart not present
        let products=[];
        let product={pId:id,pName:name,pQuantity:1,pPrice:price };
        products.push(product);
        localStorage.setItem("cart",JSON.stringify(products));
        console.log("Product added for the 1st time");

    }else{
        //  cart already exist
        let pcart=JSON.parse(cart);
        let oldProduct=pcart.find((item)=>item.pId== id)
        if(oldProduct)
        {
            // only increase quantity
            oldProduct.pQuantity+=1;
            pcart.map((item)=>{
                if(item.pId==oldProduct.pId){
                    item.pQuantity=oldProduct.pQuantity;
                }
            })
            localStorage.setItem("cart",JSON.stringify(pcart));
            console.log("Product quantity increased");

        }
        else
        {
            // add the product
            let product={pId:id,pName:name,pQuantity:1,pPrice:price };
            pcart.push(product);
            localStorage.setItem("cart",JSON.stringify(pcart));
            console.log("Product added");

        }

    }
}

