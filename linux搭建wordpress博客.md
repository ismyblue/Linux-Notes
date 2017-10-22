# linux搭建wordpress博客

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

#### 1.5.重启相关Apache和Mysql服务

```
sudo service mysql serstart
sudo systemctl restart apache2.service
```

### 2.安装和配置wordpress

#### 2.1.下载wordpress

```
wget 
```

