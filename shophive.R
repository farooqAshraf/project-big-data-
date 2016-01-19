library("XML")
library(httr)

for (i in 1:12)
{ 
  temp <- "http://www.shophive.com/mobiles-tablets/mobile-phones?p="
  
  print(i)
  
  url <- paste(temp,i, sep = '')
  
  fileurl <- GET(url)

  doc <- htmlTreeParse(fileurl,useInternal =TRUE )
    
  links <- xpathSApply(doc, "//div[@class='product-block']/div[@class='product-block-inner']/h2[@class='product-name']/a/@href")
  print (links)
  
  for(link in links )
  {
    fileurl <- GET(link)
    
   doc <- htmlTreeParse(fileurl,useInternal =TRUE )
    
   title <-xpathSApply(doc, "//div[@class='product-shop']/div[@class='product-name']/h1",xmlValue)
  
   print(title)
   brand  = strsplit(title, " ")
   
   brand<- sapply(brand, "[[", 1)
   
   if(identical(brand,""))
   {
     brand  = strsplit(title, " ")
     
     brand<- sapply(brand, "[[", 2)
   }
     
   print(brand)
   
 # summary(title)
  price <- gsub("[,\nRs]", "",xpathSApply(doc, "//div[@class='product-shop']/div[@class='price-box']/span/span[@class='price']",xmlValue))
  print (price)
  if(length(price) == 0L)
  { print("if is runing ")
    price <- gsub("[,\nRs]", "",xpathSApply(doc, "//div[@class='product-shop']/div[@class='price-box']/span[@class ='price special-price']",xmlValue))
    print(price)
  }
  
  

  
  dfrm <- data.frame(title = title , price = price, brand=brand , link = link)
  
    if(i<=1)
      {
      if(link == links[1])
      {
       write.table(dfrm, file = "shophive2.csv", append = TRUE, col.names = TRUE,row.names = FALSE, sep = ',')
      }
      else
      {  write.table(dfrm, file = "shophive2.csv", append = TRUE, col.names = FALSE,row.names = FALSE, sep = ',')  }
      }
    else
      write.table(dfrm, file = "shophive2.csv", append = TRUE, col.names = FALSE,row.names = FALSE, sep = ',')
  
  } 

}

 





