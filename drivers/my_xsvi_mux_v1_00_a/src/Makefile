##############################################################################
## Filename:          C:\Users\mt171850\Documents\Pour_etudiant_TP_video\IVK_EDK_Demo\IVK_Repository\MyProcessorIPLib/drivers/my_xsvi_mux_v1_00_a/src/Makefile
## Description:       Microprocessor Driver Makefile
## Date:              Tue Nov 15 17:42:12 2016 (by Create and Import Peripheral Wizard)
##############################################################################

COMPILER=
ARCHIVER=
CP=cp
COMPILER_FLAGS=
EXTRA_COMPILER_FLAGS=
LIB=libxil.a

RELEASEDIR=../../../lib
INCLUDEDIR=../../../include
INCLUDES=-I./. -I${INCLUDEDIR}

INCLUDEFILES=*.h
LIBSOURCES=*.c
OUTS = *.o

libs:
	echo "Compiling my_xsvi_mux"
	$(COMPILER) $(COMPILER_FLAGS) $(EXTRA_COMPILER_FLAGS) $(INCLUDES) $(LIBSOURCES)
	$(ARCHIVER) -r ${RELEASEDIR}/${LIB} ${OUTS}
	make clean

include:
	${CP} $(INCLUDEFILES) $(INCLUDEDIR)

clean:
	rm -rf ${OUTS}
