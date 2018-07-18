##  R-data-visualization ##
R语言可视化笔记

### 2018.7 ###
- **ggflags - 国旗与奥运会奖牌的可视化**	[（文章链接）](https://mp.weixin.qq.com/s?__biz=MzA3MTM3NTA5Ng==&mid=2651057765&idx=1&sn=dcbeffbec5f99f2270f6575371b4e3fb&chksm=84d9cff2b3ae46e4d00064d45b059150316aede10be25a37e465a86c38da015a3da72994df90&scene=21#wechat_redirect) （代码链接）
	- 可视化索契冬奥会各国得奖数，将国旗与国家联系起来
	- `coord_flip ()` 旋转坐标轴，一是可以添加数据标签，二是不用歪着脖子看
	- R包：ggflags、ggplot2、dplyr（数据清洗）、tidyr（数据清洗）、rvest（爬虫）、countrycode（国家名缩写）

- **ggplot2 - 绘制误差棒及显著性标记** [（文章链接）](https://mp.weixin.qq.com/s?__biz=MzA3MTM3NTA5Ng==&mid=2651057637&idx=1&sn=f69b192e01ebca087b6556f83a9ca5a3&chksm=84d9cc72b3ae4564b014dadd94c141e36fdf301ba14e6ecfb2ed0db0705c7220717fc6cdc71a&scene=21#wechat_redirect) （代码链接）
	- 使用 `geom_errorbar ()` 绘制带有误差棒的条形图
	- 使用 `geom_text () `绘制带有显著性标记的条形图
	- 使用 `geom_segment () `连接两个条形图
	- 利用包 gridExtra 中 `grid.arrange()` 函数实现将多副图至于一个页面
	- R包：ggplot2、gridExtra
- **REmap - 绘制动态地图 **[（文章链接）](https://mp.weixin.qq.com/s?__biz=MzA3Njc0NzA0MA==&mid=2653190246&idx=1&sn=caa66209ad5f4cb59a1a59b715642a60&chksm=848c4029b3fbc93f41d39196e1e931385de355b725f7372e33a2dd02bfd5ff4cce1c25a29945&scene=21#wechat_redirectv) （代码链接）
	- 绘制流入图 & 流出图
	- REmap可以非常轻松的获取城市地点的经纬度数据：`get_city_coord("大连")`	、`get_geo_position(city_list)`
	- 对拼音与汉字，甚至拼音的大小写都不敏感，可以避免很多麻烦
	- REmap图表都带有动态交互效果，非常炫酷
- **ggplot2 - 美国肥胖症可视化** [（文章链接）](https://blog.csdn.net/kmd8d5r/article/details/79213608)（代码链接）
	- 研究美国成年人、儿童以及青少年中肥胖人口最多的州
	- 对行列名进行重命名的函数：`names()`、`colnames()`，`rownames()`
	- `gsub()`：对自定义的字符串进行替换
	- `make.name()`：规整变量名
	- `merge()`：按列合并数据
	- R包：rvest、ggplot2、dplyr、scales、maps（提供地图底图）、magrittr（管道操作）
- **string包** [（文章链接）](https://blog.csdn.net/kMD8d5R/article/details/79250916)
	- `nchar()`（base包）、`str_length()`、`str_count()`：计算字符串长度
	- `paste(str1, str2)`（base包）、`str_c()`：字符串拼接
	- `str_split()`：字符串拆分
	- `str_extract()`、`str_sub()`、`str_subset()`：匹配字符串
	- `str_replace()`：字符串替换
- **相关性矩阵分析及其可视化** [（文章链接）](https://blog.csdn.net/kmd8d5r/article/details/79260986) （代码链接）
	- base中的 `cor()` ：用来计算相关系数
	- Hmisc中的 `rcorr()`：能够同时给出相关系数以及显著性水平p-value
	- `corrplot()` ：来自于包corrplot，通过颜色深浅来显示相关程度
	- R包：Hmisc（提供广义线形回归模型）、corrplot