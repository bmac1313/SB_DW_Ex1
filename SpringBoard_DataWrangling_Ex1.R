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

#ADD NEW COLUMNS (product_code, product_number) and separate column
refined_original<-separate(refined_original, 
                           Product.code...number, 
                           c('product_code','product_number'), 
                           sep='-')

#Add categories
#CAPS ARE IMPORTANT
refined_original<-mutate(refined_original,type=recode(product_code, V="TV",
                                                      X="LAPTOP",
                                                      Q="TABLET",
                                                      P="SMARTPHONE"))

#ADD new address column for geocoding
refined_original<-mutate(refined_original, full_address= address,city,country)

#Add new columns for companies
refined_original$company_phillips<-ifelse(refined_original$company=="PHILLIPS",1,0)
refined_original$company_akzo<-ifelse(refined_original$company=="AKZO",1,0)
refined_original$company_van_houten<-ifelse(refined_original$company=="VAN HOUTEN",1,0)
refined_original$company_unilever<-ifelse(refined_original$company=="UNILEVER",1,0)  

#Add new columns for categories
refined_original$product_smartphone<-ifelse(refined_original$type=="SMARTPHONE",1,0)
refined_original$product_tv<-ifelse(refined_original$type=="TV",1,0)
refined_original$product_laptop<-ifelse(refined_original$type=="LAPTOP",1,0)
refined_original$product_tablet<-ifelse(refined_original$type=="TABLET",1,0)
  
#Export final
write.csv(refined_original,file = 'refine_clean_new.csv')
