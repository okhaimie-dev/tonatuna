import { useGameScene } from "@/contexts/PhaserGameContext";
import { useEffect } from "react";

export default function useRecsToPhaser() {
  const gameScene = useGameScene();

  useEffect(() => {
    if (!gameScene) return;

    const movePlayer = (playerId: string, x: number, y: number) => {
      gameScene.gridEngine.moveTo(playerId, { x, y });
    };

    const spawnPlayer = (playerId: string, x: number, y: number) => {
      // TODO(okhai): replace with real owner check
      const isOwner = true;
      gameScene.spawnPlayer(playerId, x, y, isOwner);
    };

    const removePlayer = (playerId: string) => {
      gameScene.removePlayer(playerId);
    };

    const spawnFish = (fishId: string, x: number, y: number) => {
      gameScene.spawnFish(fishId, x, y);
    };

    const removeFish = (fishId: string) => {
      gameScene.removeFish(fishId);
    };

    const cast = (playerId: string) => {
      gameScene.players[playerId].cast();
    };

    const release = (playerId: string) => {
      gameScene.players[playerId].release();
    };

    // TODO(okhai): listen to onchain position updates and call `movePlayer`

    // TODO(okhai): listen to players being added and removed and call `spawnPlayer` and `removePlayer`

    // TODO(okhai): listen to fish being added and removed and call `spawnFish` and `removeFish`

    // TODO(okhai): listen to commitment updates and call `cast` on set and release on `remove`
  }, [gameScene]);
}
