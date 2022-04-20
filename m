Return-Path: <virtio-dev-return-9422-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C63E986560
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Apr 2022 17:32:38 +0000 (UTC)
Date: Wed, 20 Apr 2022 13:32:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220420173229.4935-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] makediffall: fix file name in the message printed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 makediffall.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/makediffall.sh b/makediffall.sh
index caff23e..0c064db 100755
--- a/makediffall.sh
+++ b/makediffall.sh
@@ -7,7 +7,7 @@ mv -f $SPECDOC.zip $SPECDOC-diff-from-${FROMVERSION}.pdf
 ./makediffpdf.sh
 zip $SPECDOC-diff-from-${FROMVERSION}.zip \
 	$SPECDOC-diff-from-${FROMVERSION}.pdf
-echo Generated file $SPECDOC.zip
+echo Generated file $SPECDOC-diff-from-${FROMVERSION}.zip
 echo To change output file name, set SPECDOC environment variable
 echo Examples:
 echo     SPECDOC=virtio-v1.0-wd01 $0
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

