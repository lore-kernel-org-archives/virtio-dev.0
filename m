Return-Path: <virtio-dev-return-9525-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4719E98655B
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 May 2022 13:10:46 +0000 (UTC)
Date: Tue, 10 May 2022 09:10:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220510131037.96989-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] editorial: update S390 Common I/O link
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org, Paul Knight <paul.knight@oasis-open.org>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Paul Knight wrote:

In running a link check, I noted several issues, none significant for this
initial public review publication:
- broken link in Normative references:
-- [S390 Common I/O] ESA/390 Common I/O-Device and Self-Description, IBM
Publication SA22-7204,
http://publibfp.dhe.ibm.com/cgi-bin/bookmgr/BOOKS/dz9ar501/CCONTENTS, and any
future revisions
(This link is currently broken, and I could not find any alternative source for
this document. - please rewrite the reference to indicate document is no longer
available at this link. You may also consider whether the solitary citation at
4.3.1.3 is still needed.)
This broken link is not a blocking issue for a Committee specification Draft,
but it will not be allowed for a Committee Specification.

Reported-by: Paul Knight <paul.knight@oasis-open.org>
Suggested-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 introduction.tex | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/introduction.tex b/introduction.tex
index 4dc7085..0a78e78 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -45,7 +45,8 @@ \section{Normative References}\label{sec:Normative References}
 IDentifier (UUID) URN Namespace'', RFC 4122, DOI 10.17487/RFC4122,
 July 2005. \newline\url{http://www.ietf.org/rfc/rfc4122.txt}\\
 	\phantomsection\label{intro:S390 PoP}\textbf{[S390 PoP]} & z/Architecture Principles of Operation, IBM Publication SA22-7832, \newline\url{http://publibfi.boulder.ibm.com/epubs/pdf/dz9zr009.pdf}, and any future revisions\\
-	\phantomsection\label{intro:S390 Common I/O}\textbf{[S390 Common I/O]} & ESA/390 Common I/O-Device and Self-Description, IBM Publication SA22-7204, \newline\url{http://publibfp.dhe.ibm.com/cgi-bin/bookmgr/BOOKS/dz9ar501/CCONTENTS}, and any future revisions\\
+	\phantomsection\label{intro:S390 Common I/O}\textbf{[S390
+Common I/O]} & ESA/390 Common I/O-Device and Self-Description, IBM Publication SA22-7204-01, \newline\url{https://www.ibm.com/resources/publications/OutputPubsDetails?PubID=SA22720401}, and any future revisions\\
 	\phantomsection\label{intro:PCI}\textbf{[PCI]} &
 	Conventional PCI Specifications,
 	\newline\url{http://www.pcisig.com/specifications/conventional/},
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

