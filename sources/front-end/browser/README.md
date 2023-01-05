# create-svelte

Everything you need to build a Svelte project, powered by [`create-svelte`](https://github.com/sveltejs/kit/tree/master/packages/create-svelte).

## Creating a project

If you're seeing this, you've probably already done this step. Congrats!

```bash
# create a new project in the current directory
pnpm create svelte@latest

# create a new project in my-app
pnpm create svelte@latest my-app
```

## Developing

Once you've created a project and installed dependencies with `pnpm install` (or `ppnpm install` or `yarn`), start a development server:

```bash
pnpm run dev

# or start the server and open the app in a new browser tab
pnpm run dev -- --open
```

## Building

To create a production version of your app:

```bash
pnpm run build
```

You can preview the production build with `pnpm run preview`.

> To deploy your app, you may need to install an [adapter](https://kit.svelte.dev/docs/adapters) for your target environment.

## NB

Your project is ready!
✔ Type-checked JavaScript: https://www.typescriptlang.org/tsconfig#checkJs
✔ ESLint: https://github.com/sveltejs/eslint-plugin-svelte3
✔ Prettier: https://prettier.io/docs/en/options.html, https://github.com/sveltejs/prettier-plugin-svelte#options
✔ Playwright: https://playwright.dev
✔ Vitest: https://vitest.dev

Install community-maintained integrations: https://github.com/svelte-add/svelte-adders

Next steps:
1: pnpm install (or ppnpm install, etc)
2: git init && git add -A && git commit -m "Initial commit" (optional)
3: pnpm run dev -- --open
