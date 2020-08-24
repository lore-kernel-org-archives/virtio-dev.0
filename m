Return-Path: virtio-dev-return-7718-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66A3A985DB2
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Aug 2020 14:38:55 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 24 Aug 2020 17:37:05 +0300
Message-Id: <20200824143708.5664-9-ndragazis@arrikto.com>
In-Reply-To: <20200824143708.5664-1-ndragazis@arrikto.com>
References: <20200824143708.5664-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH 08/11] notifications: Introduce device-specific notifications
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 content.tex | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index d6fc17e..661ebd9 100644
--- a/content.tex
+++ b/content.tex
@@ -165,11 +165,12 @@ \section{Notifications}\label{sec:Basic Facilities of a Virtio Device
 to driver) plays an important role in this specification. The
 modus operandi of the notifications is transport specific.
 
-There are three types of notifications: 
+There are four types of notifications:
 \begin{itemize}
 \item configuration change notification
 \item available buffer notification
-\item used buffer notification. 
+\item used buffer notification
+\item device-specific notification.
 \end{itemize}
 
 Configuration change notifications and used buffer notifications are sent
@@ -182,6 +183,11 @@ \section{Notifications}\label{sec:Basic Facilities of a Virtio Device
 the device. This type of notification indicates that a buffer may have
 been made available on the virtqueue designated by the notification.
 
+Device-specific notifications are sent by the device, the recipient is
+the driver. Their purpose is to allow the device to send notifications
+other than configuration changes and used buffer notifications. These
+notifications are optional and their meaning is device-specific.
+
 The semantics, the transport-specific implementations, and other
 important aspects of the different notifications are specified in detail
 in the following chapters.
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

