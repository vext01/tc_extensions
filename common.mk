PWD=$(shell pwd)
WORK=${PWD}/work
INST=${WORK}/inst
PROJ=${WORK}/proj

proj: ${WORK}/.proj_done
${WORK}/.proj_done: ${WORK}/.install_done
	mkdir -p ${PROJ}
	cd ${PROJ} && mksquashfs ${INST} ${EXT}.tcz
	cp ${EXT}.tcz.info ${PROJ}/${EXT}.tcz.info
	if [ -e ${EXT}.tcz.dep ]; then cp ${EXT}.tcz.dep ${PROJ}; fi
	if [ -e ${EXT}.tcz.build-dep ]; then cp ${EXT}.tcz.build-dep ${PROJ}; fi
	if [ -e ${EXT}.tcz.tar.gz ]; then cp ${EXT}.tcz.tar.gz ${PROJ}; fi
	echo "Compiled using https://github.com/vext01/tc_extensions" > ${PROJ}/compile_${EXT}
	touch ${WORK}/.proj_done


${WORK}/.submitqc_clone_done:
	mkdir -p ${WORK}
	cd ${WORK} && git clone https://github.com/tinycorelinux/submitqc
	touch ${WORK}/.submitqc_clone_done

qc: ${WORK}/.submitqc_clone_done ${WORK}/.proj_done
	cd ${PROJ} && sh ${WORK}/submitqc/submitqc --libs

clean-proj:
	rm -rf ${WORK}/proj ${WORK}/.proj_done
