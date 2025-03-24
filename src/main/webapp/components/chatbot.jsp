<% if(!request.getRequestURI().contains("quizQuestions.jsp")) { %>
<div style="position: fixed; bottom: 20px; right: 20px;">
    <button onclick="toggleChat()">Chat</button>
    <div id="chatWindow" style="display: none;">
        <div id="chatMessages"></div>
        <input type="text" id="chatInput">
        <button onclick="sendMessage()">Send</button>
    </div>
</div>
<script>
    function toggleChat() {
        const chatWindow = document.getElementById("chatWindow");
        chatWindow.style.display = chatWindow.style.display === 'none' ? 'block' : 'none';
    }
</script>
<% } %>