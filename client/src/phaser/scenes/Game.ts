import GridEngine, { Direction } from "grid-engine";
import { Chunk } from "../objects/Chunk";
import { Player } from "../objects/Player";
import { CHUNK_SIZE, TILE_SIZE } from "../phaser.constants";

export class Game extends Phaser.Scene {
  chunks: Chunk[] = [];

  keyW!: Phaser.Input.Keyboard.Key;
  keyS!: Phaser.Input.Keyboard.Key;
  keyA!: Phaser.Input.Keyboard.Key;
  keyD!: Phaser.Input.Keyboard.Key;

  gridEngine!: GridEngine;
  myPlayer?: Player;

  constructor() {
    super({ key: "Game" });
  }

  preload() {
    this.load.setPath("assets/");
    // load assets
    this.load.spritesheet({
      key: "water",
      url: "water.png",
      frameConfig: {
        frameWidth: 16,
        frameHeight: 16,
      },
    });
    this.load.spritesheet("surf", "surf.png", {
      frameWidth: 24,
      frameHeight: 32,
    });
  }

  create() {
    this.anims.create({
      key: "water",
      frames: this.anims.generateFrameNumbers("water", {
        frames: [0, 1, 2, 3],
      }),
      frameRate: 3,
      repeat: -1,
    });

    this.cameras.main.setZoom(3);
    this.keyW = this.input.keyboard!.addKey(Phaser.Input.Keyboard.KeyCodes.W);
    this.keyS = this.input.keyboard!.addKey(Phaser.Input.Keyboard.KeyCodes.S);
    this.keyA = this.input.keyboard!.addKey(Phaser.Input.Keyboard.KeyCodes.A);
    this.keyD = this.input.keyboard!.addKey(Phaser.Input.Keyboard.KeyCodes.D);

    this.setupGridEngine();
  }

  update() {
    this.updateChunks();
    this.handleUserInput();
  }

  getChunk(x: number, y: number) {
    return this.chunks.find((chunk) => chunk.x === x && chunk.y === y);
  }

  setupGridEngine() {
    const tilemap = this.make.tilemap({
      // create a 2d 1000 x 1000 array of 0s
      data: Array.from({ length: 1000 }, () =>
        Array.from({ length: 1000 }, () => 0)
      ),
    });
    tilemap.createLayer(0, "layer", 0, 0);

    this.gridEngine.create(tilemap, { characters: [] });
  }

  spawnPlayer(id: string, isOwner?: boolean) {
    const player = new Player(this, this.gridEngine, 0, 0, id);

    if (isOwner) {
      this.cameras.main.startFollow(player, true);
      this.myPlayer = player;
    }

    return player;
  }

  removePlayer(id: string) {
    this.gridEngine.removeCharacter(id);

    if (this.myPlayer?.key === id) {
      this.myPlayer = undefined;
    }
  }

  updateChunks() {
    if (!this.myPlayer) return;
    let snappedChunkX = Math.round(this.myPlayer.x / (CHUNK_SIZE * TILE_SIZE));
    let snappedChunkY = Math.round(this.myPlayer.y / (CHUNK_SIZE * TILE_SIZE));

    for (let x = snappedChunkX - 2; x <= snappedChunkX + 2; x++) {
      for (let y = snappedChunkY - 2; y <= snappedChunkY + 2; y++) {
        if (!this.getChunk(x, y)) {
          const chunk = new Chunk(this, {
            x,
            y,
            chunkSize: CHUNK_SIZE,
            tileSize: TILE_SIZE,
          });
          chunk.load();
          console.log("loaded chunk", x, y);
          this.chunks.push(chunk);
        }
      }
    }

    this.chunks = this.chunks.filter((chunk) => {
      if (
        chunk.x < snappedChunkX - 2 ||
        chunk.x > snappedChunkX + 2 ||
        chunk.y < snappedChunkY - 2 ||
        chunk.y > snappedChunkY + 2
      ) {
        chunk.unload();
        return false;
      }
      return true;
    });
  }

  handleUserInput() {
    if (this.keyW.isDown) {
      this.sendMove(Direction.UP);
    }
    if (this.keyS.isDown) {
      this.sendMove(Direction.DOWN);
    }
    if (this.keyA.isDown) {
      this.sendMove(Direction.LEFT);
    }
    if (this.keyD.isDown) {
      this.sendMove(Direction.RIGHT);
    }
  }

  sendMove(direction: Direction) {
    // send move transaction
  }

  handlePositionUpdate() {
    // listen to onchain position updates and call movePlayerTo on player object
  }

  handlePlayerUpdate() {
    // listen to players being added and removed and call spawnPlayer and removePlayer
  }
}
