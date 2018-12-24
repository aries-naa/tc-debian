#netboot_bs_kernel_path_1=/var/autofs/cifs-alex/s75ris11:s-alex@chel.cbr.ru/REMINST/ts/tc
#netboot_gu_kernel_path_1=/var/autofs/cifs-alex/s75ris01:s-alex@chel.cbr.ru/REMINST/ts/tc

netboot_bs_kernel_path_2=/var/autofs/cifs-alex/s75ris11:s-alex@chel.cbr.ru/REMINST/ts/shipka
netboot_gu_kernel_path_2=/var/autofs/cifs-alex/s75ris01:s-alex@chel.cbr.ru/REMINST/ts/shipka

netboot_bs_kernel_path=$(netboot_bs_kernel_path_2)
netboot_gu_kernel_path=$(netboot_gu_kernel_path_2)

all:
	echo "make build | initrd | install | clean"

build:
	/bin/sh -c ". ./rules; config; build_image"

initrd:
	sudo /bin/sh -c ". ./rules; config; build_initrd"
	sudo chown -R alex:users build

test:
	/bin/sh -c ". ./rules; config; test_image"

install: install-bs install-gu

install-bs:
	cp -p build/vmlinuz $(netboot_bs_kernel_path)
	cp -p build/vmlinuz $(netboot_gu_kernel_path)
	cp -p build/initrd $(netboot_bs_kernel_path)
	cp -p build/initrd $(netboot_gu_kernel_path)

install-gu:

clean:
	/bin/sh -c ". ./rules; config; clean"
	if [ -d build ]; then sudo rm -rf build; fi
	if [ -d tc ]; then sudo rm -rf tc; fi
	if [ -f tc.fake ]; then sudo rm -f tc.fake; fi
