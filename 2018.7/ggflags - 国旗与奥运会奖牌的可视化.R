
#安装ggflags包
devtools::install_github("ellisp/ggflags")
library(ggflags)
set.seed(1111)   #编号为1111的随机数发生，确保随机数可重复性

#数据集
data <- data.frame(x=rnorm(50),y=rnorm(50),
                   #sample用法，可重复，共产生50个样本
                   country=sample(c("ar","us","cn","fr","gb","es"),50,replace=TRUE),
                   stringsAsFactors = FALSE)

#绘图
library(ggplot2)
ggplot(data,aes(x=x,y=y,country=country,size=x))+
  geom_flag()+
  #scale_country()+
  scale_size(range=c(0,10))


#冬奥会得奖排名可视化
##爬取数据
library(dplyr)
library(rvest)
url <- "http://www.nbcolympics.com/medals"
medals <- read_html(url) %>%
  html_nodes("table")%>%
  .[[1]]%>%
  html_table()
knitr::kable(head(medals))  #在knitr中生成表格

##数据清洗
install.packages("countrycode")  
library(countrycode)
library(tidyr)
medals <- medals%>%
  #mutate增加一列数据,将国家名称转换为编码方案
  mutate(code=countrycode(Country,"country.name","iso2c"))%>%
  mutate(code=tolower(code))%>%
  #gather将列聚集成键值对
  gather(medal_color,count,Gold,Silver,Bronze)%>%
  mutate(medal_color=factor(medal_color,levels=c("Gold","Silver","Bronze")))%>%
  drop_na(Country,code)  #去掉缺失值

##绘图
#筛选一下，只绘制总奖牌数不小于5的国家
medals %>% filter(Total>=5)%>%
  ggplot(aes(x=reorder(Country,Total),y=count))+
  geom_bar(stat="identity",aes(fill=medal_color))+
  geom_flag(aes(y=-2,country=code),size=10)+
  #将x坐标轴标签旋转90°
  theme(axis.text.x=element_text(angle=90,hjust=1,size=7,vjust=0.5))+
  scale_fill_manual(values=c("Gold"="gold","Bronze"="#cd7f32","Silver"="#C0C0C0"))+
  scale_y_continuous(expand=c(0.1,1))+
  xlab("Country")+
  ylab("Number of medals")+
  theme_bw()+
  theme(panel.grid=element_blank())+   #去掉网格
  theme(legend.justification = c(1,0),legend.position = c(1,0))+
  theme(legend.title = element_blank())+
  coord_flip()







