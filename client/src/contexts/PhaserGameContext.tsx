import phaserConfig from "@/phaser/phaser.config";
import { Game } from "@/phaser/scenes/Game";
import {
  createContext,
  PropsWithChildren,
  useContext,
  useEffect,
  useRef,
  useState,
} from "react";

export type PhaserGameValue = {
  gameScene?: Game;
};

export type PhaserGameContextProps = PropsWithChildren;

export const PhaserGameContext = createContext<PhaserGameValue>({});

export function PhaserGameContextProvider({
  children,
}: PhaserGameContextProps) {
  const gameSceneRef = useRef<Game>();
  const rerender = useState({})[1];

  useEffect(() => {
    if (gameSceneRef.current) return;

    const gameScene = new Game();
    new Phaser.Game({
      ...phaserConfig,
      scene: [gameScene],
    });
    gameSceneRef.current = gameScene;

    rerender({});
  }, []);

  return (
    <PhaserGameContext.Provider value={{ gameScene: gameSceneRef.current }}>
      {children}
    </PhaserGameContext.Provider>
  );
}

export function useGameScene() {
  const { gameScene } = useContext(PhaserGameContext);
  return gameScene;
}
