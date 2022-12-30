# RustWasmPlay-Dioxus
Playground repo for experimenting with Dioxus rust framework

This is just a basic follow of the instructions found on the [Dioxus site](https://dioxuslabs.com/reference/platforms/web)

I created this repo so I could try out the trunk publish on GitHub.

## Instructions

To build our app and publish it to Github:

- Make sure Github Pages is set up for your repo
- Build your app with trunk build --release
- Move your generated HTML/CSS/JS/Wasm from dist into the folder configured for Github Pages
- Add and commit with git
- Push to Github

### For this simple project

I manually copied the contents of the `dist` directory into the `docs` directory. GitHub pages seems to only offer '/docs' as a option to deploy pages reasonably.

Once copied I did need to make a modification to the `index.html` to get things working on GHP. Mainly, I had to modify the paths:

Changed:

```html
<link rel="preload" href="/demo-2d1f61047eddc54e_bg.wasm" as="fetch" type="application/wasm" crossorigin="">
<link rel="modulepreload" href="/demo-2d1f61047eddc54e.js"></head>
```

to:

```html
<link rel="preload" href="demo-2d1f61047eddc54e_bg.wasm" as="fetch" type="application/wasm" crossorigin="">
<link rel="modulepreload" href="demo-2d1f61047eddc54e.js"></head>
```

Note: the only change was the prefixed `/` on the `href`s. The reason for this is that GHP deploys the pages to USERNAME.github.io/PROJECT-ID/... and the semantics of using a href with a leading `/` is that it will attempt to get the resource from the URL `https://USERNAME.github.io/demo-2d1f61047eddc54e_bg.wasm` which will not work since the actual path is `https://USERNAME.github.io/PROJECT-ID/demo-2d1f61047eddc54e_bg.wasm`. By removing the leading `/` this issue is eliminated since the semantics become "load the resource href relative to the loaded html file"

Also changed:

```html
<script type="module">import init from '/demo-2d1f61047eddc54e.js';init('/demo-2d1f61047eddc54e_bg.wasm');</script></body></html>
```

to:
```html
<script type="module">import init from './demo-2d1f61047eddc54e.js';init('./demo-2d1f61047eddc54e_bg.wasm');</script></body></html>
```

Note: added a leading `.` to the source file paths. The reason for this change is because I changed the above `href`s to be relative. The script in combination with the use of the link preload means the files are local relative and thus should be imported as if locally mapped.