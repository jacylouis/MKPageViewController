# MKPageViewController
简单的写一个网易新闻PageViewController效果大概是这个样子（没有考虑VC缓存重用）</br>
github上比较好的有 TYPagerController、WMPageController 这两个开源框架都没考虑生命周期的管理 </br>

其实这个界面就是为了给我github写一个提交。</br>
大概分析一下吧。</br>
1，这种界面肯定分为两个部分，上面的titlesView，和下面的contentView。两个都能滚动肯定都是scrollview </br>
2，然后父子控制器添加viewcontroller的View</br>
3，然后为了解耦titlesView为一个类，提供delegate点击抛出点击事件协议，和datasource获得相应的titles名称协议。</br>
4，然后父viewcontroller中添加contentview，利用titlesView的delegate做点击转换的交互</br>
5，根据contentScrollView的协议方法，计算titlesView中 button或者label的颜色渐变，和缩放。</br>
6，父viewcontroller也提供delegate，和datasource协议，用于接收外面传入的VC创建，这样就差不多封装好了一个pageViewController了</br>
![image](https://github.com/xiushaomin/MKPageViewController/blob/master/界面.gif)