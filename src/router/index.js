import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";
import ViewView from "../views/ViewView.vue";
import UserView from "../views/UserView.vue";

const routes = [
  {
    path: "/",
    name: "home",
    component: HomeView,
  },
  {
    path: "/view",
    name: "view",
    component: ViewView,
  },
  {
    path: "/user",
    name: "user",
    component: UserView,
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
