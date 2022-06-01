Return-Path: <virtio-dev-return-9577-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 780629865A3
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Jun 2022 20:03:41 +0000 (UTC)
From: Patrick Mosca <pmosca@apple.com>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3709.0.7\))
Message-id: <6355541D-E117-4E7F-B5D9-3CD0028ED7FF@apple.com>
Date: Wed, 01 Jun 2022 13:03:27 -0700
Subject: [virtio-dev] Clarification of VIRTIO_F_EVENT_IDX driver conditions.
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: quoted-printable
To: Virtio-Dev <virtio-dev@lists.oasis-open.org>
Cc: Patrick Mosca <pmosca@apple.com>, Cameron Esfahani <dirty@apple.com>
List-ID: <virtio-dev.lists.oasis-open.org>

We ran into an edge case in the VIRTIO_F_EVENT_IDX feature where a notifica=
tion could be missed if there is a "streak" in skipped notifications. If th=
e difference between the event index and available index wraps before a not=
ification is needed, there exists a case where a notification must be sent =
but is not sent.


Signed-off-by: Patrick Mosca <pmosca@apple.com>
Signed-off-by: Cameron Esfahani <dirty@apple.com>
---
 split-ring.tex | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/split-ring.tex b/split-ring.tex
index bfef62d..9650e5e 100644
--- a/split-ring.tex
+++ b/split-ring.tex
@@ -530,6 +530,9 @@ \subsection{Available Buffer Notification Suppression}\=
label{sec:Basic Facilitie
         \item If the \field{idx} field in the available ring (which determ=
ined
           where that descriptor index was placed) was equal to
           \field{avail_event}, the driver MUST send a notification.
+        \item If the number of descriptors added to the queue since
+          the last notification is greater than 65535, the driver MUST
+          send a notification.
         \item Otherwise the driver SHOULD NOT send a notification.
   \end{itemize}
 \end{itemize}
--=20
2.32.0 (Apple Git-131)


-Patrick Mosca
---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

