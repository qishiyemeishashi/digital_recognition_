# digital_recognition_
# 2020年新工科联盟-Xilinx暑期学校

# 项目名称
  基于FPGA的一位数字识别系统设计
# 项目介绍
## 项目概要
    该设计是基于FPGA的一位印刷体数字识别系统
    通过OV5647摄像头采集图像，将采集到的图像进行二值化处理后，经过基于数字特征算法实现对数字的识别，并将结果显示在LCD屏幕上
## 工具版本
    vivado2018.3
## 板卡型号与外设
    板卡：SEA Board
    芯片型号：Xilinx Spartan7 xcs15
    外设：摄像头OV5647，mini HDMI转HDMI线，3.5寸LCD显示屏（MPI3508）
 ## 仓库目录介绍
  ### Camero_Demo模块
      完成对图像的采集，并且将捕捉到的图像显示在LCD屏上。
  ### digital_recognition_top模块
      该模块由3个子模块构成：RGB2Binary模块、digital_recognition模块、digital_display模块
      ·RGB2Binary模块：二值化模块，对RGB数据进行二值化处理
      ·digital_recognition模块：数字识别模块，基于数字特征实现数字识别。该模块还有一个子模块，将识别后的数字转化为七段数字码，便于后面数字显示。
      ·digital_display模块：识别数字显示模块，与七段数码管显示原理类似，将识别后的数字显示到LCD屏上。
## 项目框图
      文件Project_block_diagram.png
## 完成功能
      ·实现OV5647采集的图像实时显示在LCD屏上
      ·实现0~9数字识别
      ·将识别的数字显示在LCD上
## 完成功能展示
    包括图片展示以及视频，在文件夹images中
