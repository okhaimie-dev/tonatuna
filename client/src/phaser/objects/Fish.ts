import GridEngine from "grid-engine";

export class Fish extends Phaser.GameObjects.Container {
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
    const fishSprite = scene.add.sprite(0, 0, "magikarp");

    super(scene, 0, 0, [fishSprite]);

    gridEngine.addCharacter({
      id: `${key}-surf`,
      sprite: fishSprite,
      walkingAnimationMapping: {
        down: { leftFoot: 0, rightFoot: 0, standing: 0 },
        left: { leftFoot: 0, rightFoot: 0, standing: 0 },
        right: { leftFoot: 0, rightFoot: 0, standing: 0 },
        up: { leftFoot: 0, rightFoot: 0, standing: 0 },
      },
      container: this,
    });
    gridEngine.setPosition(`${key}-surf`, { x, y });

    this.scene = scene;
    this.gridEngine = gridEngine;
    this.key = key;
    this.scene.add.existing(this);
  }
}
