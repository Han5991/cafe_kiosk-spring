# cafe_kiosk(websoket)
websoket for README.md


# 0. 기술 스택

java:1.8  
tomcat : 9.0  
oracle 11g  
jsp : 4.0  

# 1. 사용방법
1. store1 계정으로 접속시 나오는 화면  
     고객의 주문을 한 방향으로만 진행이 되고 마지막 결제 완료 페이지에서 신용카드를 뽑는 행위를 통해 주문 번호를 전송하게 됩니다.  
[동영상 주소](https://www.youtube.com/watch?v=7WEcxfdX_xg)  
2. admin 계정으로 접속시 나오는 화면  
     관리자가 admin 계정으로 접속시 주문 접수 페이지가 시작하게 되면서 바로 웹소켓으로 접속을 하게 됩니다. 그리고 그 페이지에서 주문이 들어오는 동시에 관리자가 주문을 받아 볼 수 있습니다.  
[동영상 주소](https://www.youtube.com/watch?v=F9Fngsvg4_A)
---


# 2. 웹소켓을 이용한 코드
```swift
@Controller
@ServerEndpoint(value = "/webChatServer")
public class WebChatServer extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static Map<Session, ClientDto> users = Collections.synchronizedMap(new HashMap<Session, ClientDto>());

	@OnMessage
	public void onMsg(String message, Session session) throws IOException {
		message = OderDao.getInstance().getOneOder(message);
		synchronized (users) {
			Iterator<Session> it = users.keySet().iterator();
			while (it.hasNext()) {
				Session currentSession = it.next();
				currentSession.getBasicRemote().sendText(message);
			}
		}
	}

	@OnOpen
	public void onOpen(Session session) {

		ClientDto client = new ClientDto();

		client.setName(ClientDto.getinstance().getName());
		if (client.getName().equals("admin"))
			WebChatServer.session = session;

		System.out.println(session + " connect");

		users.put(session, client);
	}


	@OnClose
	public void onClose(Session session) {
		String userName = users.get(session).getName();
		users.remove(session);
	}

}
```
관리자의 웹소켓 접속 
```swift
<script type="text/javascript">
	var num = 0;
	$("#delete").click(function() {
		if (confirm("정말 취소하시겠습니까 ?") == true) {
			location.href = "deleteOder.do?odernum=" + num;
			alert("취소되었습니다");
		} else {
			return;
		}
	});
	$("#start").click(function() {
		if (confirm("조리가 완료 되었습니까?") == true) {
			location.href = "startOder.do?odernum=" + num;
			alert("조리가 완료되었습니다");
		} else {
			return;
		}
	});
	$('.oderNum').click(function() {
		var n = $('.oderNum').index(this);
		num = $("input[name=oderNum]:eq(" + n + ")").val();
	});
	var webSocket = new WebSocket('ws://localhost:8080/webChatServer');

	webSocket.onerror = function(e) {
		onError(e);
	};
	webSocket.onopen = function(e) {
		onOpen(e);
	};
	webSocket.onmessage = function(e) {
		onMessage(e);
	};

	function onMessage(e) {
		var chatMsg = event.data;

		var chatMsgs = chatMsg.split(",");

		var $chat = "<li class='oderNum'>주문번호 : "
				+ chatMsgs[chatMsgs.length - 4]
				+ "<input name='oderNum' type='hidden' value='"+chatMsgs[chatMsgs.length-4]+"'> <br> 주문시각 : "
				+ chatMsgs[chatMsgs.length - 3]
				+ "<br>주문상태 : "
				+ chatMsgs[chatMsgs.length - 1]
				+ "<br> <input type='button' value='주문목록 보기' class='oderdetail'><table class='detail'>";

		var $chat2 = ""
		for (var i = 0; i < chatMsgs.length - 4; i++) {
			$chat2 += "<tr><td>" + chatMsgs[i] + "</td><td>" + chatMsgs[++i]
					+ "</td></tr>";
		}

		var $chat3 = "</table><p>총계 : " + chatMsgs[chatMsgs.length - 2]
				+ "원</li>";

		$('#ul').append($chat + $chat2 + $chat3);

		$('.oderNum').click(function() {
			var n = $('.oderNum').index(this);
			num = $("input[name=oderNum]:eq(" + n + ")").val();
		});
	}

	function onOpen(e) {
	}

	function onError(e) {
		alert(e.data);
	}

	function send() {
	}
	function print() {
		var url = "receiptPrint.do?odernum=" + num;
		window
				.open(url, "receiptPrint",
						"toolbar=no, menubar=no,scrollbar=yes, resizable=no, width=450,height=800");
	}
```
고객의 웹소켓 접속 자바스크립트
```swift
<script type="text/javascript">
	if (
<%=odernum%>
	== 0) {
		alert("결제에 실패하였습니다.");
		history.back();
	}
	var webSocket = new WebSocket('ws://localhost:8080/webChatServer');
	webSocket.onerror = function(e) {
		onError(e);
	};
	webSocket.onopen = function(e) {
		onOpen(e);
	};
	webSocket.onmessage = function(e) {
		onMessage(e);
	};

	function onMessage(e) {
	}

	function onOpen(e) {
	}

	function onError(e) {
		alert(e.data);
	}
	function send() {
		var chatMsg = $('input[name=odernum]').val();
		webSocket.send(chatMsg);
	}
	$('#btn-submit').click(function() {
		send();
		$('#pop').hide();
	});
</script>

```
