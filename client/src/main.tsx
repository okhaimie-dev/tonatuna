import React from "react";
import ReactDOM from "react-dom/client";
import { dojoConfig } from "../dojoConfig.ts";
import App2 from "./App2.tsx";
import { PhaserGameContextProvider } from "./contexts/PhaserGameContext.tsx";
import { DojoProvider } from "./dojo/DojoContext.tsx";
import { setup } from "./dojo/setup.ts";
import "./index.css";

async function init() {
  const rootElement = document.getElementById("root");
  if (!rootElement) throw new Error("React root not found");
  const root = ReactDOM.createRoot(rootElement as HTMLElement);

  root.render(
    <React.StrictMode>
      <PhaserGameContextProvider>
        <App2 />
      </PhaserGameContextProvider>
    </React.StrictMode>
  );

  return;

  const setupResult = await setup(dojoConfig);

  !setupResult && <div>Loading....</div>;

  root.render(
    <React.StrictMode>
      <DojoProvider value={setupResult}>
        <PhaserGameContextProvider>
          <App2 />
        </PhaserGameContextProvider>
      </DojoProvider>
    </React.StrictMode>
  );
}

init();
