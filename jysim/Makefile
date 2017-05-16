binary=jy
source=src
pkgs=cryptokit

.PHONY: all clean

all:
	ocamlbuild $(source)/main.native -package $(pkgs)
	@mv main.native $(binary)


clean:
	rm -rf _build $(binary)
