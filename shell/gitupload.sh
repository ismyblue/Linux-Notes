#!/bin/bash

#一次性更新本地仓库，并且更新远程仓库
#author:Bruce ismyblue@163.com

if [ $# -eq 0 ] || [ $1 == "--help" ] ; then
  echo "--help 帮助"
  echo "gitupload.sh para1 para2   所带参数会全部变成提交备注" 
  exit;
fi


str="auto commit"

for f in $*
do
   str=$str" "$f
done


echo $str

echo -e "\n------------------\n查看工作区状态...\n------------------\n"
git status
echo -e "\n------------------\n新文件增加到工作区...\n------------------\n"
git add -v --all
echo -e "\n------------------\n查看工作区状态...\n------------------\n"
git status
echo -e "\n------------------\n提交工作状态.备注auto update...\n------------------\n"
git commit -m "$str"
echo -e "\n------------------\n拉取远程仓库更新...\n------------------\n"
git fetch origin master
echo -e "\n------------------\n合并远程仓库更新...\n------------------\n"
git merge origin/master
echo -e "\n------------------\n更新本地仓库到远程仓库...\n------------------\n"
git push origin master
echo -e "\n------------------\n查看更新日志...\n------------------\n"
#git log
echo -e "\n------------------\n操作完毕！...\n------------------\n"
