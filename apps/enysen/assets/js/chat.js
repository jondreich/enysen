let topic = window.location.pathname
let Chat = {
  init(socket){
    let channel = socket.channel(`user_chat:${topic.replace("/", "")}`, {})
    channel.join()
    this.listenForChat(channel, window.currentUserUsername)
  },
  listenForChat(channel, currentUserUsername){
    if(currentUserUsername != ""){
      document.getElementById('chat-form').addEventListener('submit', function(e){
        e.preventDefault()

        let userMessage = document.getElementById('chat-textarea').value

        channel.push('shout', {name: currentUserUsername, body: userMessage})

        document.getElementById('chat-textarea').value = ""
      })
    }

    channel.on('shout', payload => {
      let chatBox = document.querySelector('#chat-box')
      let messageBlock = document.createElement('p')

      messageBlock.insertAdjacentHTML('beforeend', `<b>${payload.name}:</b> ${payload.body}`)
      chatBox.appendChild(messageBlock)
    })
  }
}

export default Chat