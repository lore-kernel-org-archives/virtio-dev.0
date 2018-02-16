Return-Path: SRS0=KMw5=FK=redhat.com=mst@kernel.org
Date: Fri, 16 Feb 2018 09:25:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 12/16] makediff: update to show diff from master
Message-ID: <20180216092540-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518765602-8739-1-git-send-email-mst@redhat.com>
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 makediff.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/makediff.sh b/makediff.sh
index 1dd75d4..2ef92fc 100755
--- a/makediff.sh
+++ b/makediff.sh
@@ -9,7 +9,7 @@ export DATESTR=${DATESTR:-`cat REVISION-DATE`}
 MAIN=$1
 PATH=.:${PATH}
 cur="$PWD"
-oldrev=`git rev-list -1 origin/tags/v1.0-cs03`
+oldrev=`git rev-list -1 origin/master`
 newrev=`git rev-list -1 HEAD`
 rm -fr old new
 git clone $PWD old
@@ -19,7 +19,6 @@ while read -r rev; do
 	echo "Applying $rev"
 	git cherry-pick `git rev-list -1 -F --grep "$rev" $newrev` || exit 1
 done << 'EOF'
-headerfile: rename virtio_ring to virtio queue
 EOF
 
 #mv specvars.tex specvars-orig.tex
-- 
MST

