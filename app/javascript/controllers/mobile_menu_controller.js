import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "button"]

  connect() {
    this.resizeHandler = this.close.bind(this);
    window.addEventListener('resize', this.resizeHandler);
  }

  disconnect() {
    window.removeEventListener('resize', this.resizeHandler);
  }

  toggle() {
    this.menuTarget.classList.toggle('-translate-x-full');
    this.menuTarget.setAttribute('aria-hidden', 
      this.menuTarget.getAttribute('aria-hidden') === 'true' ? 'false' : 'true');
    this.buttonTarget.setAttribute('aria-expanded', 
      this.buttonTarget.getAttribute('aria-expanded') === 'true' ? 'false' : 'true');
  }

  close() {
    this.menuTarget.classList.add('-translate-x-full');
    this.menuTarget.setAttribute('aria-hidden', 'true');
    this.buttonTarget.setAttribute('aria-expanded', 'false');
  }
}