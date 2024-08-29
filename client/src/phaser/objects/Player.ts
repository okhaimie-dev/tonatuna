import GridEngine, { Direction, Position } from "grid-engine";

export class Player extends Phaser.GameObjects.Container {
  scene: Phaser.Scene;
  gridEngine: GridEngine;
  key: string;

  surfSprite: Phaser.GameObjects.Sprite;
  playerSprite: Phaser.GameObjects.Sprite;
  castingSprite: Phaser.GameObjects.Sprite;
  precastingSprite: Phaser.GameObjects.Sprite;

  constructor(
    scene: Phaser.Scene,
    gridEngine: GridEngine,
    x: number,
    y: number,
    key: string
  ) {
    const surfSprite = scene.add.sprite(0, 0, "surf");
    const playerSprite = scene.add.sprite(4, -8, "surf");
    const castingSprite = scene.add.sprite(16, 8, "fishing").setVisible(false);
    const precastingSprite = scene.add
      .sprite(16, 8, "fishing")
      .setVisible(false);

    super(scene, 0, 0, [
      surfSprite,
      playerSprite,
      castingSprite,
      precastingSprite,
    ]);

    this.surfSprite = surfSprite;
    this.playerSprite = playerSprite;
    this.castingSprite = castingSprite;
    this.precastingSprite = precastingSprite;

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
      id: `${key}-casting`,
      sprite: castingSprite,
      walkingAnimationMapping: {
        down: { leftFoot: 0, rightFoot: 0, standing: 0 },
        left: { leftFoot: 1, rightFoot: 1, standing: 1 },
        right: { leftFoot: 2, rightFoot: 2, standing: 2 },
        up: { leftFoot: 3, rightFoot: 3, standing: 3 },
      },
    });
    gridEngine.addCharacter({
      id: `${key}-precasting`,
      sprite: precastingSprite,
      walkingAnimationMapping: {
        down: { leftFoot: 4, rightFoot: 4, standing: 4 },
        left: { leftFoot: 5, rightFoot: 5, standing: 5 },
        right: { leftFoot: 6, rightFoot: 6, standing: 6 },
        up: { leftFoot: 7, rightFoot: 7, standing: 7 },
      },
    });
    gridEngine.addCharacter({
      id: key,
      sprite: playerSprite,
      walkingAnimationMapping: {
        down: { leftFoot: 1, rightFoot: 1, standing: 1 },
        left: { leftFoot: 13, rightFoot: 13, standing: 13 },
        right: { leftFoot: 25, rightFoot: 25, standing: 25 },
        up: { leftFoot: 37, rightFoot: 37, standing: 37 },
      },
      container: this,
    });
    gridEngine.setPosition(key, { x, y });

    this.scene = scene;
    this.gridEngine = gridEngine;
    this.key = key;
    this.scene.add.existing(this);
  }

  move(direction: Direction) {
    this.gridEngine.move(this.key, direction);
    this.gridEngine.turnTowards(`${this.key}-surf`, direction);
    this.gridEngine.turnTowards(`${this.key}-casting`, direction);
    this.gridEngine.turnTowards(`${this.key}-precasting`, direction);
  }

  movePlayerTo(targetPos: Position) {
    this.gridEngine.moveTo(this.key, targetPos);
  }

  precast() {
    this.precastingSprite.setVisible(true);
    this.playerSprite.setVisible(false);
    this.castingSprite.setVisible(false);
  }

  cast() {
    this.castingSprite.setVisible(true);
    this.playerSprite.setVisible(false);
    this.precastingSprite.setVisible(false);
  }

  release() {
    this.playerSprite.setVisible(true);
    this.castingSprite.setVisible(false);
    this.precastingSprite.setVisible(false);
  }
}
