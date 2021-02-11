package com.mycafe.kiosk;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Controller;

import com.mycafe.beans.ClientDto;
import com.mycafe.dao.OderDao;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.websocket.Session;

@Controller
@ServerEndpoint(value = "/webChatServer")
public class WebSoketServer extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static Map<Session, ClientDto> users = Collections.synchronizedMap(new HashMap<Session, ClientDto>());
	// 받아온 메시지를 넘겨줌
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
	// 서버가 오픈되면 실행되는 메서드
	@OnOpen
	public void onOpen(Session session) {
		ClientDto client = new ClientDto();
		client.setName(ClientDto.getinstance().getName());
		System.out.println(session + " connect");
		users.put(session, client);
	}
	// 서버가 닫히면 실행되는 메서드
	@OnClose
	public void onClose(Session session) {
		users.remove(session);
	}

}