module.exports = {
  purge: [
    "../elm/src/Main.elm",
    "../html/index.html"
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
    fontFamily: {
      'card': ['Oswald']
    }
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
