// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  const nameInput = document.getElementById("workout_record_name");
  const weightInput = document.getElementById("weight_input");
  const repsInput = document.getElementById("reps_input");

  if (!nameInput || !weightInput || !repsInput) return;

  let timeout = null;

  nameInput.addEventListener("input", () => {
    const name = nameInput.value.trim();

    clearTimeout(timeout);

    timeout = setTimeout(() => {
      if (name.length === 0) {
        weightInput.placeholder = "Kg";
        repsInput.placeholder = "回";
        return;
      }

      fetch(`/workout_records/previous_record?name=${encodeURIComponent(name)}`)
        .then(response => response.json())
        .then(data => {
          if (data.weight !== null && data.weight !== undefined) {
            weightInput.placeholder = `前回結果 ${data.weight}Kg`;
          } else {
            weightInput.placeholder = "Kg";
          }

          if (data.reps !== null && data.reps !== undefined) {
            repsInput.placeholder = `前回結果 ${data.reps}回`;
          } else {
            repsInput.placeholder = "回";
          }
        })
        .catch(() => {
          weightInput.placeholder = "Kg";
          repsInput.placeholder = "回";
        });

    }, 500); // ← 入力止まって0.5秒後に実行
  });
});