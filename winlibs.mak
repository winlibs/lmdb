!IFNDEF VERSION
VERSION=unknown
!ENDIF
OUTPUT=$(MAKEDIR)\..\liblmdb-$(VERSION)-$(PHP_SDK_VS)-$(PHP_SDK_ARCH)
ARCHIVE=$(OUTPUT).zip

all:
	git checkout .
	git clean -fdx

	-rmdir /s /q $(OUTPUT)

	cd libraries\liblmdb
	nmake /f Makefile.vc
	xcopy *.exe $(OUTPUT)\bin\*
	xcopy liblmdb_a.* $(OUTPUT)\lib\*

	nmake/f Makefile.vc clean
	nmake /f Makefile.vc /d DEBUG=1
	xcopy liblmdb_a_debug.* $(OUTPUT)\lib\*

	xcopy lmdb.h $(OUTPUT)\include\*

	del $(ARCHIVE)
	7za a $(ARCHIVE) $(OUTPUT)\*
