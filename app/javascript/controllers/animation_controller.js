import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["image", "redirection"];

  connect() {
    this.redirectAfter(6, this.redirectionTarget.dataset.redirect);
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

    const frame = now => {
      this.imageTarget.setAttribute("xlink:href", this.images[counter].src);

      counter++;
      if (counter == 240) counter = 0;

      requestAnimationFrame(frame);
    };

    requestAnimationFrame(frame);
  }

  redirectAfter(seconds, path) {
    window.setTimeout(function() {
      window.location.href = path;
    }, seconds * 1000);
  }
}
