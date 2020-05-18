Return-Path: virtio-dev-return-7370-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DE026986055
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 May 2020 20:38:42 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 18 May 2020 23:37:21 +0300
Message-Id: <20200518203721.7625-11-ndragazis@arrikto.com>
In-Reply-To: <20200518203721.7625-1-ndragazis@arrikto.com>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH v5 10/10] vhost-user: clarify that we are talking about slave-initiated messages
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 virtio-vhost-user.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
index 328baec..6bcc6af 100644
--- a/virtio-vhost-user.tex
+++ b/virtio-vhost-user.tex
@@ -220,7 +220,7 @@ \subsubsection{Availability of Additional Resources}\label{sec:Device Types / Vh
 \item[VHOST_USER_SET_VRING_KICK] The vring kick notification for this queue is available to the driver.  The first notification may occur before the driver has processed this message.
 \item[VHOST_USER_SET_VRING_CALL] The vring call doorbell for this queue is available to the driver.  Writes to the vring call doorbell before this message is received produce no effect.
 \item[VHOST_USER_SET_VRING_ERR] The vring err doorbell for this queue is available to the driver.  Writes to the vring err doorbell before this message is received produce no effect.
-\item[VHOST_USER_SET_SLAVE_REQ_FD] The driver may send vhost-user protocol slave messages on txq.  Buffers put onto txq before this message is received are discarded by the device.
+\item[VHOST_USER_SET_SLAVE_REQ_FD] The driver may send vhost-user protocol slave messages on txq.  Slave-initiated messages put onto txq before this message is received are discarded by the device.
 \end{description}
 
 \subsubsection{Doorbell layout}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources / Doorbell layout}
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

