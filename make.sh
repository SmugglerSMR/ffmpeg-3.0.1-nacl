# #MAIN_MAKEFILE=1
# #include config.mak

# # First, you need to fill in this stuff:
# PEPPER=/home/saduk/nacl_sdk/pepper_49
# PLATFORM=linux
# BINDIR=bin
# BUILD_VARIANT="Release"


# # Locate the stuff we need inside nacl_sdk:
# TOOLCHAIN="${PEPPER}/toolchain/${PLATFORM}_pnacl/${BINDIR}"

# CXX="$TOOLCHAIN/pnacl-clang++"
# LINK="$CXX"
# FINALIZE="$TOOLCHAIN/pnacl-finalize"
# # For other tools, like ar and ranlib, you must also
# # use the pnacl-prefixed ones in this directory

# PPAPI_INCLUDE="$PEPPER/include"
# PPAPI_LIBDIR="$PEPPER/lib/pnacl/$BUILD_VARIANT"

# # And now we can compile:
# $CXX -c -o ffmpeg.o -pthread -I "$PPAPI_INCLUDE" ffmpeg.c

# # Link:
# LIBS="-lppapi_simple -lppapi -lppapi_cpp -lnacl_io"
# $LINK -o minimal_unstripped.bc -pthread -L "$PPAPI_LIBDIR" main.o $LIBS

# # Finalize. This step doesn't have an analogy in regular build procedures.
# # The --help text says "This tool prepares a PNaCl bitcode application for ABI stability."
# $FINALIZE -o minimal.nexe minimal_unstripped.bc

mv ffmpeg ffmpeg.nonfinale.pexe
pnacl-finalize ffmpeg.nonfinale.pexe -o ffmpeg.pexe

pnacl-translate -arch x86-64 ffmpeg.pexe -o ffmpeg_x86_64.nexe
pnacl-translate -arch x86-32 ffmpeg.pexe -o ffmpeg_x86_32.nexe
pnacl-translate -arch arm ffmpeg.pexe -o ffmpeg_arm.nexe

cp ffmpeg.pexe /home/smuggler/nacl_sdk/pepper_49/projects/recorder/pnacl/Release/ffmpeg.pexe

cp ffmpeg_x86_64.nexe /home/smuggler/nacl_sdk/pepper_49/projects/recorder_1/pnacl/Release/ffmpeg-x86-64.nexe
cp ffmpeg_x86_32.nexe /home/smuggler/nacl_sdk/pepper_49/projects/recorder_1/pnacl/Release/ffmpeg-x86-32.nexe
cp ffmpeg_arm.nexe /home/smuggler/nacl_sdk/pepper_49/projects/recorder_1/pnacl/Release/ffmpeg-arm.nexe
