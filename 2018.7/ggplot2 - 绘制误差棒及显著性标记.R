
#绘制带有误差棒的条形图
library(ggplot2)
df <- data.frame(treatment=factor(c(1,1,1,2,2,2,3,3,3)),
                 response=c(2,5,4,6,9,7,3,5,8),
                 group=factor(c(1,2,3,1,2,3,1,2,3)),
                 se=c(0.4,0.2,0.4,0.5,0.3,0.2,0.4,0.6,0.7))
#查看数据集
head(df) 
#使用goem_errorbar()绘制带有误差棒的条形图
#这里一定要注意position要与`geom_bar()`保持一致，由于系统默认dodge是0.9，
#因此geom_errorbar()里面position需要设置0.9，width设置误差棒的大小
ggplot(data=df,aes(x=treatment,y=response,fill=group))+
  geom_bar(stat='identity',position='dodge')+  #stack是堆砌，dodge是相邻
  geom_errorbar(aes(ymax=response+se,ymin=response-se),
                position=position_dodge(0.9),width=0.15)+
  scale_fill_brewer(palette = 'Set1')

#绘制带有显著性标记的条形图
#随机设置显著性,这里假设1是对照
label <- c("","*","**","","**","*","","","*")
ggplot(data=df,aes(x=treatment,y=response,fill=group))+
  geom_bar(stat='identity',position='dodge')+  #stack是堆砌，dodge是相邻
  geom_errorbar(aes(ymax=response+se,ymin=response-se),
                position=position_dodge(0.9),width=0.15)+
  geom_text(aes(y=response+1.5*se,label=label,group=group),
            position=position_dodge(0.9),size=5,fontface="bold")+
  scale_fill_brewer(palette = 'Set1')

#连接两个条形图
Control <- c(2.0,2.5,2.2,2.4,2.1)
Treatment <- c(3.0,3.3,3.1,3.2,3.2)
mean <- c(mean(Control),mean(Treatment))
sd <- c(sd(Control),sd(Treatment))
df1 <- data.frame(V=c("Control","Treatment"),mean=mean,sd=sd)
df1$V <- factor(df1$V,levels=c("Control","Treatment"))
#利用geom_segment()绘制图形
ggplot(data=df1,aes(x=V,y=mean,fill=V))+
  geom_bar(stat='identity',position=position_dodge(0.9),color='black')+
  geom_errorbar(aes(ymax=mean+sd,ymin=mean-sd),width=0.05)+
  geom_segment(aes(x=1,y=2.5,xend=1,yend=3.8))+  #绘制control端的竖线
  geom_segment(aes(x=2,y=3.3,xend=2,yend=3.8))+  #绘制treatment端的竖线
  geom_segment(aes(x=1,y=3.8,xend=1.45,yend=3.8))+
  geom_segment(aes(x=1.55,y=3.8,xend=2,yend=3.8))+  #绘制两段横线
  annotate('text',x=1.5,y=3.8,label='O',size=5)     #添加标签

#为图形添加标题
p <- ggplot(data = df, aes(x = treatment, y = response, fill = group)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymax = response + se, ymin = response -  se),
                position = position_dodge(0.9), width = 0.15) +
  scale_fill_brewer(palette = "Set1")
#利用ggtitle()添加图标题,还有labs（）也可以添加标题
#ggtitle()添加的标题总是左对齐）
p + ggtitle("利用ggtitle()添加图标题")

#利用xlab()\ylab()添加/修改坐标轴标题
p + ggtitle("利用ggtitle()添加图标题") +
  xlab("不同处理") +ylab("response") 

##如何将多副图至于一个页面 利用包gridExtra中grid.arrange()函数实现
p <- ggplot(data = df, aes(x = treatment, y = response, fill = group)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymax = response + se, ymin = response -  se),
                position = position_dodge(0.9), width = 0.15) +
  scale_fill_brewer(palette = "Set1")
p1 <- p + ggtitle("利用ggtitle()添加图标题")
p2 <- p + ggtitle("利用ggtitle()添加图标题") + xlab("不同处理") + ylab("response")
p3 <- ggplot(data = df, aes(x = treatment, y = response, fill = group)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymax = response + se, ymin = response -  se),
                position = position_dodge(0.9), width = 0.15) +
  geom_text(aes(y = response +  1.5 * se, label = label, group = group),
            position = position_dodge(0.9), size = 5, fontface = "bold") +
  scale_fill_brewer(palette = "Set1")
#将四幅图放置于一个页面中
library(gridExtra) 
grid.arrange(p, p1, p2, p3)










