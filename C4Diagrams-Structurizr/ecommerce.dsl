# write a c4 model diagram using structurizr DSL  with workspace "OnlineShoppingApp" and  within workspace add model  and view . Then within model add customer variable of type Person  named "User" and enterprise shopping named "Online Shopping" . And within enterprise shopping  add  softwaresystem variable shoppingSystemContext with value  "Shopping Platform" . And then within softwaresystem add variable singlePageApplication as container named  "Single Page App" and  add variable mobileApp as container named  "MobileApp" and add variable microservices as container named "AKS Hosted Microservice" . And then within  microservices add productService as component named "Product Service" , add componenet as productService  named "Product Service" , add componenet as cartService  named "Cart Service" ,add componenet as orderService  named "Order Service" Andd views for shoppingSystemContext and in views add animation for component microservices
workspace "Online Ticket Booking Platform" "This is an example workspace to illustrate the key features of Structurizr, via the DSL, based around a fictional online banking system." {

    model {
        customer = person "User" "A user of Online Ticketing System." "User"
         enterprise "Online Shopping" {
            shoppingSystemContext = softwaresystem "Shopping Platform" {
                singlePageApplication = container "Single Page App"
                mobileApp = container "MobileApp"
                microservices = container "AKS Hosted Microservice" {
                   productService = component "Product Service"
                   cartService = component "Cart Service"
                   orderService = component "Order Service"
                }
            }
        }
    }
    views {

          systemlandscape "SystemLandscape" {
            include *
            autoLayout
        }

        systemcontext shoppingSystemContext "SystemContext" {
            include *
            animation {
                shoppingSystemContext
                customer
            }
            autoLayout
        }

        container shoppingSystemContext "Containers" {
            include *
            animation {
                singlePageApplication
                mobileApp
                microservices
            }
            autoLayout
        }
        systemContext shoppingSystemContext {
         include *
            animation {
                shoppingSystemContext
            }
            autoLayout
        }
        component microservices "Components" {
            include *
            animation {
                productService
                cartService
                orderService
            }
            autoLayout
        }
        styles {
            element "Software System" {
                background "#1168bd"
                color "#ffffff"
            }
            element "Person" {
                shape "Person"
            }
            element "Software System Instance" {
                shape "RoundedBox"
            }
            element "Container" {
                shape "RoundedBox"
            }
            element "Component" {
                shape "RoundedBox"
            }
        }
    }
        
    }
