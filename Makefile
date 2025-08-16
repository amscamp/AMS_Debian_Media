
default: create-iso cleanup create-iso-dev

create-iso:
	./create_iso.sh

create-iso-dev:
	./create_iso.sh dev

cleanup:
	sudo rm -rf iso *.iso isohdpfx.bin