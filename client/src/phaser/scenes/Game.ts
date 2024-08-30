import GridEngine, { Direction } from "grid-engine";
import { Chunk } from "../objects/Chunk";
import { Fish } from "../objects/Fish";
import { Player } from "../objects/Player";
import { CHUNK_SIZE, GRID_SIZE, TILE_SIZE } from "../phaser.constants";

export class Game extends Phaser.Scene {
  chunks: Chunk[] = [];

  keyW!: Phaser.Input.Keyboard.Key;
  keyS!: Phaser.Input.Keyboard.Key;
  keyA!: Phaser.Input.Keyboard.Key;
  keyD!: Phaser.Input.Keyboard.Key;
  keyF!: Phaser.Input.Keyboard.Key;

  gridEngine!: GridEngine;
  players: Record<string, Player> = {};
  myPlayerId?: string;

  isFishing: boolean = false;
  selectIndicator!: Phaser.GameObjects.Graphics;

  constructor() {
    super({ key: "Game" });
  }

  preload() {
    this.load.setPath("public/");
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
    this.load.spritesheet("magikarp", "magikarp.png", {
      frameWidth: 32,
      frameHeight: 32,
    });
    this.load.spritesheet("fishing", "fishing.png", {
      frameWidth: 32,
      frameHeight: 40,
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

    this.selectIndicator = this.add
      .graphics()
      .lineStyle(2, 0xffffff)
      .strokeRect(0, 0, GRID_SIZE, GRID_SIZE)
      .setDepth(2)
      .setVisible(false);

    this.cameras.main.setZoom(3);
    this.keyW = this.input.keyboard!.addKey(Phaser.Input.Keyboard.KeyCodes.W);
    this.keyS = this.input.keyboard!.addKey(Phaser.Input.Keyboard.KeyCodes.S);
    this.keyA = this.input.keyboard!.addKey(Phaser.Input.Keyboard.KeyCodes.A);
    this.keyD = this.input.keyboard!.addKey(Phaser.Input.Keyboard.KeyCodes.D);
    this.keyF = this.input.keyboard!.addKey(Phaser.Input.Keyboard.KeyCodes.F);
    this.input.keyboard?.removeCapture([
      Phaser.Input.Keyboard.KeyCodes.W,
      Phaser.Input.Keyboard.KeyCodes.A,
      Phaser.Input.Keyboard.KeyCodes.S,
      Phaser.Input.Keyboard.KeyCodes.D,
      Phaser.Input.Keyboard.KeyCodes.F,
    ]);

    this.setupGridEngine();
    this.listenKeyPresses();
    this.updateChunks(0, 0);
    const camera = this.cameras.main;
    camera.setScroll(-camera.width / 2, -camera.height / 2);

    // TESTING
    this.spawnFish("fish1", 0, 0);
  }

  update() {
    if (!this.myPlayerId) return;
    const myPlayer = this.players[this.myPlayerId];
    if (myPlayer) {
      this.updateChunks(myPlayer.x, myPlayer.y);
    }
    this.handleKeyHolds();
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

  spawnPlayer(id: string, x: number = 0, y: number = 0, isOwner?: boolean) {
    const player = new Player(this, this.gridEngine, x, y, id);

    if (isOwner) {
      this.cameras.main.startFollow(player, true);
      this.myPlayerId = id;
    }

    this.players[id] = player;
    return player;
  }

  removePlayer(id: string) {
    this.gridEngine.removeCharacter(id);
    delete this.players[id];

    if (this.myPlayerId === id) {
      this.myPlayerId = undefined;
      this.isFishing = false;
      this.selectIndicator.setVisible(false);
    }
  }

  spawnFish(id: string, x: number, y: number) {
    // create fish object
    return new Fish(this, this.gridEngine, x, y, id);
  }

  removeFish(id: string) {
    this.gridEngine.removeCharacter(id);
  }

  updateChunks(x: number, y: number) {
    let snappedChunkX = Math.round(x / (CHUNK_SIZE * TILE_SIZE));
    let snappedChunkY = Math.round(y / (CHUNK_SIZE * TILE_SIZE));

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

  handleKeyHolds() {
    if (this.isFishing) return;
    if (this.keyW.isDown) {
      this.sendMove(Direction.UP);
    } else if (this.keyS.isDown) {
      this.sendMove(Direction.DOWN);
    } else if (this.keyA.isDown) {
      this.sendMove(Direction.LEFT);
    } else if (this.keyD.isDown) {
      this.sendMove(Direction.RIGHT);
    }
  }

  listenKeyPresses() {
    this.input.keyboard?.on("keydown", (event: KeyboardEvent) => {
      if (event.key === "f") {
        this.toggleFishing();
      } else if (this.isFishing) {
        if (event.key === "w") {
          this.selectIndicator.y -= GRID_SIZE;
        } else if (event.key === "s") {
          this.selectIndicator.y += GRID_SIZE;
        } else if (event.key === "a") {
          this.selectIndicator.x -= GRID_SIZE;
        } else if (event.key === "d") {
          this.selectIndicator.x += GRID_SIZE;
        } else if (event.key === "Enter") {
          const x = Math.round(this.selectIndicator.x / GRID_SIZE);
          const y = Math.round(this.selectIndicator.y / GRID_SIZE);
          const fishId = this.gridEngine.getCharactersAt({ x, y })[0];
          if (fishId) {
            if (this.myPlayerId) {
              this.sendCast(this.myPlayerId, fishId);
            }
            this.toggleFishing();
          }
        }
      }
    });
  }

  toggleFishing() {
    if (!this.myPlayerId) return;
    const myPlayer = this.players[this.myPlayerId];
    this.isFishing = !this.isFishing;
    this.selectIndicator.setVisible(this.isFishing);
    if (this.isFishing) {
      const pos = this.gridEngine.getPosition(this.myPlayerId);
      this.selectIndicator.setPosition(pos.x * GRID_SIZE, pos.y * GRID_SIZE);
      myPlayer.precast();
    } else {
      myPlayer.release();
    }
  }

  sendMove(direction: Direction) {
    // send move transaction
    if (!this.myPlayerId) return;
    this.players[this.myPlayerId]?.move(direction);
  }

  sendCast(playerId: string, fishId: string) {
    // send cast transaction
  }
}
