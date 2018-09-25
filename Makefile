.PHONY: all dbglib dbgapp rellib relapp clean docs stats wc
all: dbglib dbgapp

# Build setup
CC = clang
AR = ar

# Compiler flags
C_FLAGS = -std=c++11 -Wall -pedantic
dbg: C_FLAGS += -O0 -fno-omit-frame-pointer -g -DDEBUG
rel: C_FLAGS += -O3
LIB_C_FLAGS = -Isrc/termite
APP_C_FLAGS = -Isrc/examples/basic
dbg: LIB_C_FLAGS += -MMD -MF $(LIB_DBG_DEP_DIR)/$*.d
rel: LIB_C_FLAGS += -MMD -MF $(LIB_REL_DEP_DIR)/$*.d
dbg: APP_C_FLAGS += -MMD -MF $(APP_DBG_DEP_DIR)/$*.d
rel: APP_C_FLAGS += -MMD -MF $(APP_REL_DEP_DIR)/$*.d

# Linker flags
APP_L_FLAGS = -std=c++11 -Wall -pedantic -lstdc++ -lpthread -lncurses -ltermite
dbg: APP_L_FLAGS += -O0 -g -Wl,--no-as-needed -lSegFault
rel: APP_L_FLAGS += -O3

# Directories (annoying amount of copy-paste here due to make's / my inability
# to use target-specific variables as pre-requisites).
# TODO: Just rewrite this whole thing, it hasn't scaled anywhere near as nicely
# as I first envisaged.
LIB_SRC_DIR = src/termite
LIB_DBG_DIR = dbg/termite
LIB_REL_DIR = rel/termite
LIB_SRC_FILES = $(shell find $(LIB_SRC_DIR) -type f -name '*.cpp')
LIB_SRC_SUBDIRS := $(shell find $(LIB_SRC_DIR) -mindepth 1 -type d)
LIB_DBG_OBJ_DIR = $(LIB_DBG_DIR)/obj
LIB_REL_OBJ_DIR = $(LIB_REL_DIR)/obj
LIB_DBG_DEP_DIR = $(LIB_DBG_DIR)/dep
LIB_REL_DEP_DIR = $(LIB_REL_DIR)/dep
LIB_DBG_OBJ_FILES = $(patsubst $(LIB_SRC_DIR)/%.cpp, $(LIB_DBG_OBJ_DIR)/%.o, $(LIB_SRC_FILES))
LIB_REL_OBJ_FILES = $(patsubst $(LIB_SRC_DIR)/%.cpp, $(LIB_REL_OBJ_DIR)/%.o, $(LIB_SRC_FILES))
LIB_DBG_DEP_FILES = $(patsubst $(LIB_SRC_DIR)/%.cpp, $(LIB_DBG_DEP_DIR)/%.d, $(LIB_SRC_FILES))
LIB_REL_DEP_FILES = $(patsubst $(LIB_SRC_DIR)/%.cpp, $(LIB_REL_DEP_DIR)/%.d, $(LIB_SRC_FILES))
LIB_DBG_OBJ_SUBDIRS = $(patsubst $(LIB_SRC_DIR)/%, $(LIB_DBG_OBJ_DIR)/%, $(LIB_SRC_SUBDIRS))
LIB_REL_OBJ_SUBDIRS = $(patsubst $(LIB_SRC_DIR)/%, $(LIB_REL_OBJ_DIR)/%, $(LIB_SRC_SUBDIRS))
LIB_DBG_DEP_SUBDIRS = $(patsubst $(LIB_SRC_DIR)/%, $(LIB_DBG_DEP_DIR)/%, $(LIB_SRC_SUBDIRS))
LIB_REL_DEP_SUBDIRS = $(patsubst $(LIB_SRC_DIR)/%, $(LIB_REL_DEP_DIR)/%, $(LIB_SRC_SUBDIRS))

APP_SRC_DIR = src/examples/basic
APP_DBG_DIR = dbg/examples/basic
APP_REL_DIR = rel/examples/basic
APP_SRC_FILES = $(shell find $(APP_SRC_DIR) -type f -name '*.cpp')
APP_SRC_SUBDIRS := $(shell find $(APP_SRC_DIR) -mindepth 1 -type d)
APP_DBG_OBJ_DIR = $(APP_DBG_DIR)/obj
APP_REL_OBJ_DIR = $(APP_REL_DIR)/obj
APP_DBG_DEP_DIR = $(APP_DBG_DIR)/dep
APP_REL_DEP_DIR = $(APP_REL_DIR)/dep
APP_DBG_OBJ_FILES = $(patsubst $(APP_SRC_DIR)/%.cpp, $(APP_DBG_OBJ_DIR)/%.o, $(APP_SRC_FILES))
APP_REL_OBJ_FILES = $(patsubst $(APP_SRC_DIR)/%.cpp, $(APP_REL_OBJ_DIR)/%.o, $(APP_SRC_FILES))
APP_DBG_DEP_FILES = $(patsubst $(APP_SRC_DIR)/%.cpp, $(APP_DBG_DEP_DIR)/%.d, $(APP_SRC_FILES))
APP_REL_DEP_FILES = $(patsubst $(APP_SRC_DIR)/%.cpp, $(APP_REL_DEP_DIR)/%.d, $(APP_SRC_FILES))
APP_DBG_OBJ_SUBDIRS = $(patsubst $(APP_SRC_DIR)/%, $(APP_DBG_OBJ_DIR)/%, $(APP_SRC_SUBDIRS))
APP_REL_OBJ_SUBDIRS = $(patsubst $(APP_SRC_DIR)/%, $(APP_REL_OBJ_DIR)/%, $(APP_SRC_SUBDIRS))
APP_DBG_DEP_SUBDIRS = $(patsubst $(APP_SRC_DIR)/%, $(APP_DBG_DEP_DIR)/%, $(APP_SRC_SUBDIRS))
APP_REL_DEP_SUBDIRS = $(patsubst $(APP_SRC_DIR)/%, $(APP_REL_DEP_DIR)/%, $(APP_SRC_SUBDIRS))


