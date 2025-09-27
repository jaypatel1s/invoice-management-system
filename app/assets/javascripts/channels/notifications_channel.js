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
    const container = document.getElementById("notifications-list"); // notifications container
    if (container) {
      // Remove placeholder if exists
      const placeholder = container.querySelector(".dropdown-header");
      if (placeholder) placeholder.remove();

      // Count existing notifications (exclude footer and header)
      const items = container.querySelectorAll(".dropdown-item:not(.dropdown-header):not(.dropdown-footer)");
      const count = items.length + 1;

      // Create new notification HTML
      const notificationHTML = `
        <div class="dropdown-divider"></div>
        <a href="#" class="dropdown-item">
          ${data.message}
          <span class="float-end text-secondary fs-7">${data.time || "Just now"}</span>
        </a>
      `;

      // Insert new notification **before footer** if exists
      const footer = container.querySelector(".dropdown-footer");
      if (footer) {
        footer.insertAdjacentHTML("beforebegin", notificationHTML);
      } else {
        container.insertAdjacentHTML("beforeend", notificationHTML);
      }

      // Update or add header
      let header = container.querySelector(".dropdown-header");
      if (!header) {
        header = document.createElement("span");
        header.className = "dropdown-item dropdown-header";
        container.prepend(header);
      }
      header.textContent = `${count} Notification${count > 1 ? 's' : ''}`;
    }
  }
});
