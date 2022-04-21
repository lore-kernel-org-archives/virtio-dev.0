Return-Path: <virtio-comment-return-2967-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 21 Apr 2022 11:29:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220421152920.37374-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH] make-setup-generated.sh: get version from spec string
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 make-setup-generated.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/make-setup-generated.sh b/make-setup-generated.sh
index f15d148..2c5c7f8 100755
--- a/make-setup-generated.sh
+++ b/make-setup-generated.sh
@@ -1,6 +1,5 @@
 #! /bin/sh
 
-VERSION=1.1
 DATESTR=${DATESTR:-`cat REVISION-DATE 2>/dev/null`}
 if [ x"$DATESTR" = x ]; then
     ISODATE=`git show --format=format:'%cd' --date=iso | head -n 1`
@@ -40,6 +39,8 @@ case "$1" in
 	exit 1
 esac
 
+VERSION=`echo "$1"| sed -e 's/virtio-v//' -e 's/-.*//'`
+
 #Prepend OASIS unless already there
 case "$STAGENAME" in
 	OASIS*)
-- 
MST


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

