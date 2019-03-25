################# Data Visualization  Case study using R ###########################################


#using base graphics
personid <- c(1,2,3,4,5)
personwt <- c(30,40,45,52,61)
person <- data.frame(personid,personwt)
plot(person)

#install.package(ggplot)

#Loading data iris from package ggplot
data(iris)
str(iris)


#Bivariate sccatter plot (two variable)
?plot
plot(x = iris$Petal.Length, y = iris$Petal.Width, 
     main =c("Petal Length vs Petal Width"),
     xlab = c("Length of Petal"),
     ylab = c("width of petal"),
     col ="red", pch =3, lwd = 5)

plot(x =iris$Species ,y = iris$Petal.Width,
     main = c("Species vs Petal width"), xlab = c("species"),
     ylab = c("width of petal"), col ="red" , pch =2 ,lwd =2)

plot(x = iris$Petal.Length, y = iris$Petal.Width, 
     main =c("Petal Length vs Petal Width"),
     xlab = c("Length of Petal"),
     ylab = c("width of petal"),
     col = iris$Species, pch = as.numeric(iris$Species),
     cex = as.numeric(iris$species), lwd = 2)

plot(x = iris$Petal.Length, y = iris$Petal.Width, 
     main =c("Petal Length vs Petal Width"),
     xlab = c("Length of Petal"),
     ylab = c("width of petal"),
     col = iris$Species, pch = as.numeric(iris$Species), lwd =2)

#Adding legend
?legend
legend( "topleft", c ("Setosa",  "Versicolor", "Verginica") , pch = 1:3, col =1:3)

#plotting entire dataframe

plot(iris)


?par
#multiple plots in single window
par(mfrow = c(1,2))
plot(x = iris$Species, y = iris$Sepal.Width,
     xlab = "Species",
     main = "sepal width across species",
     col = " red")

plot(x = iris$Species, y = iris$Sepal.Length,
     xlab = "Species",
     main = "sepal width across species",
     col = " blue")

dev.off()


#univariate analysis

#box plot (independently)


b1 <- boxplot(iris$Petal.Width, main = "Width of petal",
              col = "blue", horizontal = T)

b1 

b2 <- boxplot(iris$Petal.Width, main = "Width of petal",
              col = "blue", horizontal = F)

?boxplot

# To deduct outliers using boxplot
setosa <- iris[iris$Species == "setosa", ]

b1 <-boxplot(setosa$Petal.Width, main = "Width of petal",
             col = "blue", horizontal = T)
b1 
b1$out 
#which of the  rows contain 0.5 and 0.6(where are the outliers located in row)
#which(setosa$petalwidth == 0.5)
#which(setosa$petalwidth ==0.6)
#which(setosa$petalwidth == 0.5 | setosapetalwidth == 0.6)
#in operator either or (values)
ind <-which(setosa$Petal.Width %in% b1$out)
ind

#0.5        
setosa$Petal.Width[24]

#0.6
setosa$Petal.Width[44]

#Removing rows
setosa1 <- setosa[-ind,]

#Imputing the rows
setosa[ind,"Petal.Width"] <- 0.2


#histograms shows frequency distribution of any variable y-freq X -bin
#mean is more than median ---> right skewed
#mean is less than median ---> left skewed
#histogram is a pictorial presentation
#summary gives exact values

hist(iris$Sepal.Width,col = "orange", lable = T)

#another way to see skewness
summary(iris$Sepal.Width)


#with 5 bins
hist(iris$Sepal.Width,breaks =5, col = "orange", lable = T)

#with range for x axis(xlim =limits for xaxis)
?hist
hist(iris$Sepal.Width,xlim = c(1,5),breaks =5, col = "orange", lable = T)



#using ggplot2

setwd("D:\\Kowsi_DataScience_R\\Class-Datasets")

mk <- read.csv("DirectMarketing.csv")


head(mk)


#install.packages("ggplot2")
library(ggplot2)


#scatter plot, aes (aesthetic)use to set x ,y axis,size ,fill,position,color
p <- ggplot(mk, aes( x = Salary, y= AmountSpent))

#geometric attribute use to render which type of plot as per our requirement

#geom_point is scatter polt
p+geom_point()

str(mk$Gender)

#mk$Gender1 <- ifelse(mk$Gender == "Male",3,4)



p+geom_point((aes(color = Gender)))

p+geom_point(aes(color = Gender)) + xlab("salary in $") + ylab("Expenditure in $")


#Histogram
p<- ggplot(mk,aes(x=AmountSpent))
p+geom_histogram()

#transprency level
p+geom_histogram(aes(fill = Gender),position = "dodge")
p+geom_histogram(aes(fill = Gender,color =Gender), alpha = 0.3) +facet_grid(Gender~.)

#check 
summary(mk$AmountSpent)

#boxplots
p<-ggplot(mk,aes(x=Gender,y=AmountSpent,fill = Gender))
p+geom_boxplot()

#Density Graphs(area chat)
p <- ggplot(mk,aes(x = AmountSpent))
p+geom_density(aes(fill =Gender,color =Gender), alpha = 0.4)
p+geom_density(aes(fill =Gender,color =Gender), alpha = 0.4)+scale_y_continuous(labels = function(n){format(n,scientific = F)})


#Heatmap
str(mk)
p<- ggplot(mk,aes(x = Salary, y = AmountSpent))
p+geom_bin2d()
p <- ggplot(mk,aes(x =Age, y = Gender))
p+geom_bin2d()


