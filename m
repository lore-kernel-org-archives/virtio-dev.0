Return-Path: virtio-dev-return-8142-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0CF9A983C43
	for <virtio-dev@lists.oasis-open.org>; Sun, 25 Apr 2021 12:09:54 +0000 (UTC)
From: Marcel Holtmann <marcel@holtmann.org>
Date: Sun, 25 Apr 2021 14:09:47 +0200
Message-Id: <20210425120947.3129-1-marcel@holtmann.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] Reserve device id for Bluetooth device
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Use device ID 40

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index 9232d5c4dde9..e02afafe5c87 100644
--- a/content.tex
+++ b/content.tex
@@ -2874,6 +2874,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 39         &   Audio policy device \\
 \hline
+40         &   Bluetooth device \\
+\hline
 \end{tabular}
=20
 Some of the devices above are unspecified by this document,
--=20
2.30.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

