// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", () => {
  const nameInput = document.getElementById("workout_record_name");
  const weightInput = document.getElementById("weight_input");
  const repsInput = document.getElementById("reps_input");

  nameInput.addEventListener("input", () => {
    const name = nameInput.value.trim();

    if (name.length === 0) {
      weightInput.placeholder = "Kg";
      repsInput.placeholder = "回";
      return;
    }

    // Ajaxで前回データ取得
    fetch(`/workout_records/previous_record?name=${encodeURIComponent(name)}`)
      .then(response => response.json())
      .then(data => {
        // 前回結果を placeholder に表示
        weightInput.placeholder = data.weight ? `前回結果 ${data.weight}Kg` : "Kg";
        repsInput.placeholder = data.reps ? `前回結果 ${data.reps}回` : "回";
      });
  });
});