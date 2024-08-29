import GridEngine, { Direction, Position } from "grid-engine";

export class Player extends Phaser.GameObjects.Container {
  scene: Phaser.Scene;
  gridEngine: GridEngine;
  key: string;

  constructor(
    scene: Phaser.Scene,
    gridEngine: GridEngine,
    x: number,
    y: number,
    key: string
  ) {
    const surfSprite = scene.add.sprite(x * 32, y * 32, "surf");
    const playerSprite = scene.add.sprite(x * 32 + 4, y * 32 - 8, "surf");

    super(scene, x, y, [surfSprite, playerSprite]);

    gridEngine.addCharacter({
      id: `${key}-surf`,
      sprite: surfSprite,
      walkingAnimationMapping: {
        down: { leftFoot: 10, rightFoot: 10, standing: 10 },
        left: { leftFoot: 22, rightFoot: 22, standing: 22 },
        right: { leftFoot: 34, rightFoot: 34, standing: 34 },
        up: { leftFoot: 46, rightFoot: 46, standing: 46 },
      },
    });
    gridEngine.addCharacter({
      id: key,
      sprite: playerSprite,
      walkingAnimationMapping: {
        down: { leftFoot: 4, rightFoot: 4, standing: 4 },
        left: { leftFoot: 16, rightFoot: 16, standing: 16 },
        right: { leftFoot: 28, rightFoot: 28, standing: 28 },
        up: { leftFoot: 40, rightFoot: 40, standing: 40 },
      },
      container: this,
    });

    this.scene = scene;
    this.gridEngine = gridEngine;
    this.key = key;
    this.scene.add.existing(this);
  }

  move(direction: Direction) {
    this.gridEngine.move(this.key, direction);
  }

  movePlayerTo(targetPos: Position) {
    this.gridEngine.moveTo(this.key, targetPos);
  }
}
