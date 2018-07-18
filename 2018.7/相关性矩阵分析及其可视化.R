
#R内置函数 cor() 可以用来计算相关系数：cor(x, method = c("pearson", "kendall"))
#如果数据有缺失值，用cor(x, method = "pearson", use = "complete.obs")

data(mtcars)  #加载数据集
mydata <- mtcars[,c(1,3,4,5,6,7)]
head(mydata,6)  #查看数据前6行

res <- cor(mydata)  #计算相关系数矩阵
round(res,2)  #保留两位小数

#cor()只能计算出相关系数，无法给出显著性水平p-value
#Hmisc包里的rcorr()函数能够同时给出相关系数以及显著性水平p-value
#rcorr(x, type = c(“pearson”,“spearman”))
library(Hmisc)  #加载包
res2 <- rcorr(as.matrix(mydata))
res2

#可以用res2$r、res2$P来提取相关系数以及显著性p-value
res2$r
res2$P

#可视化相关系数矩阵
symnum(res,abbr.colnames = FALSE) #abbr.colnames用来控制列名

#通过颜色深浅来表示显著相关程度
library(corrplot)
corrplot(res, type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)

#heatmap()
col<- colorRampPalette(c("blue", "white", "red"))(20)
#调用颜色版自定义颜色
heatmap(x = res, col = col, symm = TRUE)
#symm表示是否对称

