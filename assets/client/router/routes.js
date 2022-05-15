export default [
  { path: "/", component: () => import('../views/Home.vue') },
  {
    path: "/courses",
    component: () => import('../views/Courses.vue'),
    children: [
      { path: ':id', component: () => import('../views/CourseDetail.vue')}
    ]
  },
  {
    path: "/modals",
    component: () => import('../views/Modals.vue'),
    children: [
      { path: 'alert', component: () => import('../views/ModalAlert.vue')}
    ]
  },
  { path: "/tables", component: () => import('../views/Tables.vue') },
  { path: "/stores", component: () => import('../views/Stores.vue') },
]
