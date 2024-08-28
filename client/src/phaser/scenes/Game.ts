import GridEngine, { Direction, GridEngineConfig } from "grid-engine";
import { Chunk } from "../objects/Chunk";
import { CHUNK_SIZE, TILE_SIZE } from "../phaser.constants";

export class Game extends Phaser.Scene {
  chunks: Chunk[] = [];

  keyW!: Phaser.Input.Keyboard.Key;
  keyS!: Phaser.Input.Keyboard.Key;
  keyA!: Phaser.Input.Keyboard.Key;
  keyD!: Phaser.Input.Keyboard.Key;

  gridEngine!: GridEngine;
  playerContainer!: Phaser.GameObjects.Container;

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

    const surfSprite = this.add.sprite(0, 0, "surf");
    const playerSprite = this.add.sprite(4, -8, "surf");
    const playerContainer = this.add.container(0, 0, [
      surfSprite,
      playerSprite,
    ]);

    this.cameras.main.startFollow(playerContainer, true);
    this.cameras.main.setFollowOffset(
      -playerContainer.width,
      -playerContainer.height
    );
    this.playerContainer = playerContainer;

    const tilemap = this.make.tilemap({
      // create a 2d 1000 x 1000 array of 0s
      data: Array.from({ length: 1000 }, () =>
        Array.from({ length: 1000 }, () => 0)
      ),
    });
    tilemap.createLayer(0, "layer", 0, 0);

    const gridEngineConfig: GridEngineConfig = {
      characters: [
        {
          id: "surf",
          sprite: surfSprite,
          walkingAnimationMapping: {
            down: { leftFoot: 10, rightFoot: 10, standing: 10 },
            left: { leftFoot: 22, rightFoot: 22, standing: 22 },
            right: { leftFoot: 34, rightFoot: 34, standing: 34 },
            up: { leftFoot: 46, rightFoot: 46, standing: 46 },
          },
        },
        {
          id: "player",
          sprite: playerSprite,
          walkingAnimationMapping: {
            down: { leftFoot: 4, rightFoot: 4, standing: 4 },
            left: { leftFoot: 16, rightFoot: 16, standing: 16 },
            right: { leftFoot: 28, rightFoot: 28, standing: 28 },
            up: { leftFoot: 40, rightFoot: 40, standing: 40 },
          },
          container: playerContainer,
        },
      ],
    };

    this.gridEngine.create(tilemap, gridEngineConfig);

    this.cameras.main.setZoom(3);
    this.keyW = this.input.keyboard!.addKey(Phaser.Input.Keyboard.KeyCodes.W);
    this.keyS = this.input.keyboard!.addKey(Phaser.Input.Keyboard.KeyCodes.S);
    this.keyA = this.input.keyboard!.addKey(Phaser.Input.Keyboard.KeyCodes.A);
    this.keyD = this.input.keyboard!.addKey(Phaser.Input.Keyboard.KeyCodes.D);
  }

  update() {
    if (!this.playerContainer) return;
    let snappedChunkX = Math.round(
      this.playerContainer.x / (CHUNK_SIZE * TILE_SIZE)
    );
    let snappedChunkY = Math.round(
      this.playerContainer.y / (CHUNK_SIZE * TILE_SIZE)
    );

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

    if (this.keyW.isDown) {
      this.gridEngine.move("player", Direction.UP);
      this.gridEngine.turnTowards("surf", Direction.UP);
    }
    if (this.keyS.isDown) {
      this.gridEngine.move("player", Direction.DOWN);
      this.gridEngine.turnTowards("surf", Direction.DOWN);
    }
    if (this.keyA.isDown) {
      this.gridEngine.move("player", Direction.LEFT);
      this.gridEngine.turnTowards("surf", Direction.LEFT);
    }
    if (this.keyD.isDown) {
      this.gridEngine.move("player", Direction.RIGHT);
      this.gridEngine.turnTowards("surf", Direction.RIGHT);
    }
  }

  getChunk(x: number, y: number) {
    return this.chunks.find((chunk) => chunk.x === x && chunk.y === y);
  }
}
