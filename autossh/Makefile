include ../common.mk
include ../flags.mk

EXT=autossh
V=1.4g
WRKSRC=${WORK}/${EXT}-$V

all: proj

fetch: ${WORK}/.fetch_done
${WORK}/.fetch_done:
	mkdir -p ${WORK}
	cd ${WORK} && wget https://www.harding.motd.ca/${EXT}/${EXT}-${V}.tgz
	ln -sf ${WORK}/${EXT}-${V}.tgz ${WORK}/${EXT}.tcz.tgz
	touch ${WORK}/.fetch_done

extract: ${WORK}/.extract_done
${WORK}/.extract_done: ${WORK}/.fetch_done
	cd ${WORK} && tar zxvf ${EXT}-${V}.tgz
	touch ${WORK}/.extract_done

configure: ${WORK}/.configure_done
${WORK}/.configure_done: ${WORK}/.extract_done
	cd ${WRKSRC} && LDFLAGS=${LDFLAGS} CFLAGS=${CFLAGS} ./configure
	touch ${WORK}/.configure_done

build: ${WORK}/.build_done
${WORK}/.build_done: ${WORK}/.configure_done
	cd ${WRKSRC} && make -j ${MAKE_JOBS}
	touch ${WORK}/.build_done

install: ${WORK}/.install_done
${WORK}/.install_done: ${WORK}/.build_done
	cd ${WRKSRC} && make install DESTDIR=${INST}
	rm -rf ${INST}/usr/local/man
	rm -rf ${INST}/usr/local/share
	strip ${INST}/usr/local/bin/autossh
	touch ${WORK}/.install_done

.PHONY: clean
clean:
	rm -rf work
