import Vue from "vue";
import VueRouter from "vue-router";
import shortcutHome from "../components/shortcut/shortcutHome.vue";

Vue.use(VueRouter);

const routes = [
  { path: "/shortcuts", name: "shortcutHome", component: shortcutHome }
];

export default new VueRouter({ mode: "history", routes });
