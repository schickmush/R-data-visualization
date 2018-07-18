
##加载相关程序包
require(rvest)
require(ggplot2)
require(dplyr)
require(scales)
require(maps)
library(magrittr)

##从网页上爬取数据
url <- "https://en.wikipedia.org/wiki/Obesity_in_the_United_States"
obesity <- read_html(url)
obesity %<>%
  html_nodes(xpath='//*[@id="mw-content-text"]/div/table[2]') %>%
  .[[1]] %>%
  html_table(fill=T)
str(obesity)  #查看数据集的基本数据结构

##数据预处理
#剔除不规整数据+重名，由于数据量较小，手动剔除
obesity <- obesity[-c(3,13,38,43,51),-3]
names(obesity) <- c('State and District of Columbia','Obese adults',
                    'Overweight(incl.obese) adults',
                    'Obese children and adolescents',
                    'Obesity rank')
str(obesity)  #查看数据集的基本数据结构
#去除"%"+转换数据类型
for(i in 2:5){
  obesity[,i]=gsub("%","",obesity[,i])
  obesity[,i]=as.numeric(obesity[,i])
}
str(obesity)
#规范列名
names(obesity)
names(obesity) <- make.names(names(obesity))
names(obesity)

##探索成年人肥胖症占比最高的前十个地区
#将State.and.District.of.Columbia列转换为小写
obesity$region <- tolower(obesity$State.and.District.of.Columbia)
states <- map_data('state')   #获取美国地图数据
states <- merge(states,obesity,by='region',all.x=T)  #按region列合并数据
#按地区统计成年人肥胖症占比，并降序排列选取前十位
topstate <- states %>% group_by(region) %>%
  summarise(Obese.adults = mean(Obese.adults)) %>% 
  arrange(desc(Obese.adults)) %>% top_n(10)

##绘制条形图
ggplot(topstate,aes(x=reorder(region,Obese.adults),y=Obese.adults))+
  geom_bar(stat='identity',color='black',fill="#87CEEB")+
  labs(x="Top 20 States",y="Percentage of Obese Adults")+
  coord_flip()+   #翻转坐标
  theme_minimal()  

##可视化美国地图上成年人肥胖症占比分布
statenames <- states %>% group_by(region) %>% summarise(
  long=mean(range(long)),lat=mean(range(lat)))

ggplot(states,aes(x=long,y=lat,group=group,fill=Obese.adults))+
  geom_polygon(color="white",show.legend=T)+  #color表示多边形的外边线颜色
  scale_fill_gradient(name="Percent",low="#FAB8D2",high="#F91C74",
                      guide="colorbar",na.value ="black",breaks=pretty_breaks(n=5))+
  labs(title="Obesity in Adults for USA",x="Longtitude",y="Latitude")+
  theme_minimal()+
  theme(plot.title = element_text(hjust=0.5,size=16))+
  geom_text(data=statenames,aes(x=long,y=lat,label=region),size=3,inherit.aes = FALSE)

##探索青年和儿童肥胖症占比最高的前十五个地区
#按地区统计青年和儿童肥胖症占比，并降序选取前15位
topChild <- states %>% group_by(region) %>% 
  summarise(Obese.children.and.Teens = mean(Obese.children.and.adolescents)) %>%
  top_n(15)
#绘制条形图
ggplot(topChild,aes(x=reorder(region,Obese.children.and.Teens),
                    y=Obese.children.and.Teens))+
  geom_col(color="black",fill="#87CEEB",alpha=0.8)+
  labs(x="Top 15 States",y="Percentage of Obese Child and Teens")+
  coord_flip()+
  theme_minimal()

##可视化美国地图上青年和儿童肥胖症占比分布
ggplot(states,aes(x=long,y=lat,group=group,fill=Obese.children.and.adolescents))+
  geom_polygon(color="white",show.legend=T)+  #color表示多边形的外边线颜色
  scale_fill_gradient(name="Percent",low="#B8D5EC",high="#0A4B7D",
                      guide="colorbar",na.value ="black",breaks=pretty_breaks(n=5))+
  labs(title="Obesity in Children and Teens",x="Longtitude",y="Latitude")+
  theme_minimal()+
  theme(plot.title = element_text(hjust=0.5,size=16))+
  geom_text(data=statenames,aes(x=long,y=lat,label=region),size=3,inherit.aes = FALSE)




