const initFillTag = () => {
  if (document.querySelector(".tastes")) {

    const tags = document.querySelectorAll(".tag");

    const toggleTagStyle = (tag, setup) => {
      console.log(tag.dataset.chosen === setup)
      if (tag.dataset.chosen === "true") {
        tag.setAttribute("style", `border: 1px solid ${tag.dataset.color}; color: #fffdf7; box-shadow: 0 0px 4px 0px ${tag.dataset.color}; background: ${tag.dataset.color}`);
        tag.dataset.chosen = "false"
      } else {
        tag.setAttribute("style", `border: 1px solid #ef798a; color: #ef798a; box-shadow: 0 0px 4px 0px #ef798a;`);
        tag.dataset.chosen = "true"
      }
    }

    tags.forEach((tag) => {
      toggleTagStyle(tag, "true");
      tag.addEventListener('click', (event) => {
        toggleTagStyle(event.currentTarget, "false");
      });
    });
  };
};

export {initFillTag};