# Real targets
$(LIB_DBG_OBJ_DIR)/%.o $(LIB_REL_OBJ_DIR)/%.o: $(LIB_SRC_DIR)/%.cpp
	$(CC) $(C_FLAGS) $(LIB_C_FLAGS) -c -o $@ $<

$(LIB_DBG_DIR)/libtermite.a: $(LIB_DBG_OBJ_FILES)
	$(AR) rc $@ $^

$(LIB_REL_DIR)/libtermite.a: $(LIB_REL_OBJ_FILES)
	$(AR) rc $@ $^

$(APP_DBG_OBJ_DIR)/%.o $(APP_REL_OBJ_DIR)/%.o: $(APP_SRC_DIR)/%.cpp
	$(CC) $(C_FLAGS) $(APP_C_FLAGS) -c -o $@ $<

$(APP_DBG_DIR)/basic: $(APP_DBG_OBJ_FILES)
	$(CC) -L$(LIB_DBG_DIR) $(APP_L_FLAGS) -o $@ $^

$(APP_REL_DIR)/basic: $(APP_REL_OBJ_FILES)
	$(CC) -L$(LIB_REL_DIR) $(APP_L_FLAGS) -o $@ $^

$(LIB_DBG_OBJ_DIR)     $(LIB_REL_OBJ_DIR) \
$(LIB_DBG_OBJ_SUBDIRS) $(LIB_REL_OBJ_SUBDIRS) \
$(LIB_DBG_DEP_DIR)     $(LIB_REL_DEP_DIR) \
$(LIB_DBG_DEP_SUBDIRS) $(LIB_REL_DEP_SUBDIRS) \
$(APP_DBG_OBJ_DIR)     $(APP_REL_OBJ_DIR) \
$(APP_DBG_OBJ_SUBDIRS) $(APP_REL_OBJ_SUBDIRS) \
$(APP_DBG_DEP_DIR)     $(APP_REL_DEP_DIR) \
$(APP_DBG_DEP_SUBDIRS) $(APP_REL_DEP_SUBDIRS):
	@mkdir -p $@


# .PHONY targets
dbglib: $(LIB_DBG_OBJ_DIR) $(LIB_DBG_OBJ_SUBDIRS) \
        $(LIB_DBG_DEP_DIR) $(LIB_DBG_DEP_SUBDIRS) \
        $(LIB_DBG_DIR)     $(LIB_DBG_DIR)/libtermite.a

rellib: $(LIB_REL_OBJ_DIR) $(LIB_REL_OBJ_SUBDIRS) \
        $(LIB_REL_DEP_DIR) $(LIB_REL_DEP_SUBDIRS) \
        $(LIB_REL_DIR)     $(LIB_REL_DIR)/libtermite.a

dbgapp: dbglib \
        $(APP_DBG_OBJ_DIR) $(APP_DBG_OBJ_SUBDIRS) \
        $(APP_DBG_DEP_DIR) $(APP_DBG_DEP_SUBDIRS) \
        $(APP_DBG_DIR)     $(APP_DBG_DIR)/basic

relapp: rellib \
        $(APP_REL_OBJ_DIR) $(APP_REL_OBJ_SUBDIRS) \
        $(APP_REL_DEP_DIR) $(APP_REL_DEP_SUBDIRS) \
        $(APP_REL_DIR)     $(APP_REL_DIR)/basic

clean:
	rm -rf $(LIB_DBG_DIR) $(LIB_REL_DIR) $(APP_DBG_DIR) $(APP_REL_DIR) docs stats

docs: doxygen.cfg
	doxygen $^

stats:
	gitstats . stats

wc:
	find $(LIB_SRC_DIR) -type f -print0 -name '*.cpp' -o -name '*.h' | wcz


# Include auto-generated dependency graph (must be final line)
-include $(LIB_DBG_DEP_FILES) $(APP_DBG_DEP_FILES) $(LIB_REL_DEP_FILES) $(APP_REL_DEP_FILES)