Return-Path: virtio-return-2953-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 1 Mar 2018 01:31:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1519860484-7936-16-git-send-email-mst@redhat.com>
References: <1519860484-7936-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519860484-7936-1-git-send-email-mst@redhat.com>
Subject: [virtio] [PATCH v9 15/16] makediff: update to show diff from master
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Down the road, when we are close to releasing
v1.1 we will want to show diff from cs04. But for now,
it's handy to generate the diff from master,
this way each new feature is redlined separately.

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


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

