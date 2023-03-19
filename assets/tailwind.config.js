// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex'
  ],
  theme: {
    extend: {
      keyframes: {
        fadein: {
          '0%': { transform: 'translateY(0px) scaleY(0)' },
          '100%': { transform: 'translateY(0px) scaleY(1)' },
        },
        fadeout: {
          '0%': { transform: 'translateY(0px) scale(1)' },
          '100%': { transform: 'translateY(0px) scale(0)' },
        },
        wiggle: {
          '0%': { transform: 'translateY(0px) scale(1,1)' },
          '25%': { transform: 'translateY(-4px) scale(1.05,1.05)', background: 'aquamarine' },
          '100%': { transform: 'translateY(0px) scale(1,1)' },
        }
      },
      animation: {
        fadein: 'fadein 0.6s linear 1 forwards',
        fadeout: 'fadeout 0.6s linear 1 forwards',
        wiggle: 'wiggle 0.5s linear 1 forwards',
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms')
  ]
}
