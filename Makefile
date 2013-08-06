SOURCES = main.vala app.vala page.vala js/app.vala util.vala
VALAFLAGS = --pkg gio-2.0 \
	  --pkg webkitgtk-3.0 \
	  --pkg javascriptcore \
	  --target-glib=2.32 \
	  --thread \
	  --vapidir=./vapi

XFLAGS = -X -I/usr/include/webkitgtk-3.0

all: hello

hello: 
	valac $(VALAFLAGS) --header=hello.h --vapi=hello.vapi $(XFLAGS) $(SOURCES) -o hello

clean:
	rm -rf *.vapi *.h hello
