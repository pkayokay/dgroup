// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

import JSConfetti from "js-confetti"
document.addEventListener("turbo:load", () => {
  const jsConfetti = new JSConfetti();
  window.jsConfetti = jsConfetti;
});

document.addEventListener("turbo:before-cache", () => {
  delete window.jsConfetti;
});
