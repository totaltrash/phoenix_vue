// copied/adapted from https://github.com/smpallen99/phx_vue3/blob/main/assets/build.js

const esbuild = require('esbuild')
const pluginVue = require('esbuild-plugin-vue-next')
// Looks like it requires Node 18
// const copyStaticFiles = require('esbuild-copy-static-files')

const bundle = true
const logLevel = process.env.ESBUILD_LOG_LEVEL || 'silent'
const watch = !!process.env.ESBUILD_WATCH

// support dynamic imports in Vue.
const splitting = true
const format = 'esm'

const plugins = [
  pluginVue(),
  // copyStaticFiles({
  //   src: 'client/assets',
  //   dest: '../priv/static/images',
  //   dereference: true,
  //   errorOnExist: false,
  //   preserveTimestamps: true,
  //   recursive: true,
  // })
]

// possible split the static site js build to a separate build file?
const promise = esbuild.build({
  entryPoints: ['js/public.js', 'js/app.js', 'client/main.js'],
  bundle,
  define: {__VUE_OPTIONS_API__: true, __VUE_PROD_DEVTOOLS__: false},
  target: 'es2016',
  plugins,
  outdir: '../priv/static/assets',
  logLevel,
  watch,
  splitting,
  format,
  // Not sure how to handle the Elixir esbuild externals yet.
  external: [
    '/images/*'
  ]
})

if (watch) {
  promise.then(_result => {
    process.stdin.on('close', () => {
      process.exit(0)
    })

    process.stdin.resume()
  })
}