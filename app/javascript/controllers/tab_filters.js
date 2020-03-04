  const labelToggle = () => {

    if (document.querySelector(".likes-container label")) {

      const label = document.querySelector(".likes-container label")
      label.addEventListener("click", (e) => {
        e.currentTarget.classList.toggle("label-active")
      })
    }
  }

export { labelToggle };
