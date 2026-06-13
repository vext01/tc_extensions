include ../common.mk
include ../flags.mk

EXT=gmid
V=2.1.1
WRKSRC=${WORK}/${EXT}-$V

all: proj

fetch: ${WORK}/.fetch_done
${WORK}/.fetch_done:
	mkdir -p ${WORK}
	cd ${WORK} && wget https://ftp.omarpolo.com/${EXT}-${V}.tar.gz
	ln -sf ${WORK}/${EXT}-${V}.tar.gz ${WORK}/${EXT}.tcz.tar.gz
	touch ${WORK}/.fetch_done

extract: ${WORK}/.extract_done
${WORK}/.extract_done: ${WORK}/.fetch_done
	cd ${WORK} && tar zxvf ${EXT}-$V.tar.gz
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
	install -d ${INST}/usr/local/share/doc/${EXT}/
	install ${WRKSRC}/LICENSE ${INST}/usr/local/share/doc/${EXT}/
	chmod u+w ${INST}/usr/local/bin/*
	strip ${INST}/usr/local/bin/*
	touch ${WORK}/.install_done

.PHONY: clean
clean:
	rm -rf work
