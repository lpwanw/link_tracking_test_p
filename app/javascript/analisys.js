document.addEventListener("turbo:load", function() {
  attachClickListeners();
});

function attachClickListeners() {
  document.querySelectorAll("a").forEach(function(link) {
    link.removeEventListener("click", handleLinkClick);
    link.addEventListener("click", handleLinkClick);
  });
}

function handleLinkClick(event) {
  const clickData = {
    link_click: {
      url: this.getAttribute("href"),
      anchor_text: this.textContent,
    }
  };
  const csrfToken = document.querySelector("meta[name='csrf-token']");
  const headers = {
    "Content-Type": "application/json",
    "X-CSRF-Token": csrfToken && csrfToken.content,
  }

  fetch("/link_clicks", { method: "POST", body: JSON.stringify(clickData), headers, keepalive: true})
}
