import { Tile } from "./Tile";

export class Chunk {
  scene: Phaser.Scene;
  x: number;
  y: number;
  tiles: Phaser.GameObjects.Group;
  isLoaded: boolean;
  chunkSize: number;
  tileSize: number;

  constructor(
    scene: Phaser.Scene,
    {
      x,
      y,
      tileSize,
      chunkSize,
    }: {
      x: number;
      y: number;
      tileSize: number;
      chunkSize: number;
    }
  ) {
    this.scene = scene;
    this.x = x;
    this.y = y;
    this.tiles = this.scene.add.group();
    this.isLoaded = false;
    this.chunkSize = chunkSize;
    this.tileSize = tileSize;
  }

  unload() {
    if (this.isLoaded) {
      this.tiles.clear(true, true);
      this.isLoaded = false;
    }
  }

  load() {
    if (!this.isLoaded) {
      for (let x = 0; x < this.chunkSize; x++) {
        for (let y = 0; y < this.chunkSize; y++) {
          const tileX =
            this.x * (this.chunkSize * this.tileSize) + x * this.tileSize;
          const tileY =
            this.y * (this.chunkSize * this.tileSize) + y * this.tileSize;
          this.tiles.add(
            new Tile(this.scene, tileX, tileY, "water").play("water")
          );
        }
      }

      this.isLoaded = true;
    }
  }
}
