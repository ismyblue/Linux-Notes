Ubuntu Linux 环境变量PATH设置
=====

说明:本文为转载自[这里](http://www.cnblogs.com/hust-chenming/p/4943268.html)和[这里](http://blog.csdn.net/witsmakemen/article/details/7831631)

## 首先介绍各文件

###Ubuntu Linux系统环境变量配置文件： 

1. **/etc/profile** : 在登录时,操作系统定制用户环境时使用的***第一个文件*** ,此文件为系统的每个用户设置环境信息,当用户第一次登录时,该文件被执行。 

2. /etc /environment : 在登录时操作系统使用的***第二个文件***, 系统在读取你自己的profile前,设置环境文件的环境变量。 

3. ~/.profile :  在登录时用到的***第三个文件***是.profile文件,每个用户都可使用该文件输入专用于自己使用的shell信息,当用户登录时,该文件仅仅执行一次!默认情况下,他设置一些环境变量,执行用户的.bashrc文件。

4. ~/.bashrc : 该文件包含专用于你的bash shell的bash信息,当登录时以及每次打开新的shell时,该该文件被读取。 

5. /etc/bashrc : 为每一个运行bash shell的用户执行此文件.当bash shell被打开时,该文件被读取. 


## PATH环境变量的设置方法： 

查看PATH：echo $PATH
以添加mongodb server为列

### 修改方法一：
export PATH=/usr/local/mongodb/bin:$PATH
//配置完后可以通过echo $PATH查看配置结果。
生效方法：立即生效
有效期限：临时改变，只能在当前的终端窗口中有效，当前窗口关闭后就会恢复原有的path配置
用户局限：仅对当前用户

 

### 修改方法二：
通过修改.profile或者.bashrc文件(推荐):
vim ~/.bashrc 
//在最后一行添上：
export PATH=/usr/local/mongodb/bin:$PATH
生效方法：（有以下两种）
1、关闭当前终端窗口，重新打开一个新终端窗口就能生效
2、输入“source ~/.bashrc”命令，立即生效
有效期限：永久有效
用户局限：仅对当前用户

 

### 修改方法三:
通过修改profile文件:
vim /etc/profile
/export PATH //找到设置PATH的行，添加
export PATH=/usr/local/mongodb/bin:$PATH
生效方法：系统重启 或者 source /etc/profile
有效期限：永久有效
用户局限：对所有用户

 

### 修改方法四:
通过修改environment文件:
vim /etc/environment
在PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"中加入“:/usr/local/mongodb/bin”
生效方法：系统重启 或者 source /etc/environment
有效期限：永久有效
用户局限：对所有用户

### 注 意：
方法三和四的修改需要谨慎，尤其是通过root用户修改，如果修改错误，将可能导致一些严重的系统错误。因此笔者推荐使用第一种方法。另外嵌入式 Linux的开发最好不要在root下进行（除非你对Linux已经非常熟悉了！！），以免因为操作不当导致系统严重错误。

下面是一个对environment文件错误修改导致的问题以及解决方法示例： 

问题：因为不小心在 etc/environment里设在环境变量导致无法登录 
提示：不要在 etc/environment里设置 export PATH这样会导致重启后登录不了系统 
解决方法： 
#### 在登录界面 alt +ctrl+f1 ####
进入命令模式，如果不是root用户需要键入（root用户就不许这么罗嗦，gedit编辑会不可显示） 
#### **/usr/bin/sudo /usr/bin/vi /etc/environment **
光标移到export PATH** 行，连续按 d两次删除该行； 
输入:wq保存退出； 
然后键入/sbin/reboot重启系统（可能会提示need to boot，此时直接power off）
