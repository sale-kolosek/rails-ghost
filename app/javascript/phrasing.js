//= require jquery
//= require jquery_ujs
//= require phrasing

// --- Custom override Phrasing for inline update --- //
document.addEventListener("DOMContentLoaded", () => {
  if (window.Phrasing) {

    // confirmation message
    function showSaveMessage(text = "✅ Phrase updated", success = true) {
      const notice = document.createElement("div");
      notice.textContent = text;
      notice.style.position = "fixed";
      notice.style.top = "20px";
      notice.style.left = "20px";
      notice.style.background = success ? "#56ae45" : "#dc2626";
      notice.style.color = "white";
      notice.style.padding = "8px 14px";
      notice.style.borderRadius = "8px";
      notice.style.fontSize = "14px";
      notice.style.boxShadow = "0 2px 6px rgba(0,0,0,0.15)";
      notice.style.zIndex = "9999";
      notice.style.opacity = "0";
      notice.style.transition = "opacity 0.3s ease";

      document.body.appendChild(notice);
      requestAnimationFrame(() => (notice.style.opacity = "1"));
      setTimeout(() => {
        notice.style.opacity = "0";
        setTimeout(() => notice.remove(), 400);
      }, 1800);
    }

    window.Phrasing.save = function (el) {
      const url = el.getAttribute("data-url")?.replace(/&amp;/g, "&");
      const value = el.innerHTML.trim();

      if (!url) return;

      fetch(url, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Accept": "application/json",
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
        },
        body: new URLSearchParams({ "phrasing_phrase[value]": value })
      })
      .then(res => {
        if (!res.ok) throw new Error(`Save failed (${res.status})`);
        el.classList.add("saved");
        setTimeout(() => el.classList.remove("saved"), 800);
        showSaveMessage("✅ Phrase updated", true);
      })
      .catch(() => {
        showSaveMessage("⚠️ Save failed", false);
      });
    };

    // blur save
    document.querySelectorAll("[contenteditable='true']").forEach(el => {
      let original = el.innerHTML.trim();
      el.addEventListener("focus", () => {
        original = el.innerHTML.trim();
      });
      el.addEventListener("blur", e => {
        const current = el.innerHTML.trim();
        if (current !== original) {
          window.Phrasing.save(e.target);
        }
      });
    });
  } else {
    console.warn("Phrasing not found on window");
  }
});
