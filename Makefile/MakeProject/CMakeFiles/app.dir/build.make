# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/silin/Dropbox/linux/Makefile/MakeProject

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/silin/Dropbox/linux/Makefile/MakeProject

# Include any dependencies generated for this target.
include CMakeFiles/app.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/app.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/app.dir/flags.make

CMakeFiles/app.dir/app.cpp.o: CMakeFiles/app.dir/flags.make
CMakeFiles/app.dir/app.cpp.o: app.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/silin/Dropbox/linux/Makefile/MakeProject/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/app.dir/app.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/app.dir/app.cpp.o -c /home/silin/Dropbox/linux/Makefile/MakeProject/app.cpp

CMakeFiles/app.dir/app.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/app.dir/app.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/silin/Dropbox/linux/Makefile/MakeProject/app.cpp > CMakeFiles/app.dir/app.cpp.i

CMakeFiles/app.dir/app.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/app.dir/app.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/silin/Dropbox/linux/Makefile/MakeProject/app.cpp -o CMakeFiles/app.dir/app.cpp.s

CMakeFiles/app.dir/app.cpp.o.requires:

.PHONY : CMakeFiles/app.dir/app.cpp.o.requires

CMakeFiles/app.dir/app.cpp.o.provides: CMakeFiles/app.dir/app.cpp.o.requires
	$(MAKE) -f CMakeFiles/app.dir/build.make CMakeFiles/app.dir/app.cpp.o.provides.build
.PHONY : CMakeFiles/app.dir/app.cpp.o.provides

CMakeFiles/app.dir/app.cpp.o.provides.build: CMakeFiles/app.dir/app.cpp.o


CMakeFiles/app.dir/myadd.cpp.o: CMakeFiles/app.dir/flags.make
CMakeFiles/app.dir/myadd.cpp.o: myadd.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/silin/Dropbox/linux/Makefile/MakeProject/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/app.dir/myadd.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/app.dir/myadd.cpp.o -c /home/silin/Dropbox/linux/Makefile/MakeProject/myadd.cpp

CMakeFiles/app.dir/myadd.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/app.dir/myadd.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/silin/Dropbox/linux/Makefile/MakeProject/myadd.cpp > CMakeFiles/app.dir/myadd.cpp.i

CMakeFiles/app.dir/myadd.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/app.dir/myadd.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/silin/Dropbox/linux/Makefile/MakeProject/myadd.cpp -o CMakeFiles/app.dir/myadd.cpp.s

CMakeFiles/app.dir/myadd.cpp.o.requires:

.PHONY : CMakeFiles/app.dir/myadd.cpp.o.requires

CMakeFiles/app.dir/myadd.cpp.o.provides: CMakeFiles/app.dir/myadd.cpp.o.requires
	$(MAKE) -f CMakeFiles/app.dir/build.make CMakeFiles/app.dir/myadd.cpp.o.provides.build
.PHONY : CMakeFiles/app.dir/myadd.cpp.o.provides

CMakeFiles/app.dir/myadd.cpp.o.provides.build: CMakeFiles/app.dir/myadd.cpp.o


# Object files for target app
app_OBJECTS = \
"CMakeFiles/app.dir/app.cpp.o" \
"CMakeFiles/app.dir/myadd.cpp.o"

# External object files for target app
app_EXTERNAL_OBJECTS =

app: CMakeFiles/app.dir/app.cpp.o
app: CMakeFiles/app.dir/myadd.cpp.o
app: CMakeFiles/app.dir/build.make
app: libutil.a
app: CMakeFiles/app.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/silin/Dropbox/linux/Makefile/MakeProject/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable app"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/app.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/app.dir/build: app

.PHONY : CMakeFiles/app.dir/build

CMakeFiles/app.dir/requires: CMakeFiles/app.dir/app.cpp.o.requires
CMakeFiles/app.dir/requires: CMakeFiles/app.dir/myadd.cpp.o.requires

.PHONY : CMakeFiles/app.dir/requires

CMakeFiles/app.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/app.dir/cmake_clean.cmake
.PHONY : CMakeFiles/app.dir/clean

CMakeFiles/app.dir/depend:
	cd /home/silin/Dropbox/linux/Makefile/MakeProject && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/silin/Dropbox/linux/Makefile/MakeProject /home/silin/Dropbox/linux/Makefile/MakeProject /home/silin/Dropbox/linux/Makefile/MakeProject /home/silin/Dropbox/linux/Makefile/MakeProject /home/silin/Dropbox/linux/Makefile/MakeProject/CMakeFiles/app.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/app.dir/depend
