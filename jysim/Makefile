binary=jy
source=src

.PHONY: all clean

all:
	ocamlbuild $(source)/main.native
	@mv main.native $(binary)


clean:
	rm -rf _build $(binary)
