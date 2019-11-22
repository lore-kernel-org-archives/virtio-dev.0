Return-Path: virtio-dev-return-6384-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 699AB985EC4
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 14:48:36 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Nov 2019 14:48:23 +0000
Message-Id: <20191122144824.483847-2-stefanha@redhat.com>
In-Reply-To: <20191122144824.483847-1-stefanha@redhat.com>
References: <20191122144824.483847-1-stefanha@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 1/2] virtio-fs: add file system device to Conformance chapter
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: mszeredi@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, vgoyal@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The file system device is not listed in the Conformance chapter.  Fix
this.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 conformance.tex | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/conformance.tex b/conformance.tex
index 0ac58aa..25d11ec 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -183,6 +183,16 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \item \ref{drivernormative:Device Types / Socket Device / Device Operation=
 / Device Events}
 \end{itemize}
=20
+\conformance{\subsection}{File System Driver Conformance}\label{sec:Confor=
mance / Driver Conformance / File System Driver Conformance}
+
+A file system driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / File System Device / Device conf=
iguration layout}
+\item \ref{drivernormative:Device Types / File System Device / Device Oper=
ation / Device Operation: High Priority Queue}
+\item \ref{drivernormative:Device Types / File System Device / Device Oper=
ation / Device Operation: DAX Window}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device =
Conformance}
=20
 A device MUST conform to the following normative statements:
@@ -338,6 +348,16 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \item \ref{devicenormative:Device Types / Socket Device / Device Operation=
 / Receive and Transmit}
 \end{itemize}
=20
+\conformance{\subsection}{File System Device Conformance}\label{sec:Confor=
mance / Device Conformance / File System Device Conformance}
+
+A file system device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / File System Device / Device conf=
iguration layout}
+\item \ref{devicenormative:Device Types / File System Device / Device Oper=
ation / Device Operation: High Priority Queue}
+\item \ref{devicenormative:Device Types / File System Device / Device Oper=
ation / Device Operation: DAX Window}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitio=
nal Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitio=
nal Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
--=20
2.23.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

