import manifest from "../manifests/dev/deployment/manifest.json";

import { createDojoConfig } from "@dojoengine/core";

const {
  VITE_PUBLIC_NODE_URL,
  VITE_PUBLIC_TORII,
  VITE_PUBLIC_MASTER_ADDRESS,
  VITE_PUBLIC_MASTER_PRIVATE_KEY,
} = import.meta.env;

export const dojoConfig = createDojoConfig({
  manifest,
  rpcUrl: VITE_PUBLIC_NODE_URL || "http://localhost:5050",
  toriiUrl: VITE_PUBLIC_TORII || "http://0.0.0.0:8080",
  masterAddress:
    VITE_PUBLIC_MASTER_ADDRESS ||
    "0x6d8a4c8c7830004f53371b56773278e0ab107fc10ecffb008a33ad84c5f2175",
  masterPrivateKey:
    VITE_PUBLIC_MASTER_PRIVATE_KEY ||
    "0x5d2e95d7477224d35cd3b1ffe50c1631573e21b71977605177528acfc4b8598",
});
