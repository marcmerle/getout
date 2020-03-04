import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["shareButton"];

  triggerShare() {
    const shareButton = document.querySelector(".fas.fa-share-alt")

    shareButton.addEventListener('click', (event) => {
      if (navigator.share) {
        const url = document.querySelector('link[rel=canonical]') ? document.querySelector('link[rel=canonical]').href : document.location.href;
        navigator.share({
          title: "GetOut",
          text: `Join me there tonight and we'll listen to some ${event.currentTarget.dataset.genres} together!\n`,
          url: url
        })
        .catch(console.error);
      }
    });
  }
}
