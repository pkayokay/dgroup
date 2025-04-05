// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

import JSConfetti from "js-confetti"
const jsConfetti = new JSConfetti();

window.jsConfetti = jsConfetti;
