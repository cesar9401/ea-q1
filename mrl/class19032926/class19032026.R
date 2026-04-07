library(MASS)

Cars93

str(Cars93[,c('Price','EngineSize','Type')])

levels(Cars93$Type)

Cars93$Type<-relevel(Cars93$Type,ref='Small')

levels(Cars93$Type)

mod<-lm(Price~EngineSize+Type,data=Cars93)

mod

model.matrix(~Type,data=Cars93)

contrasts(Cars93$Type)

nuevo<-data.frame(EngineSize=1.8,Type="Van")

predict(mod,newdata=nuevo)

nuevo<-data.frame(EngineSize=2.5,Type="Large")