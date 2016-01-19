library("XML")
library(httr)

for (i in 1:17)
{ 
  temp <- "https://www.daraz.pk/mobile-phones/?viewType=gridView&page="

print(i)
  
  url <- paste(temp,i, sep = '')
  
  fileurl <- GET(url)
  
  doc <- htmlTreeParse(fileurl,useInternal =TRUE )
  
 
  title <- gsub("[-\n,]", "",xpathSApply(doc, "//section[@class='products']/div/a[@class='link']/h2[@class='title']/span[@class='name']",xmlValue))
   
  #print(title)
  summary(title)
  
  price <- gsub("[,]", "",xpathSApply(doc, "//section[@class='products']//a[@class='link']/span[@class='price-box']/span[@class='price ']/span[2]",xmlValue))
#print (price)
   summary(price)
  link <- xpathSApply(doc, "//section[@class='products']//a[@class='link']/@href")
#print (link)
   summary(link)
   Brand <- xpathSApply(doc, "//section[@class='products']//a[@class='link']/h2[@class='title']/span[@class='brand ']",xmlValue)
   
   summary(Brand)
   


  
  
  
   dfrm <- data.frame(title = title , price = price ,Brand = Brand ,link = link )
   if(i<= 1)
   write.table(dfrm, file = "draz2.csv", append = TRUE, col.names = TRUE,row.names = FALSE, sep = ',')
   else
     write.table(dfrm, file = "draz2.csv", append = TRUE, col.names = FALSE,row.names = FALSE, sep = ',')

  } 
  
  
 
  
 
