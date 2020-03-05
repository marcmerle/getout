  const labelToggle = () => {

    if (document.querySelector(".likes-container label")) {

      const label = document.querySelector(".likes-container label")
      label.addEventListener("click", (e) => {
        e.currentTarget.classList.toggle("label-active")
      })
    }

    const allLabels = document.querySelectorAll(".tags-filter li")

    const toggleTag = (event) => {
      allLabels.forEach((label) => {
        label.classList.add("grey-tag");
      })
      event.currentTarget.classList.remove("grey-tag")
    }


    allLabels.forEach((label) => {
      label.addEventListener("click", toggleTag);
    })
  }

export { labelToggle };
