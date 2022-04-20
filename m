Return-Path: <virtio-return-3704-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 20 Apr 2022 13:15:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220420171550.3609-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] [PATCH] fixupdiff: reverse add/del for code snippets
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Turns out added/deleted versions for code snippets
were reversed and no one noticed. Fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 fixupdiff.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fixupdiff.pl b/fixupdiff.pl
index e7d3a0f..1c6b8e2 100644
--- a/fixupdiff.pl
+++ b/fixupdiff.pl
@@ -40,9 +40,9 @@ while (<>) {
 			#also at beginning of line
 			$line =~ s/^(\^)/\\$1/g;
 			if ($add) {
-				$line =~ s/(.*)/\$\\DIFdel\{$1\}\$/;
-			} else {
 				$line =~ s/(.*)/\$\\DIFadd\{$1\}\$/;
+			} else {
+				$line =~ s/(.*)/\$\\DIFdel\{$1\}\$/;
 			}
 		}
 		#print "%FIXED BY RULE 1\n";
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

