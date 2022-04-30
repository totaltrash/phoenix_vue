export default [
  // {
  //   path: "/",
  //   component: () => import('../views/HelloWorld.vue'),
  //   props: { msg: "Hello Vue 3 + esBuild" },
  // },
  {path: "/", component: () => import('../views/Home.vue')},
  {path: "/about", component: () => import('../views/About.vue')},
]
