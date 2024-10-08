import "./App.css";
import { useQuerySync } from "@dojoengine/react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import { useEffect, useState } from "react";
import { useDojo } from "./dojo/useDojo";

function App() {
  const {
    setup: {
      systemCalls: { create_fish_pond, new_player },
      toriiClient,
      contractComponents,
    },
    account,
  } = useDojo();

  useQuerySync(toriiClient, contractComponents as any, []);

  const [clipboardStatus, setClipboardStatus] = useState({
    message: "",
    isError: false,
  });

  const handleRestoreBurners = async () => {
    try {
      await account?.applyFromClipboard();
      setClipboardStatus({
        message: "Burners restored successfully!",
        isError: false,
      });
    } catch (error) {
      setClipboardStatus({
        message: `Failed to restore burners from clipboard`,
        isError: true,
      });
    }
  };

  useEffect(() => {
    if (clipboardStatus.message) {
      const timer = setTimeout(() => {
        setClipboardStatus({ message: "", isError: false });
      }, 3000);

      return () => clearTimeout(timer);
    }
  }, [clipboardStatus.message]);

  return (
    <>
      <button onClick={() => account?.create()}>
        {account?.isDeploying ? "deploying burner" : "create burner"}
      </button>
      {account && account?.list().length > 0 && (
        <button onClick={async () => await account?.copyToClipboard()}>
          Save Burners to Clipboard
        </button>
      )}
      <button onClick={handleRestoreBurners}>
        Restore Burners from Clipboard
      </button>
      {clipboardStatus.message && (
        <div className={clipboardStatus.isError ? "error" : "success"}>
          {clipboardStatus.message}
        </div>
      )}

      <div className="card">
        <div>{`burners deployed: ${account.count}`}</div>
        <div>
          select signer:{" "}
          <select
            value={account ? account.account.address : ""}
            onChange={(e) => account.select(e.target.value)}
          >
            {account?.list().map((account, index) => {
              return (
                <option value={account.address} key={index}>
                  {account.address}
                </option>
              );
            })}
          </select>
        </div>
        <div>
          <button onClick={() => account.clear()}>Clear burners</button>
          <p>
            You will need to Authorise the contracts before you can use a
            burner. See readme.
          </p>
        </div>
      </div>

      <div className="card">
        <button onClick={() => create_fish_pond(account.account)}>
          Create Fish Pond
        </button>
      </div>

      <div className="card">
        <button onClick={() => new_player(account.account, BigInt(0x1))}>
          Create New Player
        </button>
      </div>
    </>
  );
}

export default App;
