Return-Path: <virtio-dev-return-9411-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A12A986401
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Apr 2022 15:54:31 +0000 (UTC)
Date: Tue, 19 Apr 2022 11:54:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220419155421.132831-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] content.tex: drop space after \field
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

always use \field{foo} not \field {foo}, the latter confuses
latexdiff.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 8f9173d..741d166 100644
--- a/content.tex
+++ b/content.tex
@@ -874,7 +874,7 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
 \end{lstlisting}
 
 Given that the \field{cap.length} and \field{cap.offset} fields
-are only 32 bit, the additional \field{offset_hi} and \field {length_hi}
+are only 32 bit, the additional \field{offset_hi} and \field{length_hi}
 fields provide the most significant 32 bits of a total 64 bit offset and
 length within the BAR specified by \field{cap.bar}.
 
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

