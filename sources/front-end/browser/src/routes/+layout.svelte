<script>
  import {
    env,
  } from '$env/dynamic/public';
  import {
    browser as IsInBrowser,
  } from '$app/environment';
  import {
    onMount,
    onDestroy,
  } from 'svelte';
  import Header from '$lib/containers/Header/index.svelte';
  import Footer from '$lib/containers/Footer/index.svelte';
  import "inter-ui/inter.css";

  // import {
  //   WsStoreAdapter,
  // } from '$lib/modules/wsStoreAdapter/index.mjs';
  // import {
  //   Ldr,
  // } from '$lib/modules/ldr/ldr.mjs';

  // /** @type {Ldr | null} */
  // let ldr = null;
  // /** @type {WsStoreAdapter | undefined | null} */
  // let wsStoreAdapter = null;

  const workersConfig = {
    wsWorker: {
      url: `${env.PUBLIC_WS_PROTO}://${env.PUBLIC_WS_HOST}:${env.PUBLIC_WS_PORT}/`,
    },
  };

  const handleUIChannelMessages = (/** @type {MessageEvent} */ uiMessage) => {
    const {
      data,
    } = uiMessage;
    console.log('handleUIChannelMessages', data);
  }

  onMount(() => {
    if (IsInBrowser === true) {
      // uiBroadcastChannel.addEventListener('message', handleUIChannelMessages);
      // isMobileDevice = IsInDevMode === true ? true : window.matchMedia("(any-pointer: none)").matches;

      // @ts-ignore
      // ldr = new Ldr(workersConfig);

      // await ldr?.start();

      // wsStoreAdapter = new WsStoreAdapter();
      // wsStoreAdapter.start();
    }
  });

  onDestroy(() => {
    if (IsInBrowser === true) {
      // await ldr?.stop();

      // ldr = null;

      // if (wsStoreAdapter) {
      //   wsStoreAdapter.stop();
      //   wsStoreAdapter = null;
      // }
    }
  });
</script>

<Header />
<main>
  <slot />
</main>
<Footer />
