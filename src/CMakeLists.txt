cmake_minimum_required(VERSION 3.13 FATAL_ERROR)
project(cmake-cefi VERSION 1.0 LANGUAGES C CXX)

# We have to call lld-link directly. If we link with clang, we get lots of rpath
# and dynamic linking parameters from Nix.
set(CMAKE_LINKER "lld-link")
set(CMAKE_C_LINK_EXECUTABLE "<CMAKE_LINKER> <FLAGS> <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> /out:<TARGET> <LINK_LIBRARIES>")

find_package(PkgConfig REQUIRED)
pkg_check_modules (CEFI REQUIRED c-efi)

add_executable(cmake-cefi main.c)

target_include_directories(cmake-cefi PRIVATE ${CEFI_INCLUDE_DIRS})
target_compile_options(cmake-cefi PRIVATE -target x86_64-unknown-windows -fno-stack-protector -ffreestanding -fshort-wchar -mno-red-zone -mno-mmx -mno-sse)

# XXX We actually want to write this:
#target_link_options(cmake-cefi PRIVATE -target x86_64-unknown-windows -fuse-ld=lld-link -Wl,-entry:efi_main -Wl,-subsystem:efi_application)
target_link_options(cmake-cefi PRIVATE -entry:efi_main -subsystem:efi_application)

install(TARGETS cmake-cefi
  RUNTIME DESTINATION bin)
