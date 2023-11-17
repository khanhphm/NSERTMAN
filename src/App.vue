<template>
  <v-app>
    <v-app-bar rounded color="primary">
      <v-avatar class="hidden-sm-and-down ma-5" color="grey-darken-1" size="40">
        <v-img
          cover
          src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkkWiMU5x4idX917TN2KOXvgoItjdnrzkqYilMjYIb-lb6DXt_F76JZT-w1i7Z0KEUAnE&usqp=CAU"
        ></v-img>
      </v-avatar>

      <v-tabs class="ml-8">
        <v-tab to="/">Home</v-tab>
        <v-tab to="/view">View</v-tab>
        <v-tab to="/user">User</v-tab>
      </v-tabs>
      <template v-slot:append>
        <ConnectMetamask />
      </template>
    </v-app-bar>
    <v-main>
      <router-view />
    </v-main>
  </v-app>
</template>

<script setup>
import ConnectMetamask from "./components/ConnectMetamask.vue";
</script>
