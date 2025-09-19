App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  connected() {
    console.log("✅ Connected to NotificationsChannel");
  },

  disconnected() {
    console.log("❌ Disconnected from NotificationsChannel");
  },

  received(data) {
    const countEl = document.getElementById("notification-count");
    if (countEl) {
      let current = parseInt(countEl.textContent) || 0;
      countEl.textContent = current + 1;
    }

    const container = document.getElementById("notifications-list");
    if (container) {
      const placeholder = container.querySelector(".text-muted");
      if (placeholder) placeholder.remove();

      const item = document.createElement("a");
      item.className = "dropdown-item";
      item.href = "#";
      item.textContent = data.message;
      container.prepend(item);
    }
  }
});
