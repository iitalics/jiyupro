binary=jy
source=src
pkgs=cryptokit,getopt

.PHONY: all clean

all:
	ocamlbuild $(source)/main.native -pkgs $(pkgs)
	@mv main.native $(binary)


clean:
	rm -rf _build $(binary)
