type Direction = "up" | "down" | "left" | "right";

export class Player extends Phaser.GameObjects.Sprite {
  scene: Phaser.Scene;

  constructor(scene: Phaser.Scene, x: number, y: number, key: string) {
    super(scene, x, y, key);

    this.scene = scene;
    this.scene.add.existing(this);
    this.setOrigin(0);
  }

  startAnimation(direction: Direction) {
    this.anims.play(direction);
  }

  stopAnimation(direction: Direction) {
    const standingFrame =
      this.anims.animationManager.get(direction).frames[1].frame.name;
    this.anims.stop();
    this.setFrame(standingFrame);
  }
}
