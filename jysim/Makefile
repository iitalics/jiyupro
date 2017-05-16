binary=jy

.PHONY: all clean

all:
	ocamlbuild main.native
	@mv main.native $(binary)


clean:
	rm -rf _build $(binary)
