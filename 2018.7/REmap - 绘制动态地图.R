 
##安装并加载
install.packages("devtools")
devtools::install_github("lchiffon/REmap")  #开发者/包名
library(REmap)
#调用百度AK
options(remap.ak = "WFXqy6R155jv0FOzXGi9B7Un7v65v8sr")

##流向地图
#创建起始点
destination <- c("beijing","tianjin","shenyang","dalian","zhengzhou") #终点
origin <- rep("dalian",length(destination)) #起点
#合成数据框格式的起终点数据
map_data <- data.frame(origin,destination)
#作图
map_out <- remap(mapdata=map_data, #流向地图的数据源
                 title="我是标题",
                 subtitle = "我是副标题",
                 theme=get_theme(theme="Bright")) #设置主题
plot(map_out)

##流入地图
origin <- c("beijing","tianjin","shenyang","dalian","zhengzhou") #终点
destination <- rep("dalian",length(destination)) #起点
#合成数据框格式的起终点数据
map_data2 <- data.frame(origin,destination)
#作图
map_out2 <- remap(mapdata=map_data2, #流向地图的数据源
                 title="我是标题",
                 subtitle = "我是副标题",
                 theme=get_theme(theme="Bright")) #设置主题
plot(map_out2)

