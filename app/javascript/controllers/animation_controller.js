import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["image", "loading", "tastes", "tastesContent"];

  connect() {
    this.tastesTarget.style.display = "none";
    this.preloadImages();
    this.animate();
  }

  preloadImages() {
    this.images = [];

    let i;
    for (i = 0; i < 241; i++) {
      this.images[i] = new Image();
      this.images[i].src =
        "/animation/frame" + i.toString().padStart(3, "0") + ".svg";
    }
  }

  animate() {
    let counter = 0;
    let frameCount = 0;

    const frame = now => {
      this.imageTarget.setAttribute("xlink:href", this.images[frameCount].src);

      frameCount++;
      if (frameCount == 240) {
        frameCount = 0;
        counter++;
      }

      if (counter < 1 || frameCount < 120) {
        requestAnimationFrame(frame);
      } else {
        this.fade();
      }
    };

    requestAnimationFrame(frame);
  }

  fade() {
    let loading = this.loadingTarget;
    let tastes = this.tastesContentTarget;

    loading.style.position = "absolute";
    loading.style.opacity = 1;

    tastes.style.opacity = 0;
    this.tastesTarget.style.display = "block";

    const changeLoadingOpacity = () => {
      loading.style.opacity = parseFloat(loading.style.opacity) - 0.02;

      if (loading.style.opacity < 0) {
        loading.style.display = "none";
        changeTastesOpacity();
      } else {
        window.requestAnimationFrame(changeLoadingOpacity);
      }
    };

    const changeTastesOpacity = () => {
      tastes.style.opacity = parseFloat(tastes.style.opacity) + 0.02;

      if (tastes.style.opacity > 1) {
        tastes.style.opacity = 1;
      } else {
        window.requestAnimationFrame(changeTastesOpacity);
      }
    };

    changeLoadingOpacity();
  }
}
