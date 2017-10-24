# linux搭建wordpress博客
本教程适合ubuntu
[TOC]

## 步骤：

先搭建LAMP环境

1. 安装apache2，提供解析服务器脚本的能力。
2. 安装php7.0及libapache2-mod-php7.0相关组件,得到php程序运行环境。
3. 安装mysql,以及php7.0-mysql组件，安装数据库。
4. 安装phpmyadmin（可选），mysql图形化管理工具。
6. 在mysql上为wordpess配置一个数据库，分配数据库管理帐号和密码。
5. 下载wordpress源码，配置连接数据库等相关文件，安装wordpress后台程序。
6. 重启apache,mysql等等各项服务，开始测试访问博客网站。

## 具体步骤：

### 1.准备LAMP环境

#### 1.1.安装Apache2

```
sudo apt install apache2
```

#### 1.2.安装PHP环境

```
sudo apt install php7.0
sudo apt install libapache2-mod-php7.0
```

#### 1.3.安装mysql

```
sudo apt install mysql-server
sudo apt install php7.0-mysql
```

#### 1.4.安装phpmyadmin 
***phpmyadmin是php语言写的mysql的图形化管理工具,可以不装，因为我们可以用命令行在mysql里创建数据库***

```
sudo apt install phpmyadmin 
/*安装过程中选择apache2，输入root密码，和数据库密码*/

sudo ln -s /usr/share/phpmyadmin /var/www/html/phpadmin 
/*建立 /var/www/html下的软链接，可以在/var/www/html/phpmyadmin里直接访问/usr/share/phpmyadmin里面的程序*/
```
#### 1.5.创建数据库，分配帐号和密码

为wordpress程序创建一个数据库，分配管理数据库的帐号和密码。
有两种操作方式：建议选择命令行，因为不用使用鼠标，全程用键盘五分钟配置网站。

- ***(1).命令行操作方式***

```
/*登录mysql数据库管理系统*/
$mysql -u root -p
Enter password:
Welcome to the MySQL monitor. Commands end with ; or \g.

/*创建数据库，databasename是你要为你网站创建的数据库名字：例如bruce_blog*/
mysql>create databases databasename;
Query OK, 1 row affected (0.00 sec)

/*为你的网站数据库分配帐号和密码，分配权限.databasename是你的网站数据库的名字，wordpressusername和password是你的网站数据库管理员帐号和密码.记得替换成你想要设置的。hostname通常是localhost，也可以写成服务器的ip地址/
mysql>greate all privileges on databasename.* to "wordpressusername"@"hostname" identified by "password";
Query OK, 0 rows affected (0.00 sec)

/*刷新权限*/
mysql>flush privileges;
Query OK, 0 rows affected (0.01 sec)

```

- ***(2).图形化操作方式***

首先登录到phpmyadmin的登录界面，在浏览器输入
http://youdomain.com/phpmyadmin/index.php
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

>(9).在结果页面上，记下页面最上方Server:后的主机名hostname（通常为localhost）。


#### 1.6.重启相关Apache和Mysql服务

```
sudo service mysql start
sudo systemctl restart apache2.service
```

### 2.安装和配置wordpress

#### 2.1.下载wordpress并且解压

```
wget https://wordpress.org/latest.tar.gz 
/*可以自己去找最新版或者中文版*/
tar -zxvf latest.tar.gz
```
#### 2.2.把解压后的wordpress源码复制到网站根目录

```
cp ./wordpress/*  /var/www/html/
```

#### 2.3.配置wordpress的数据库信息

两种方式：

