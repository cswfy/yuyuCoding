<template>
  <!-- <nav>
    <router-link to="/">Home</router-link> |
    <router-link to="/about">About</router-link>
  </nav> -->
  <router-view/>
</template>

<style>

:root{
  --vueColor: #2c3e50;
}

body{
  margin: 0;
}

#app {
    position: relative;
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    width: 100vw;
    min-height: 100vh;
    /* overflow: hidden; */
    background: rgb(240, 240, 245);
    background-image:
        linear-gradient(rgba(150,150,150,.1) 1px, transparent 0),
        linear-gradient(90deg, rgba(150,150,150,.1) 1px, transparent 0);
    background-size: 15px 15px, 15px 15px;

    background-position: top;

    z-index: 0;
}

nav {
  padding: 30px;
}

nav a {
  font-weight: bold;
  color: #2c3e50;
}

nav a.router-link-exact-active {
  color: #42b983;
}
</style>
