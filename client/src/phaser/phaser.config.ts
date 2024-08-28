import GridEngine from "grid-engine";
import Phaser from "phaser";

const config: Phaser.Types.Core.GameConfig = {
  parent: "phaser-container",
  backgroundColor: "#00aaaa",
  scale: {
    mode: Phaser.Scale.ScaleModes.RESIZE,
    width: window.innerWidth * window.devicePixelRatio,
    height: window.innerHeight * window.devicePixelRatio,
  },
  plugins: {
    scene: [
      {
        key: "gridEngine",
        plugin: GridEngine,
        mapping: "gridEngine",
      },
    ],
  },
};

export default config;
