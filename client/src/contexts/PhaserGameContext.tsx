import phaserConfig from "@/phaser/phaser.config";
import { Game } from "@/phaser/scenes/Game";
import { createContext, PropsWithChildren, useEffect, useState } from "react";

export type PhaserGameValue = {
  gameScene?: Game;
};

export type PhaserGameContextProps = PropsWithChildren;

export const PhaserGameContext = createContext<PhaserGameValue>({});

export function PhaserGameContextProvider({
  children,
}: PhaserGameContextProps) {
  const [gameScene, setGameScene] = useState<Game>();

  useEffect(() => {
    const gameScene = new Game();
    new Phaser.Game({
      ...phaserConfig,
      scene: [gameScene],
    });
    setGameScene(gameScene);
  }, []);

  return (
    <PhaserGameContext.Provider value={{ gameScene }}>
      {children}
    </PhaserGameContext.Provider>
  );
}
