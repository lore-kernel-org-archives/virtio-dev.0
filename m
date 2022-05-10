Return-Path: <virtio-dev-return-9522-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55C589864DB
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 May 2022 05:36:00 +0000 (UTC)
Date: Tue, 10 May 2022 01:35:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220510053552.69669-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] editorial: use bold for title and headings
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org, Paul Knight <paul.knight@oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Paul Knight reported:

- (HTML only) To conform to OASIS style, this should use bold font in title and
headings from top through "Notices"
-- I noted that in the HTML file, these headings use class="aeb10-", but this
is not defined in the .css file.
-- For this publication, I defined it by inserting the line below into the .css
file (virtio-v1.2-csd01.css, at line 18), which fixed this issue:
--- .aeb10-{font-weight: bold;}

make this adjustment in makehtml.sh for the future.

Reported-by: Paul Knight <paul.knight@oasis-open.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 makehtml.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/makehtml.sh b/makehtml.sh
index a19fc34..45b7080 100755
--- a/makehtml.sh
+++ b/makehtml.sh
@@ -22,12 +22,18 @@ sed 's/~</"</g' $SPECDOC.tmp4 >$SPECDOC.tmp5
 #drop width/height limits from the logo.
 sed '/oasis.png/{n;s/^width="39" height="39" >/ >/}' $SPECDOC.tmp5 >$SPECDOC.tmp6
 
+#To conform to OASIS style, this should use bold font in title and
+#headings from top through "Notices"
+#these headings use class="aeb10-", but this
+#is not defined in the .css file
+sed '/start css.sty/a .aeb10-{font-weight: bold;}' $SPECDOC.tmp6 >$SPECDOC.tmp7
+
 # If font paths are misconfigured, we get ligatures
 # (such as 'ff or 'fi') replaced by NULL character in output.
 # This in not a valid HTML output, so detect this and warn user.
 # For detection, we rely on the fact that file utility
 # recognizes files with NULL characters as binary data.
-if test "$(file -b $SPECDOC.tmp5)" = 'data';
+if test "$(file -b $SPECDOC.tmp7)" = 'data';
 then
 	echo 
 	echo WARNING!
@@ -44,7 +50,7 @@ then
 	echo 
 fi
 
-mv $SPECDOC.tmp6 $SPECDOC.html
+mv $SPECDOC.tmp7 $SPECDOC.html
 rm $SPECDOC.tmp*
 
 #uncomment if you have a broken t4ht
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

