include ../common.mk
include ../flags.mk

EXT=tmux
V=3.6b
WRKSRC=${WORK}/${EXT}-$V

all: proj

fetch: ${WORK}/.fetch_done
${WORK}/.fetch_done:
	mkdir -p ${WORK}
	cd ${WORK} && wget -o ${EXT}.tcz.tar.gz \
		https://github.com/tmux/tmux/releases/download/$V/tmux-$V.tar.gz
	touch ${WORK}/.fetch_done

extract: ${WORK}/.extract_done
${WORK}/.extract_done: ${WORK}/.fetch_done
	cd ${WORK} && tar zxvf tmux-$V.tar.gz
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
	rm -rf ${INST}/usr/local/share/man
	install -d ${INST}/usr/local/share/doc/tmux/
	install ${WRKSRC}/COPYING ${INST}/usr/local/share/doc/tmux/
	strip ${INST}/usr/local/bin/tmux
	touch ${WORK}/.install_done

.PHONY: clean
clean:
	rm -rf work
