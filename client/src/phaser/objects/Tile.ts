export class Tile extends Phaser.GameObjects.Sprite {
  scene: Phaser.Scene;

  constructor(scene: Phaser.Scene, x: number, y: number, key: string) {
    super(scene, x, y, key);

    this.scene = scene;
    this.scene.add.existing(this);
    this.setOrigin(0);
  }
}
