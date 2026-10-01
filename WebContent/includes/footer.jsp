<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String footerContext = request.getContextPath();
%>
<footer class="footer" role="contentinfo">
  <div class="container footer-content">
    <div>
      <p class="font-bold" style="margin-bottom: 0.25rem; color: #0041C2 ; text-align: center;">SkillShareHub</p>
      <p class="text-muted" style="margin-bottom: 0; font-size: 0.85rem;">Learn Together, <span style="color: #7FFF00;">Grow Together</span>. A peer-to-peer learning network.</p>
    </div>

    <div style="display: flex; gap: 1.5rem; align-items: center; font-size: 0.875rem;">
      <a href="<%= footerContext %>/pages/skills" class="text-muted">Skills</a>
      <a href="<%= footerContext %>/pages/my-skills" class="text-muted">My Skills</a>
      <a href="<%= footerContext %>/pages/requests" class="text-muted">Request</a>
      <a href="<%= footerContext %>/pages/profile" class="text-muted">Profile</a>
    </div>

    <div>
      <p class="text-muted" style="margin-bottom: 0; font-size: 0.8rem;">
        &copy; <%= java.time.Year.now().getValue() %> SkillShareHub. Built for student collaboration.
      </p>
    </div>
  </div>
</footer>

<!-- Theme Persistence & Mobile Navigation Script  -->
<script>
  (function() {
    // 1. Theme Management (System + LocalStorage)
    var savedTheme = localStorage.getItem('ssh_theme');
    var systemPrefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    var currentTheme = savedTheme || (systemPrefersDark ? 'dark' : 'light');
    
    document.documentElement.setAttribute('data-theme', currentTheme);

    function updateThemeIcons(theme) {
      var icon = document.getElementById('themeIcon');
      if (icon) {
        icon.textContent = theme === 'dark' ? '☀️' : '🌙';
      }
    }

    updateThemeIcons(currentTheme);

    var toggleBtn = document.getElementById('themeToggleBtn');
    if (toggleBtn) {
      toggleBtn.addEventListener('click', function() {
        var activeTheme = document.documentElement.getAttribute('data-theme');
        var nextTheme = activeTheme === 'dark' ? 'light' : 'dark';
        document.documentElement.setAttribute('data-theme', nextTheme);
        localStorage.setItem('ssh_theme', nextTheme);
        updateThemeIcons(nextTheme);
      });
    }

    // 2. Mobile Drawer Navigation Toggle
    var menuBtn = document.getElementById('mobileMenuBtn');
    var navLinks = document.getElementById('navLinks');
    if (menuBtn && navLinks) {
      menuBtn.addEventListener('click', function() {
        var isOpen = navLinks.classList.toggle('is-open');
        var hamburger = document.getElementById('hamburgerIcon');
        if (hamburger) {
          hamburger.textContent = isOpen ? '✕' : '☰';
        }
      });
    }
  })();
</script>