#include <stdio.h>
#include "math/MathFunctions.h"


#include "lualib/lua.h"
#include "lualib/lauxlib.h"
#include "lualib/lualib.h"

int main() {
    float value = power(2,2);

    printf("Hello, World: %f\n", value);

    int error;

    lua_State *L = luaL_newstate();

//    int bRet = luaL_loadfile(L, "hello.lua");
    luaL_openlibs(L);

    char buff[1000];
    while (fgets(buff, sizeof(buff), stdin) != NULL) {
        error = luaL_loadstring(L, buff) || lua_pcall(L, 0,0,0);
        if (error) {
            fprintf(stderr, "%s\n", lua_tostring(L, -1));
            lua_pop(L, 1);
        }
    }

    lua_close(L);

    return 0;
}
