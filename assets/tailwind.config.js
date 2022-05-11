module.exports = {
  content: [
    './js/**/*.js',
    './client/**/*.vue',
    '../lib/*_web/**/*.*ex'
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
