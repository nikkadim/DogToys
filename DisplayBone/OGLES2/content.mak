#--------------------------------------------------------------------------
# Name         : content.mak
# Title        : Makefile to build content files
#
# Copyright    : Copyright (C)  Imagination Technologies Limited.
#              : No part of this software, either material or conceptual 
#              : may be copied or distributed, transmitted, transcribed,
#              : stored in a retrieval system or translated into any 
#              : human or computer language in any form by any means,
#              : electronic, mechanical, manual or other-wise, or 
#              : disclosed to third parties without the express written
#              : permission of VideoLogic Limited, Unit 8, HomePark
#              : Industrial Estate, King's Langley, Hertfordshire,
#              : WD4 8LZ, U.K.
#
# Description  : Makefile to build content files for demos in the PowerVR SDK
#
# Platform     :
#
#--------------------------------------------------------------------------

#############################################################################
## Variables
#############################################################################
PVRTEXTOOL 	= ..\..\..\Utilities\PVRTexTool\PVRTexToolCL\Windows_x86_32\PVRTexTool.exe
FILEWRAP 	= ..\..\..\Utilities\Filewrap\Windows_x86_32\Filewrap.exe
PVRUNISCO 	= ..\..\..\Utilities\PVRUniSCo\OGLES\Windows_x86_32\glslcompiler_sgx535.exe

MEDIAPATH = ../Media
CONTENTDIR = Content

#############################################################################
## Instructions
#############################################################################

TEXTURES = 
	

BIN_SHADERS = \
	Shaders/TextureDisplay.vsc \
	Shaders/TextureDisplay.fsc

RESOURCES = \
	$(CONTENTDIR)/TextureDisplayFragShader.cpp \
	$(CONTENTDIR)/TextureDisplayVertShader.cpp

all: resources
	
help:
	@echo Valid targets are:
	@echo resources, textures, binary_shaders, clean
	@echo PVRTEXTOOL, FILEWRAP and PVRUNISCO can be used to override the default paths to these utilities.

clean:
	-rm $(RESOURCES)
	-rm $(BIN_SHADERS)
	-rm $(TEXTURES)

resources: 		$(CONTENTDIR) $(RESOURCES)
textures: 		$(TEXTURES)
binary_shaders:	$(BIN_SHADERS)

$(CONTENTDIR):
	-mkdir $@

$(CONTENTDIR)/TextureDisplayVertShader.cpp: Shaders/TextureDisplay.vsh Shaders/TextureDisplay.vsc
	$(FILEWRAP)  -s  -o $@ Shaders/TextureDisplay.vsh
	-$(FILEWRAP)  -oa $@ Shaders/TextureDisplay.vsc

$(CONTENTDIR)/TextureDisplayFragShader.cpp: Shaders/TextureDisplay.fsh Shaders/TextureDisplay.fsc
	$(FILEWRAP)  -s  -o $@ Shaders/TextureDisplay.fsh
	-$(FILEWRAP)  -oa $@ Shaders/TextureDisplay.fsc

Shaders/TextureDisplay.vsc: Shaders/TextureDisplay.vsh
	$(PVRUNISCO) Shaders/TextureDisplay.vsh $@  -v 

Shaders/TextureDisplay.fsc: Shaders/TextureDisplay.fsh
	$(PVRUNISCO) Shaders/TextureDisplay.fsh $@  -f 

############################################################################
# End of file (content.mak)
############################################################################
