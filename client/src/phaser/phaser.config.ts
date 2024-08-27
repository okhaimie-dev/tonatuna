import Phaser from "phaser";

const config: Phaser.Types.Core.GameConfig = {
  parent: "phaser-container",
  backgroundColor: "#00aaaa",
  scale: {
    mode: Phaser.Scale.ScaleModes.RESIZE,
    width: window.innerWidth * window.devicePixelRatio,
    height: window.innerHeight * window.devicePixelRatio,
  },
};

export default config;
