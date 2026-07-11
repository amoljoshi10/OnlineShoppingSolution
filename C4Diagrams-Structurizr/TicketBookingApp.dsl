/*
 * This is a combined version of the following workspaces:
 *
 * - "Online Ticket Booking - System Landscape" (https://structurizr.com/workspace/76690/diagrams#SystemLandscape/)
 * - "Online Ticket Booking - Online Ticket Booking System" (https://structurizr.com/workspace/76690/diagrams#Containers)
*/
workspace "Online Ticket Booking Platform" "This is an example workspace to illustrate the key features of Structurizr, via the DSL, based around a fictional online banking system." {

    model {
        customer = person "User" "A user of Online Ticketing System." "User"

        enterprise "Online Ticket Booking Platform" {
            

           ticketBookingSystem = softwaresystem "Online Ticket Booking System" "Allows customers to serach trains , check schedules,book tickets , accomodation ," {
                singlePageApplication = container "Single-Page Application" "Provides all of the online ticket booking functionality to customers via their web browser." "JavaScript and Angular" "Web Browser"
                mobileApp = container "Mobile App" "Provides a limited subset of the online ticket booking  functionality to customers via their mobile device." "Xamarin" "Mobile App"
                microservices = container "AKS - Multiple Microservices - SAGA Pattern in Action" "AKS Cluster" "AKS Cluster" {
                    userService = component "User Service" "Allows users to sign in to the online ticket booking System." "ASP.Net Core Microservice"
                    trainSearchService = component "Train Search Service" "Search Trains based on given criteria" "ASP.Net Core Microservice"
                    bookingService = component "Train Booking Service" "Allows users to book train tickets." "ASP.Net Core Microservice"
                    paymentService = component "Payment Service" "Allows users to do payments for train tickets." "ASP.Net Core Microservice"
                    trainDetailsService = component "Train Details Service" "It maintains train details." "ASP.Net Core Microservice"
                    notificationService = component "Notification Service" "Notifies user regarding booking status." "ASP.Net Core Microservice"
                }
                serviceBus = container "Azure Service Bus" "Azure Service Bus Queue for Asyn Communication" "Azure Service Bus (Message Broker)" "Azure Service Bus"
                userDB = container "User DB" "Stores user registration information, hashed authentication credentials, access logs, etc." "Azure SQL Database Schema" "User DB"
                trainDetailsDB = container "Train Details DB" "Stores train details like train #, from , to stations, available class counts  etc." "Azure SQL Database Schema" "Train Details DB"
                bookingDB = container "Booking DB" "Maintains booking related info" "Azure SQL Database Schema" "Booking DB"

            }
        }

        # relationships between people and software systems
        customer -> ticketBookingSystem "Serach trains,check schedules,book tickets,accomodation using" 
        # relationships to/from containers
        
        customer -> singlePageApplication "Serach trains,check schedules,book tickets,accomodation using"
        customer -> mobileApp "Serach trains,check schedules,book tickets,accomodation using"
        

        # relationships to/from components
        singlePageApplication -> userService "Makes API calls to" "JSON/HTTPS"
        singlePageApplication -> trainSearchService "Makes API calls to" "JSON/HTTPS"
        singlePageApplication -> bookingService "Makes API calls to" "JSON/HTTPS"
    
        mobileApp -> userService "Makes API calls to" "JSON/HTTPS"
        mobileApp -> trainSearchService "Makes API calls to" "JSON/HTTPS"
        mobileApp -> bookingService "Makes API calls to" "JSON/HTTPS"
        
        
        userService -> userDB "Reads from and writes to" "DB Call"
        trainSearchService -> trainDetailsDB "Reads from" "DB Call"
        
        bookingService -> bookingDB "Read from & Write to" "DB Call"

        bookingService -> serviceBus "Publish/Subscribe messages on service bus topic" "Pub/Sub"
    
        serviceBus -> trainDetailsService "Subscribe messages on service bus topic" "Subscribe"

        serviceBus -> paymentService "Subscribe booking message on service bus topic" "Subscribe"

        serviceBus -> notificationService "Subscribe Payment message on service bus topic" "Subscribe"

    notificationService -> customer "Sends email"

        deploymentEnvironment "Development" {
            deploymentNode "Developer Laptop" "" "Microsoft Windows 10 or Apple macOS" {
                deploymentNode "Web Browser" "" "Chrome, Firefox, Safari, or Edge" {
                    developerSinglePageApplicationInstance = containerInstance singlePageApplication
                }
                deploymentNode "Azure AKS" "" "Azure AKS" {
                    deploymentNode "Azure ACR" "" "Azure ACR" {
                        
                        developerApiApplicationInstance = containerInstance microservices
                    }
                }
                deploymentNode "Docker Container - Database Server" "" "Docker" {
                    deploymentNode "Database Server" "" "Azure SQL Database" {
                        developerDatabaseInstance = containerInstance userDB
                    developertrainDBInstance = containerInstance trainDetailsDB
            developerBookingDBInstance = containerInstance bookingDB
                    }
                }
            }
            deploymentNode "Online Ticket Booking Platform" "" "Online Ticket Booking Platform on cloud" "" {
                deploymentNode "onlineticketing-dev001" "" "" "" {
                    
                }
            }

        }

        deploymentEnvironment "Live" {
            deploymentNode "Customer's mobile device" "" "Apple iOS or Android" {
                liveMobileAppInstance = containerInstance mobileApp
            }
            deploymentNode "Customer's computer" "" "Microsoft Windows or Apple macOS" {
                deploymentNode "Web Browser" "" "Chrome, Firefox, Safari, or Edge" {
                    liveSinglePageApplicationInstance = containerInstance singlePageApplication
                }
            }

            deploymentNode "Online Ticket Booking Platform" "" "Online Ticket Booking Platform on cloud" {
                deploymentNode "onlineticketing-web***" "" "Ubuntu 16.04 LTS" "" 4 {
                    deploymentNode "AKS Nodes" "" "AKS Nodes" {
                        
                    }
                }
                deploymentNode "onlineticketing-api***" "" "Ubuntu 16.04 LTS" "" 8 {
                    deploymentNode "AKS Nodes" "" "AKS Nodes" {
                        liveApiApplicationInstance = containerInstance microservices
                    }
                }

                deploymentNode "onlineticketing-db01" "" "Ubuntu 16.04 LTS" {
                    primaryDatabaseServer = deploymentNode "Azure SQL - Primary" "" "Azure SQL" {
                        livePrimaryDatabaseInstanceuserDB = containerInstance userDB
            livePrimaryDatabaseInstancetrainDetailsDB = containerInstance trainDetailsDB
            livePrimaryDatabaseInstancebookingDB = containerInstance bookingDB
                    }
                }
                deploymentNode "onlineticketing-db02" "" "Ubuntu 16.04 LTS" "Failover" {
                    secondaryDatabaseServer = deploymentNode "Azure SQL - Secondary" "" "Azure SQL" "Failover" {
                        liveSecondaryDatabaseInstanceuserDB = containerInstance userDB "Failover"
            liveSecondaryDatabaseInstancetrainDetailsDB = containerInstance trainDetailsDB "Failover"
            liveSecondaryDatabaseInstancebookingDB = containerInstance bookingDB "Failover"
                    }
                }
                deploymentNode "onlineticketing-prod001" "" "" "" {
                    
                }
            }

            primaryDatabaseServer -> secondaryDatabaseServer "Replicates data to"
        }
    }

    views {
        systemlandscape "SystemLandscape" {
            include *
            autoLayout
        }

        systemcontext ticketBookingSystem "SystemContext" {
            include *
            animation {
                ticketBookingSystem
                customer

            }
            autoLayout
        }

        container ticketBookingSystem "Containers" {
            include *
            animation {
                customer  
                
                singlePageApplication
                mobileApp
                microservices
                userDB
            trainDetailsDB
        bookingDB
        serviceBus
    
            }
            autoLayout
        }

        component microservices "Components" {
            include *
            animation {
                singlePageApplication mobileApp userDB trainDetailsDB bookingDB serviceBus customer 
                userService 
                trainSearchService 
                bookingService notificationService 
            }
            autoLayout
        }

        dynamic microservices "SignIn" "Summarises how the sign in feature works in the single-page application." {
            singlePageApplication -> userService "Submits credentials to"
            
            userService -> userDB "select * from users where username = ?"
            userDB -> userService "Returns user data to"
            
            userService -> singlePageApplication "Sends back an authentication token to"

            trainSearchService -> trainDetailsDB "select * from trainDetails where date = ? and fromStation =? and toStation=?"
            trainDetailsDB -> trainSearchService "Returns train details data to"

            bookingService -> bookingDB "Read/Write Request"
            bookingDB -> bookingService "Read/Write Response"

        bookingService -> serviceBus "Publish Booking Message"
            serviceBus -> paymentService "Subscribe to Booking Message"

            paymentService -> serviceBus "Publish Payment status message"
       
        serviceBus -> trainDetailsService "Subscribe to Payment status message"        

        trainDetailsService -> serviceBus "Publish Ticket Count Update Message"
        serviceBus -> notificationService "Subscribe to Ticket Count Update Message"        

        notificationService -> serviceBus "Publish Ticket Confirmation Message"

        serviceBus -> bookingService "Subscribe to Ticket Confirmation Message"        

            autoLayout
        }

        deployment ticketBookingSystem "Development" "DevelopmentDeployment" {
            include *
            animation {
                developerSinglePageApplicationInstance
                developerApiApplicationInstance
                developerDatabaseInstance
                developertrainDBInstance
            developerBookingDBInstance
            }
            autoLayout
        }

        deployment ticketBookingSystem "Live" "LiveDeployment" {
            include *
            animation {
                liveSinglePageApplicationInstance
                liveMobileAppInstance
                 liveApiApplicationInstance
                livePrimaryDatabaseInstanceuserDB
                liveSecondaryDatabaseInstanceuserDB
        livePrimaryDatabaseInstancetrainDetailsDB
        liveSecondaryDatabaseInstancetrainDetailsDB
        livePrimaryDatabaseInstancebookingDB
        liveSecondaryDatabaseInstancebookingDB
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

       element "Train Details DB" {
                shape Cylinder
            }
      element "Booking DB" {
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
