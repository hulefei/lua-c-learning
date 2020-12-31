#include <stdio.h>
#include "math/MathFunctions.h"


#include "lualib/lua.h"
#include "lualib/lauxlib.h"
#include "lualib/lualib.h"

void T1(lua_State*);

int main(int argc, char *argv[]) {
//    float value = power(2,2);
//    printf("Hello, World: %f\n", value);

//    for (int i = 0; i < argc; i++) {
//        printf("%s \n", argv[i]);
//    }

    if (argc != 2)
        return -1;

    char* path = argv[1];
    printf("path:%s \n", path);

    int error;

    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    int bRet = luaL_loadfile(L, path);
    lua_pcall(L, 0,0,0);

//    char buff[1000];
//    while (fgets(buff, sizeof(buff), stdin) != NULL) {
//        error = luaL_loadstring(L, buff) || lua_pcall(L, 0,0,0);
//        if (error) {
//            fprintf(stderr, "%s\n", lua_tostring(L, -1));
//            lua_pop(L, 1);
//        }
//    }

//    T1(L);

    lua_close(L);

    return 0;
}

void T1(lua_State *L) {
    lua_pushstring(L, "I am so cool");
    lua_pushnumber(L, 20);

    if (lua_isstring(L, 1)) {
        printf("1: %s", lua_tostring(L, 1));
    }

    if (lua_isstring(L, 2)) {
        printf("2: %d", lua_tointeger(L, 2));
    }
}
