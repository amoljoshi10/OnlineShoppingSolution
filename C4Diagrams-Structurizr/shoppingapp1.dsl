# write a c4 model diagram using structurizr DSL  with workspace "OnlineShoppingApp" 
# and  within workspace add model  and view 
# Then within model add variable customer of type Person with description "User" 
# and enterprise object display text  "Online Shopping"
# And enterprise object contains variable shoppingSystemContext of type softwaresystem with description  "Shopping Platform"
# And then softwaresystem contains variable siglePageApp of container type with description  "Single Page App" 
# And then add variable mobileApp of container type with description "MobileApp" 
# And then add variable microservices of container type with description "AKS Hosted Microservice" . 
# And then microservices contains variable productService of component type with description "Product Service" ,
# add  variable productService of component type with description "Product Service"
# add  variable cartService of component type with description "Cart Service"
# add  variable orderService of component type with description "Order Service" 
# then variable serviceBus of container type with description "Azure Service Bus"
# then variable productsDB of container type with description "Product DB"
# then variable cartDB of container type with description "Cart DB"
# then variable orderDB of container type with description "Order DB"
# then add relationships customer -> shoppingSystemContext
# customer -> singlePageApp
# customer -> mobileApp
# singlePageApp -> productService
# singlePageApp -> cartService
# singlePageApp -> orderService
# mobileApp -> productService
# mobileApp -> cartService
# mobileApp -> orderService
# productService -> productsDB
# cartService -> cartDB
# orderService -> cartDB
# orderService -> serviceBus
# serviceBus -> serviceBus
# And views type systemlandscape  with key "SystemLandscape"and within that add include * autolayout
# And then view type systemcontext  with key "SystemContext" and within that add anmation for shoppingSystemContext,customer vairables. 
# And then type conatiner for shoppingSystemContext with key "Container" and add animarion for customer,singlePageApplication,mobileApp,microservices,productsDB,cartDB,serviceBus variables. 
# And then then type component for microservices with key "Component" and withing that add animation for variables  singlePageApplication mobileApp productsDB cartDB serviceBus customer , productService , cartService , orderService 
# Add then wihin views after microservices component add styles and within that add black color and dashed false  fontSize 28 for relationship "Relationship" 
# And then after that  add styles and within that add background color blue and color white and fontSize 28 for element "Software System"
# And then after that add styles and within that add background color blue and color white and fontSize 28 for element "Person"
# And then after that add styles and within that add background color blue and color white and fontSize 28 for element "Container"
# And then after that add styles and within that add background color blue and color white and fontSize 28 for element "Component" 
# And then after that add styles and within that add background color blue and color white and fontSize 28 for element "Database" 
# And then after that add styles and within that add background color blue and color white and fontSize 28 for element "Queue"
