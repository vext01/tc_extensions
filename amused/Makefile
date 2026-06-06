include ../common.mk
include ../flags.mk

EXT=amused
V=0.19
WRKSRC=${WORK}/amused-$V

all: ${WORK}/.proj_done

clone: ${WORK}/.clone_done
${WORK}/.clone_done:
	git clone -b$V https://github.com/omar-polo/amused/ ${WRKSRC}
	touch ${WORK}/.clone_done

configure: ${WORK}/.configure_done
${WORK}/.configure_done: ${WORK}/.clone_done
	cd ${WRKSRC} && CFLAGS=${CFLAGS} ./configure --without-web
	touch ${WORK}/.configure_done

build: ${WORK}/.build_done
${WORK}/.build_done: ${WORK}/.configure_done
	cd ${WRKSRC} && make -j $(nproc)
	touch ${WORK}/.build_done

install: ${WORK}/.install_done
${WORK}/.install_done: ${WORK}/.build_done
	cd ${WRKSRC} && make install DESTDIR=${INST}
	rm -rf ${INST}/usr/local/man/
	chmod u+w ${INST}/usr/local/bin/amused
	strip ${INST}/usr/local/bin/amused
	touch ${WORK}/.install_done

.PHONY: clean
clean:
	rm -rf work
