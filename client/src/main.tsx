import React from "react";
import ReactDOM from "react-dom/client";
import { dojoConfig } from "../dojoConfig.ts";
import App from "./App.tsx";
import { PhaserGameContextProvider } from "./contexts/PhaserGameContext.tsx";
import { DojoProvider } from "./dojo/DojoContext.tsx";
import { setup } from "./dojo/setup.ts";
import "./index.css";

async function init() {
  const rootElement = document.getElementById("root");
  if (!rootElement) throw new Error("React root not found");
  const root = ReactDOM.createRoot(rootElement as HTMLElement);

  const setupResult = await setup(dojoConfig);

  !setupResult && <div>Loading....</div>;

  root.render(
    <React.StrictMode>
      <DojoProvider value={setupResult}>
        <PhaserGameContextProvider>
          <App />
        </PhaserGameContextProvider>
      </DojoProvider>
    </React.StrictMode>
  );
}

init();
