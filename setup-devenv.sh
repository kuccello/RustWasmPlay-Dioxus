#!/bin/sh

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=linux;;
    Darwin*)    machine=macos;;
    # CYGWIN*)    machine=Cygwin;;
    # MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
# echo ${machine}

echo "Architecture: $(uname -m)"
architecture=""
case $(uname -m) in
    x86_64) architecture="x64" ;;
    arm64)  architecture="arm64" ;;
    arm)    architecture="arm" ;;
esac

## Get and setup tailwind without needing node
echo "Getting Tailwind util tool from: https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-$machine-$architecture"
curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-$machine-$architecture
chmod +x tailwindcss-$machine-$architecture
mv tailwindcss-$machine-$architecture tailwindcss
echo "...done"

echo "Creating base global.css..."
cat > ./global.css <<DELIM
@tailwind base;
@tailwind components;
@tailwind utilities;
DELIM
echo "...done"

echo "Creating tailwind.config.js..."
cat > ./tailwind.config.js <<DELIM
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{rs,html,js}"
  ],
  safelist: [
    {
      pattern: /bg-(red|green|blue|orange)-(100|500|700)/, // You can display all the colors that you need
      variants: ['lg', 'hover', 'focus', 'lg:hover'],      // Optional
    },
    {
      pattern: /text-(red|green|blue|orange)-(100|500|700)/, // You can display all the colors that you need
      variants: ['lg', 'hover', 'focus', 'lg:hover'],      // Optional
    },
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
    require('@tailwindcss/line-clamp'),
    require('@tailwindcss/aspect-ratio'),
  ],
}
DELIM
echo "...done"


echo "Generating the tailwind.css file..."
./tailwindcss -i ./global.css -o ./resources/tailwind.css
echo "...done."