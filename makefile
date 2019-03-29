#=====[ Basic makefile ]=====
.SUFFIXES : .cpp .c .h .o

#============================
# Below are custom vars. Modify to suit the project.
# - PROJECT is the name of the output executable.
# - BUILD is the dir where objects and intermediate files will be stored.
# - INCLUDES is a list of external dirs that contain header files.
#
# There's also some system vars you may need to set.
# - RM is your platform's delete command. Unix = rm, DOS = del.
#============================

# PROJECT VARS
PROJECT		:= clang_test
SOURCE		:= src 
BUILD 		:= build
INCLUDES	:= includes

# SYSTEM VARS
RM			:= del /S /F /Q

#============================
# End config.
# Now the magic begins!
#============================

# File Vars
EXENAME		= $(addsuffix .exe,$(PROJECT))
CFILES  	= $(wildcard *.c)
CPPFILES 	= $(wildcard *.cpp)
HFILES		= $(wildcard */*.h) $(wildcard *.h)
HPPFILES	= $(wildcard */*.hpp) $(wildcard *.hpp)
COBJECTS    = $(CFILES:%.c=$(BUILD)/%.o)
CPPOBJECTS 	= $(CPPFILES:%.cpp=$(BUILD)/%.o)
			  
# Compilers, flags, etc.
CC 			= clang
CXX 		= clang++
IFLAGS		= $(foreach dir,$(INCLUDES),-I$(dir))
CFLAGS 		= -Wall -g $(IFLAGS)
CXXFLAGS 	= -Wall -g $(IFLAGS)

# Object Targets
$(EXENAME): $(COBJECTS) $(CPPOBJECTS)
	$(CXX) $(CXXFLAGS) -o $(EXENAME) $(COBJECTS) $(CPPOBJECTS)
	@echo ====[Done Building!]====

$(BUILD)/%.o: %.cpp $(HFILES) $(HPPFILES) | $(BUILD)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD)/%.o: %.c $(HFILES) | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD):
	mkdir $@

# Phony Targets
clean:
	@echo ====[Now Cleaning...]====
	@$(RM) $(wildcard *.exe) $(BUILD)
	@echo ====[Done Cleaning!]====

new: clean $(EXENAME)

.PHONY : new clean

#============================
# End makefile. :)
#============================