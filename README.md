# Procedure to execute run_dbscan.py
1. Build docker image
```
git clone https://github.com/yuki-inaho/dbscan_elapsed_test.git
cd dbscan_elapsed_test
make build
```

2. Run docker image 
```
make run
```

3. (In docker container) Execute run_dbscan.py
```
python /home/run_dbscan.py
```
