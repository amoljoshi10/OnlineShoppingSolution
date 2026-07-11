workspace "OnlineShoppingApp" {
    model {
        customer = person "User"

        OnlineShopping = enterprise "Online Shopping" {
            shoppingSystemContext = softwareSystem "Shopping Platform" {
                singlePageApp = container "Single Page App"
                mobileApp = container "MobileApp"
                microservices = container "AKS Hosted Microservice" {
                    productService = component "Product Service"
                    cartService = component "Cart Service"
                    orderService = component "Order Service"
                }
                productsDB = container "Product DB"
                cartDB = container "Cart DB"
                orderDB = container "Order DB"
                serviceBus = container "Azure Service Bus"
            }
        }

        customer -> shoppingSystemContext
        customer -> singlePageApp
        customer -> mobileApp
        singlePageApp -> productService
        singlePageApp -> cartService
        singlePageApp -> orderService
        mobileApp -> productService
        mobileApp -> cartService
        mobileApp -> orderService
        productService -> productsDB
        cartService -> cartDB
        orderService -> cartDB
        orderService -> serviceBus
        serviceBus -> serviceBus
    }

    views {
        systemLandscape "SystemLandscape" {
            include *
            autoLayout
        }

        systemcontext shoppingSystemContext "SystemContext" {
            include *
            animation {
                shoppingSystemContext
            }
            autoLayout
        }

        container shoppingSystemContext "Container"  {
            include *
            animation {
                customer
                singlePageApp
                mobileApp
                microservices
                productsDB
                cartDB
                orderDB
                serviceBus
            }
            autoLayout
        }

        component microservices "Component"  {
            include *
            animation {
                singlePageApp
                mobileApp
                productService
                cartService
                orderService
                productsDB
                cartDB
                serviceBus

            }
            autoLayout
        }
       styles {
        relationship "Relationship" {
            color #000000
            dashed false
            fontSize 28
        }

        element "Software System" {
            background #0077be
            color #ffffff
            fontSize 28
        }

        element "Person" {
            background #00a651
            color #ffffff
            fontSize 28
        }

        element "Container" {
            background #f79646
            color #ffffff
            fontSize 28
        }

        element "Component" {
            background #ed1c24
            color #ffffff
            fontSize 28
        }

        element "Database" {
            background #808080
            color #ffffff
            fontSize 28
        }

        element "Queue" {
            background #808080
            color #ffffff
            fontSize 28
        }
    }
    }

    
}