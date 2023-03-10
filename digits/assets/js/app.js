import "phoenix_html"

import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

import Draw from 'draw-on-canvas'

let Hooks = {}


Hooks.Draw = {
    mounted() {
      this.draw = new Draw(this.el, 384, 384, {
        backgroundColor: "black",
        strokeColor: "white",
        strokeWeight: 10
      })
  
      this.handleEvent("reset", () => {
        this.draw.reset()
      })
  
      this.handleEvent("predict", () => {
        this.pushEvent("image", this.draw.canvas.toDataURL('image/png'))
      })
    }
  }
  



let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
    hooks: Hooks,
    params: {_csrf_token: csrfToken}
})


// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.delayedShow(200))
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

