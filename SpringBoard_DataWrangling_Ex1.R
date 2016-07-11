#BMc Data Wrangling 1 - SPRINGBOARD DATA SCIENCE
library(dplyr)
library(tidyr)
library(splitstackshape)
refined_original <- read.csv("~/RStudio/refined_original.csv")
View(refined_original)

#CAPS all Values
refined_original=as.data.frame(sapply(refined_original, toupper))

#Edit Brand Names
refined_original$company[22:25]<-"UNILEVER"
refined_original$company[14:16]<-"PHILLIPS"
refined_original$company[7:13]<-"AKZO"
refined_original$company[1:6]<-"PHILLIPS"

#ADD NEW COLUMNS (product_code, product_number)
refined_original$newcolumn<-NA
names(refined_original)[7]<-"product_code"
refined_original$newcolumn<-NA
names(refined_original)[8]<-"product_number"

#sepearte product code and number
newcols=c("product_code","product_number")
refined_original <- refined_original%>%
  separate(.,"Product.code...number", newcols,sep="-",remove=FALSE)

#Add categories
#CAPS ARE IMPORTANT
refined_original$product_cat<-NA
refined_original$product_cat[refined_original$product_code=="V"]<-"TV"
refined_original$product_cat[refined_original$product_code=="X"]<-"LAPTOP"
refined_original$product_cat[refined_original$product_code=="Q"]<-"TABLET"
refined_original$product_cat[refined_original$product_code=="P"]<-"SMARTPHONE"

#ADD new address column for geocoding
refined_original$full_address<-NA
refined_original$full_address<-paste(refined_original$address,refined_original$city,refined_original$country,sep=" ")

#Add new columns for companies
refined_original$company_phillips<-NA
refined_original$company_akzo<-NA
refined_original$company_van_houten<-NA
refined_original$company_unilever<-NA

#Add new columns for categories
refined_original$product_smartphone<-NA
refined_original$product_tv<-NA
refined_original$product_laptop<-NA
refined_original$product_tablet<-NA
  
#Dummy data for companies
refined_original$company_phillips<-ifelse(refined_original$company=="PHILLIPS",1,0)
refined_original$company_akzo<-ifelse(refined_original$company=="AKZO",1,0)
refined_original$company_van_houten<-ifelse(refined_original$company=="VAN HOUTEN",1,0)
refined_original$company_unilever<-ifelse(refined_original$company=="UNILEVER",1,0)  
  
#Dummy data for type  
refined_original$product_tv<-ifelse(refined_original$product_cat=="TV",1,0)
refined_original$product_smartphone<-ifelse(refined_original$product_cat=="SMARTPHONE",1,0)
refined_original$product_laptop<-ifelse(refined_original$product_cat=="LAPTOP",1,0)
refined_original$product_tablet<-ifelse(refined_original$product_cat=="TABLET",1,0)

#Export final
write.csv(refined_original,file = 'refine_clean.csv')
