#!/bin/bash

# 更新系統套件
sudo yum update -y

# 安裝Python和pip
sudo yum install python3 python3-pip -y

# 安裝系統依賴
sudo yum install mysql-devel gcc python3-devel -y

# 創建項目目錄
mkdir -p /home/ec2-user/simhei-app
cd /home/ec2-user/simhei-app

# 創建虛擬環境
python3 -m venv venv
source venv/bin/activate

# 安裝Python依賴
pip install -r requirements.txt

# 安裝Gunicorn生產服務器
pip install gunicorn

# 開放防火牆端口（可選，取決於安全組）
sudo firewall-cmd --permanent --add-port=5000/tcp
sudo firewall-cmd --reload

# 使用Gunicorn啟動應用
gunicorn --bind 0.0.0.0:5000 app:app