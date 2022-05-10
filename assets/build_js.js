const esbuild = require('esbuild')

const watch = !!process.env.ESBUILD_WATCH

const promise = esbuild.build({
  entryPoints: ['js/public.js', 'js/app.js'],
  bundle: true,
  target: 'es2016',
  plugins: [],
  outdir: '../priv/static/assets/js',
  logLevel: process.env.ESBUILD_LOG_LEVEL || 'silent',
  watch,
  splitting: true,
  format: 'esm',
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