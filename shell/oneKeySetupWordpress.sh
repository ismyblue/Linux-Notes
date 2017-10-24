#!/bin/bash

#此程序适用ubuntu 和 centos系统

echo -n "是否要一键搭建wordpress?y/n:"

read ans
if [ $ans == "Y" ] || [ $ans == "y" ] ; then
  echo "开始坐过山车"
else
  echo "你失去了体验wordpress的美妙的机会"
  exit;
fi

#判断linux发行版本
uname -a | grep -i Ubuntu
if [ $? -eq 0 ] ; then
  online=apt   #这是一台ubuntu
else
  online=yum   #这是一台centos
fi

#开始LAMP
echo "更新安装源"
sudo $online update

echo "安装apache2"
if [ $online == "apt" ] ; then
  sudo $online install apache2
else
  sudo $online install httpd
fi
echo "安装php7.0"
sudo $online install php7.0
echo "安装libapache2-mod-php7.0"
sudo $online install libapache2-mod-php7.0
echo "安装mysql-server"
sudo $online install mysql-server
echo "安装php7.0-mysql"
sudo $online install php7.0-mysql
echo "安装phpmyadmin"
sudo $online install phpmyadmin
echo "建立 /var/www/html下的软链接，可以在/var/www/html/phpmyadmin里直接访问/usr/share/phpmyadmin里面的程序"
sudo ln -s /usr/share/phpmyadmin /var/www/html/phpadmin

#echo "登录mysql"
#mysql -u root -p
#create databases wordpressdb;
#greate all privileges on wordpressdb.* to "wordpressdb"@"wordpressadmin" identified by "wordpresspasswd";
#flush privileges;
#exit;

echo "进入home主目录"
cd ~
echo "下载wordpress源码"
wget https://wordpress.org/latest.tar.gz
echo "解压wordpress源码包"
tar -zxvf latest.tar.gz
echo "把解压后的wordpress源码复制到网站根目录"
sudo cp -v ./wordpress/*  /var/www/html/
sudo service mysql start
if [ $online == "apt" ] ; then
sudo systemctl restart apache2.service
else
service httpd start
fi

#######################################################
echo "首先登录到phpmyadmin的登录界面，在浏览器输入
http://ip/phpmyadmin/index.php
或者ip//phpmyadmin/index.php
使用mysql 的root帐号和密码登录。

>(1)为WordPress数据库起个名字（可以使用'wordpress'或'blog'），将其输入到添加新数据库（Create new database）输入框中，并点击添加数据库（Create）。

>(2.)点击左上方的Home图标，返回主界面，然后点击（Privileges）（权限）。如果用户列表中没有WordPress相关用户，创建一个：

>(3).点击添加新用户（Add a new User）
为WordPress选用一个用户名（推荐使用'wordpress'）并将其输入到用户名（User name）输入框中。（确保下拉式菜单中的“使用文本字段(Use text field:)已被选中）

>(4).选用一个保密性较高的密码（最好是大小写字母、数字及符号的组合），并将其输入到密码（Password）输入框中。（确保下拉式菜单中的“使用文本字段(Use text field:)已被选中），在Re-type输入框内再次输入密码

>(5).记住设定的用户名和密码。

>(6).将所有权限（Global privileges）下的所有选项保留默认状态

>(7).点击Go.

>(8).返回权限（Privileges）界面，点击刚刚创建的WordPress用户上的查看权限（Check privileges）图标。在详细数据库权限（Database-specific privileges）界面中，在为以下数据库添加权限下拉式菜单中选择之前创建的WordPress数据库。之后页面会刷新为该WordPress数据库的权限详情。点击选中所有，选择所有权限（Check All），最后点击Go。

>(9).在结果页面上，记下页面最上方Server:后的主机名hostname（通常为localhost）。"


######################################################################

echo "在常用的web浏览器中运行安装脚本。
将WordPress文件放在根目录下的用户请访问：
http://ip/wp-admin/install.php或者http://ip/wp-admin/install.php
将WordPress文件放在子目录（假设子目录名为blog）下的用户请访问：
http://ip/blog/wp-admin/install.php或者http://ip/blog/wp-admin/install.php"

#######################################################################


echo "进入登录界面，假设你域名为 youdomain.com
浏览器输入 http://youdomain.com/wp-login.php
如果wordpress源码放在网站子目录下就是 http://youdomain.com/wordpress/wp-login.php

输入你的2.4步骤创建的帐号密码。登录后台更换主题，添加文章等等操作。"