- ***(2).编辑文件wp-config.php***
详细配置请参照[编辑 wp-config.php](https://codex.wordpress.org/zh-cn:%E7%BC%96%E8%BE%91wp-config.php)

```
返回网站根目录下的wordpress解压后的目录，将wp-config-sample.php重命名为wp-config.php，之后在文本编辑器中打开该文件。

在标有
 // ** MySQL settings - You can get this info from your web host ** //
下输入你的数据库相关信息

DB_NAME 
你的网站数据库名称

DB_USER 
你的网站数据库管理员帐号

DB_PASSWORD 
你爹网站数据库管理员帐号的密码

DB_HOST 
hostname（通常是localhost，也可以写ip。但总有例外；参见编辑wp-config.php文件中的“可能的DB_HOST值）。

DB_CHARSET 
数据库字符串，通常不可更改（参见zh-cn:编辑wp-config.php）。
DB_COLLATE 
留为空白的数据库排序（参见zh-cn:编辑wp-config.php）。
在标有

  * Authentication Unique Keys.
  的版块下输入密钥的值，保存wp-config.php文件。
  从2.6版开始，存在3种安全密钥，AUTH_KEY，SECURE_AUTH_KEY和LOGGED_IN_KEY，它们能够保证用户cookies中的信息得到更好的加密。在2.7版中引入了第四种密钥，NONCE_KEY。
你无需记住这些密钥，只要保证它们越长越复杂越好，你可以使用[在线密钥生成器](https://api.wordpress.org/secret-key/1.1/)。

  例如:
  ---------------------------------------------------------------------
define('AUTH_KEY',        '2Zf%P3mLKOy:nDykt w`w77IhTiS|jj8cH:oNJ0#r&>VX*Vs&WktX2s^9+N;YLG<');
define('SECURE_AUTH_KEY', 'D3c%SVTyYl,dBXK%$u=wI%8vHkg*tNsR0+Tz/mJh$i&O^RIdu]t++TVn4;A?vy~ ');
define('LOGGED_IN_KEY',   'F3:)_mHo4(.XCK2>u|Lg0%<xUcCjv9([0{X-d^ipM+[-/ls<Aw9mxVvxS#|aW[ #');
define('NONCE_KEY',       'E5;b!BF4=3kF0)B<y6H+zyp/!?~2&0m(z5]>]F]&o@_.-9c:3H{A;/sOGi9XF+xY');
  ---------------------------------------------------------------------
```
[在线密钥生成器](https://api.wordpress.org/secret-key/1.1/)

- ***(2)图形化界面操作配置wp-config.php***

用户可以在web浏览器中加载***wp-admin/setup-config.php***以新建wp-config.php文件。

![setup-config.php](https://codex.wordpress.org/images/5/5d/setup-config.png)

WordPress询问用户数据库的具体情况并将之写入新的wp-config.php文件。如果新文件创建成功，用户可以继续安装；否则需手动设置wp-config.php文件。


#### 2.4.运行wordpress安装脚本

在常用的web浏览器中运行安装脚本。
将WordPress文件放在根目录下的用户请访问：
http://youdomain.com/wp-admin/install.php或者http://ip/wp-admin/install.php
将WordPress文件放在子目录（假设子目录名为blog）下的用户请访问：
http://youdomain.com/blog/wp-admin/install.php或者http://ip/blog/wp-admin/install.php

![install.php](https://codex.wordpress.org/images/thumb/1/1b/install-step5.png/640px-install-step5.png)

![success](https://codex.wordpress.org/images/thumb/4/46/install-step6.png/640px-install-step6.png)

### 3.登录网站后台，测试

#### 3.1.登录网站后台

进入登录界面，假设你域名为 youdomain.com
浏览器输入 http://youdomain.com/wp-login.php
如果wordpress源码放在网站子目录下就是 http://youdomain.com/wordpress/wp-login.php

输入你的2.4步骤创建的帐号密码。登录后台更换主题，添加文章等等操作。

注：主题需要更换就要上传主题(前端模板)到网站目录下，/var/www/html/wp-content/theme/

这个目录放你的主题，也就是前端模板。
linux上传文件到服务器的命令为：
```
scp -r ~/mytheme username@ip:/var/www/html/wp-content/theme/
```
如果你的本地PC是windows可以使用FileZilla等FTP传输工具上传文件。

#### 3.2.访问你的网站

浏览器输入：http://youdomain.com

***author: Bruce***
***email: ismyblue@163.com***

