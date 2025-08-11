DEFINES="-DUNIX"
DEFINES="${DEFINES} -DACORN_FTYPE_NFS"
DEFINES="${DEFINES} -DWILD_STOP_AT_DIR"
DEFINES="${DEFINES} -DLARGE_FILE_SUPPORT"
DEFINES="${DEFINES} -DUNICODE_SUPPORT"
DEFINES="${DEFINES} -DUNICODE_WCHAR"
DEFINES="${DEFINES} -DUTF8_MAYBE_NATIVE"
DEFINES="${DEFINES} -DDATE_FORMAT=DF_YMD"
DEFINES="${DEFINES} -DIZ_HAVE_UXUIDGID"
DEFINES="${DEFINES} -DNOMEMCPY"
DEFINES="${DEFINES} -DNO_WORKING_ISPRINT"
DEFINES="${DEFINES} -DNO_LCHMOD"

# Can't build with bzip2 support due to:
# > A bzip2 library built with BZ_NO_STDIO should have an
# > unresolved external, "bz_internal_error".  The default,
# > full-function library will not mention it.
# DEFINES="${DEFINES} -DUSE_BZIP2"


if [[ ${target_platform} = osx-* ]]; then
    DEFINES="${DEFINES} -DBSD"
fi

make -f unix/Makefile CC="$CC" prefix="$PREFIX" LFLAGS1="$LDFLAGS" CF="$CFLAGS -I. $DEFINES" unzips

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR:-}" != "" ]]; then
    make prefix="$PREFIX" -f unix/Makefile check
fi

make prefix="$PREFIX" -f unix/Makefile install
