installdir = /usr/local/bin

all: gp.sh

install: all
	install -D gp.sh $(installdir)/gp

uninstall:
	rm $(installdir)/gp
