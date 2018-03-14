Return-Path: virtio-return-3010-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 14 Mar 2018 05:32:14 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1520998320-264512-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH] github: PULL_REQUEST_TEMPLATE.md
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Document that we don't accept pull requests at this point.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 .github/PULL_REQUEST_TEMPLATE.md | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 .github/PULL_REQUEST_TEMPLATE.md

diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEMPLATE.md
new file mode 100644
index 0000000..69d41fc
--- /dev/null
+++ b/.github/PULL_REQUEST_TEMPLATE.md
@@ -0,0 +1,10 @@
+# Thanks for proposing a change to the Virtual I/O Device (VIRTIO) specification!
+The VIRTIO TC is not yet accepting pull requests at this time as they are not
+integrated with our voting system.
+
+Instead, please
+- [] Propose the spec change (preferably as a patch) on the [mailing list](https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback).
+- [] Open an [issue](https://github.com/oasis-tcs/virtio-spec/issues),
+     including the link to the proposal in the [mailing list archives](https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback).
+
+The TC will vote and apply the change.
-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

