import { defineStore } from 'pinia'

// useStore could be anything like useUser, useCart
// the first argument is a unique id of the store across your application
export const useStore = defineStore('main', {
  state: () => ({
    posts: [
      {id: 123, title: "Some Post!"},
      {id: 124, title: "Another Post!"},
    ],
  }),
  // getters: {
  //   doubleCount: (state) => state.counter * 2,
  // },
})
