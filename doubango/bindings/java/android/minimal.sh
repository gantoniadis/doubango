#!/bin/bash
# Build tinyWRAP for Google Android Systems

# Minimal parameters
export MINIMAL_PARAMS="FFMPEG=no H264=no THEORA=no OPENCORE_AMR=no SPEEX_DSP=yes SPEEX_JB=yes SPEEX_RESAMPLER=yes SPEEX_DENOISE=no SPEEX=no ILBC=no LIBGSM=no G729=no"
export _BT=static

for IS_NEON in no yes
do
	for project in tinySAK tinyNET tinyHTTP tinyXCAP tinyIPSec tinySMS tinySIGCOMP tinySDP tinyRTP tinyMSRP tinyMEDIA tinyDAV tinySIP
	#for project in tinyDAV
	do
		echo -e building "$project with parameters: $@ NEON=$IS_NEON $MINIMAL_PARAMS\n"
		make PROJECT=$project clean
		make PROJECT=$project BT=$_BT $@ NEON=$IS_NEON $MINIMAL_PARAMS all
	done

	echo building tinyWRAP....
	make PROJECT=tinyWRAP clean
	make PROJECT=tinyWRAP BT=shared LT=$_BT $@ NEON=$IS_NEON $MINIMAL_PARAMS all
done