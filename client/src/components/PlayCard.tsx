import { useGameScene } from "@/contexts/PhaserGameContext";
import { useState } from "react";

export default function PlayCard() {
  const gameScene = useGameScene();
  const [name, setName] = useState("");

  const sendPlay = () => {
    // TODO(okhai): send play transaction with name
    // TESTING: remove this after integration
    gameScene!.spawnPlayer("player1", 0, 0, true);
  };

  if (gameScene?.myPlayerId !== undefined) {
    return null;
  }

  return (
    <div className="pointer-events-auto flex flex-col bg-white p-4 gap-2 border-4">
      <input
        type="text"
        placeholder="Enter your name"
        className="border-4 p-2"
        value={name}
        onChange={(e) => setName(e.target.value)}
      />
      <button
        className="bg-green-500 text-white p-2 border-4 border-green-400"
        onClick={sendPlay}
      >
        Play
      </button>
    </div>
  );
}
