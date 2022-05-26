#include <stdio.h>

#include "lualib/lua.h"
#include "lualib/lauxlib.h"
#include "lualib/lualib.h"

void T1(lua_State*);
void stackDump(lua_State *L);
int foo(lua_State *L);
int secure_foo(lua_State *L);


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
//    stackDump(L);
    secure_foo(L);


    lua_close(L);

    return 0;
}

void stackDump(lua_State *L) {

    printf("stack Dump:\n");

    int i;
    int top = lua_gettop(L);
    printf("num:%d\n", top);
    for (i = 1; i <=top; i++) {
        int t = lua_type(L, i);
        switch (t) {
            case LUA_TSTRING: {
                printf("'%s'", lua_tostring(L, i));
                break;
            }
            case LUA_TBOOLEAN:{
                printf(lua_toboolean(L, i) ? "true" : "false");
                break;
            }
            case LUA_TNUMBER: {
                printf("%g", lua_tonumber(L, i));
                break;
            }
            default:{
                printf("%s", lua_typename(L, t));
                break;
            }
        }

        printf("  ");
    }
    printf("\n");
}

void T1(lua_State *L) {
    lua_pushstring(L, "I am so cool");
    lua_pushnumber(L, 20);

    if (lua_isstring(L, 1)) {
        printf("1: %s\n", lua_tostring(L, 1));
    }

    if (lua_isstring(L, 2)) {
        printf("2: %td\n", lua_tointeger(L, 2));
    }
}

int foo(lua_State *L) {
    int i = 0.1 / 1;
    return 0;
}

int secure_foo(lua_State *L) {
    lua_pushcfunction(L, foo);

    int result = lua_pcall(L, 0, 0, 0);
    printf("result:%d", result);
    return result;
}
