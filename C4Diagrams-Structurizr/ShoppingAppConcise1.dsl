    /*
    * This is a combined version of the following workspaces:
    *
    * - "Online Shopping - System Landscape" (https://structurizr.com/workspace/76690/diagrams#SystemLandscape/)
    * - "Online Shopping - Online Shopping System" (https://structurizr.com/workspace/76690/diagrams#Containers)
    */
    workspace "Online Shopping Platform" "This is an example workspace to illustrate the key features of Structurizr, via the DSL" {

        model {
            customer = person "User" "A user of Online Shopping ." "User"

            enterprise "Online Shopping Platform" {
                

            shoppingSystemContext = softwaresystem "Online Shopping System" "Allows customers to do shopping " {
                    singlePageApplication = container "Single-Page Application" "Provides Online Shopping functionality to customers via web browser." "JavaScript and Angular" "Web Browser"
                    mobileApp = container "Mobile App" "Provides a limited subset of the Online Shopping  functionality to customers via mobile device." "Xamarin" "Mobile App"
                    microservices = container "AKS  Cluster - Multiple Microservices" "AKS Cluster" "AKS Cluster" {
                        productService = component "Product Service" "Allows users to manage Cart" "ASP.Net Core Microservice"
                        cartService = component "Cart Sevice" "Allows users to manage Products" "ASP.Net Core Microservice"
                        orderService = component "Order Service" "Allows users to manage orders" "ASP.Net Core Microservice"
                        }
                    
                    serviceBus = container "Azure Service Bus" "Azure Service Bus Queue for Asyn Communication" "Azure Service Bus (Message Broker)" "Azure Service Bus"
                    productsDB = container "Product DB" "Stores Product Details" "Azure SQL Database Schema" "Product DB"
                    cartDB = container "Cart DB" "Maintains Cart related info" "Azure SQL Database Schema" "Cart DB"
                    orderDB = container "Order DB" "Maintains Order related info" "Azure SQL Database Schema" "Cart DB"

                }
            }

            # relationships between people and software systems
            customer -> shoppingSystemContext "Does online shopping using" 
            # relationships to/from containers
            
            customer -> singlePageApplication "Does online shopping using"
            customer -> mobileApp "Does online shopping using"
            

            # relationships to/from components
            singlePageApplication -> productService 
            singlePageApplication -> cartService 
            singlePageApplication -> orderService 
        

            mobileApp -> productService 
            mobileApp -> cartService 
            mobileApp -> orderService 
            

            productService -> productsDB "Reads from" "DB Call"
            
            cartService -> cartDB "Reads & Write" "DB Call"

            cartService -> serviceBus "Pub/Sub" "Pub/Sub"
        
            orderService -> orderDB "Reads & Write" "DB Call"

            orderService -> serviceBus "Pub/Sub" "Pub/Sub"
        

            serviceBus -> orderService "Subscribe Cart message" "Subscribe"


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
                    customer  
                    
                    singlePageApplication
                    mobileApp
                    microservices
                productsDB
            cartDB
            serviceBus
        
                }
                autoLayout
            }

            component microservices "Components" {
                include *
                animation {
                    singlePageApplication mobileApp productsDB cartDB serviceBus customer 
                    productService 
                    cartService
                    orderService 
                }
                autoLayout
            }

             styles {
        relationship "Relationship" {
                    color #000000
                    dashed false
            fontSize 28
                }
                element "Person" {
                    color #ffffff
                    fontSize 22
                    shape Person
                }
                element "Customer" {
                    background #08427b
                }
                element "Bank Staff" {
                    background #999999
                }
                element "Software System" {
                    background #1168bd
                    color #ffffff
            fontSize 28
                }
                element "Existing System" {
                    background #999999
                    color #ffffff
                }
                element "Container" {
                    background #438dd5
                    color #ffffff
            fontSize 28
                }
            element "Components" {
            fontSize 40
            color #000000
        }
                element "Web Browser" {
                    shape WebBrowser
                }
                element "Mobile App" {
                    shape MobileDeviceLandscape
                }
                element "User DB" {
                    shape Cylinder
                }
            element "Azure Service Bus" {
            shape Pipe
            }

        element "Product DB" {
                    shape Cylinder
                }
        element "Cart DB" {
                    shape Cylinder
                }

                element "Component" {
                    background #85bbf0
                    color #000000
                }
                element "Failover" {
                    opacity 25
                }
            }
  
        }
    }
           