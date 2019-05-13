
# get server setup
scp -i "cs89.pem" -r /Users/angelo/thesis/TEST_PACKAGE  ubuntu@ec2-3-91-147-115.compute-1.amazonaws.com:/home/ubuntu/TEST_PACKAGE
scp -i "cs89.pem" /Users/angelo/Downloads/tpc-h-tool.zip  ubuntu@ec2-3-91-147-115.compute-1.amazonaws.com:/home/ubuntu/tpc-h-tool.zip
ssh -i "cs89.pem" ubuntu@ec2-3-91-147-115.compute-1.amazonaws.com
scp -i "cs89.pem" -r ubuntu@ec2-3-91-147-115.compute-1.amazonaws.com:/home/ubuntu/export /Users/angelo/thesis/tests/test5/c5

scp -i "cs89.pem" -r /Users/angelo/thesis/TEST_PACKAGE  ubuntu@ec2-18-209-241-68.compute-1.amazonaws.com:/home/ubuntu/TEST_PACKAGE
scp -i "cs89.pem" /Users/angelo/Downloads/tpc-h-tool.zip  ubuntu@ec2-18-209-241-68.compute-1.amazonaws.com:/home/ubuntu/tpc-h-tool.zip
ssh -i "cs89.pem" ubuntu@ec2-18-209-241-68.compute-1.amazonaws.com
scp -i "cs89.pem" -r ubuntu@ec2-18-209-241-68.compute-1.amazonaws.com:/home/ubuntu/export /Users/angelo/thesis/tests/test5/r5

scp -i "cs89.pem" -r /Users/angelo/thesis/TEST_PACKAGE  ubuntu@ec2-18-234-248-166.compute-1.amazonaws.com:/home/ubuntu/TEST_PACKAGE
scp -i "cs89.pem" /Users/angelo/Downloads/tpc-h-tool.zip  ubuntu@ec2-18-234-248-166.compute-1.amazonaws.com:/home/ubuntu/tpc-h-tool.zip
ssh -i "cs89.pem" ubuntu@ec2-18-234-248-166.compute-1.amazonaws.com
scp -i "cs89.pem" -r ubuntu@ec2-18-234-248-166.compute-1.amazonaws.com:/home/ubuntu/export /Users/angelo/thesis/tests/test5/m5


sudo apt-get update
sudo apt install unzip
sudo apt install make
sudo apt install gcc

#mkdir /opt/db/tpch-tool

#unzip tpc-h-tool.zip

#unzip tpch-tool/tpch-dbgen-master.zip
#cd tpch-dbgen-master

# Mount the drive
sudo file -s /dev/nvme0n1
sudo mkfs -t xfs /dev/nvme0n1
sudo mkdir /data
sudo mount /dev/nvme0n1 /data
sudo mv tpc-h-tool.zip /data
cd /data
sudo unzip tpc-h-tool.zip

sudo chmod -R 777 /data/2.18.0_rc2/dbgen
cd 2.18.0_rc2/dbgen
cp makefile.suite Makefile
vim Makefile

CC=gcc
DATABASE=ORACLE
MACHINE=LINUX
WORKLOAD=TPCH

make


#sudo mv tpch-tool/* /data
#cd /data/2.18.0_rc2/dbgen
./dbgen -s 10 -T L

for i in `ls *.tbl`; do sed 's/|$//' $i > ${i/tbl/csv}; echo $i; done;



sudo mv /home/ubuntu/TEST_PACKAGE /data
cd /data
sudo mkdir /home/ubuntu/export
sudo chmod 777 /home/ubuntu/export
sudo apt install postgresql postgresql-contrib

sudo systemctl stop postgresql
sudo vim /etc/postgresql/10/main/postgresql.conf
data_directory = '/data/main/data'           # use data in another directory
# old-> /var/lib/postgresql/10/main

sudo mkdir /data/main
sudo chown postgres:postgres /data/main
sudo chmod -R 777 /data/main

sudo su - postgres
/usr/lib/postgresql/10/bin/initdb -D /data/main/data
exit

sudo systemctl start postgresql
sudo -u postgres psql

create database tpch;
\c tpch;
\i /data/TEST_PACKAGE/postgres-create-lineitem.sql


# go to instance manager


\i /data/TEST_PACKAGE/test-1.sql
\i /data/TEST_PACKAGE/test-2.sql
\i /data/TEST_PACKAGE/test-3.sql
\i /data/TEST_PACKAGE/test-4.sql
\i /data/TEST_PACKAGE/test-2-explain.sql
\i /data/TEST_PACKAGE/test-3-explain.sql
\i /data/TEST_PACKAGE/test-3-control.sql



sudo snap start amazon-ssm-agent

sudo -u postgres psql -f /data/TEST_PACKAGE/test-4.sql
aws s3 cp /home/ubuntu/export/test3-explain.txt s3://misc-files-ak/test5_m5/explain2.txt 
aws s3 cp /home/ubuntu/export/test3-results.txt s3://misc-files-ak/test5_m5/results2.txt 


aws s3 cp s3://misc-files-ak/TEST_PACKAGE/lineitem.csv /data/2.18.0_rc2/dbgen/lineitem.csv 

aws s3 cp /data/2.18.0_rc2/dbgen/lineitem.csv s3://misc-files-ak/TEST_PACKAGE/lineitem.csv


aws s3 cp /home/ubuntu/export/test5-explain.txt s3://misc-files-ak/test5_m5/explain.txt 
aws s3 cp /home/ubuntu/export/test5-results.txt s3://misc-files-ak/test5_m5/results.txt 



vim /data/TEST_PACKAGE/test-1.sql

:%s/\/Users\/angelo\/thesis\/TPC-H\/postgres-run3.txt/\/home\/ubuntu\/export\/awsresults3.txt/g

vim /data/TEST_PACKAGE/test-2.sql
:%s/\/Users\/angelo\/thesis\/TPC-H\/postgres-run2.txt/\/home\/ubuntu\/export\/awsresults.txt/g
sudo systemctl status postgresql

sudo -u postgres psql
SHOW data_directory;


