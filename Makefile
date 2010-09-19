# raw makefile
# - ease repeatitive operations

all: upload

PWD		:= $(shell pwd)
DESTDIR		:= /home/jerome/webwork/www.jetienne.com.gh-pages


monitor: build
	(while inotifywait -r -e modify,attrib,create . ; do make build; done)

server:
	lighttpd -f lighttpd.conf  -D

upload: build
	(cd $(DESTDIR) && git add . && git commit -a -m 'new build' && git push origin gh-pages)

build:
	(cd $(DESTDIR) && git reset --hard origin/gh-pages)
	cp -a * $(DESTDIR)
	
