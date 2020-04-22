.PHONY: build
build:
	sudo docker build -t dbscan_test:1.0 .

.PHONY: run
run:
	xhost + local:root
	sudo docker run -it \
    --network="host" \
	-v $(CURDIR):/home \
	--env=DISPLAY=$(DISPLAY) \
	--env=QT_X11_NO_MITSHM=1 \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	 dbscan_test:1.0 /bin/bash

.PHONY: test
test:
	sudo docker run -it \
	-v $(CURDIR):/home \
	 dbscan_test:1.0 python /home/run_dbscan.py