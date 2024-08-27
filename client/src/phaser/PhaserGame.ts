import config from "./phaser.config";
import { Game } from "./scenes/Game";

new Phaser.Game({
  ...config,
  scene: [new Game()],
});
