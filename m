Return-Path: virtio-return-3422-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 3 Dec 2019 00:42:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191203054156.421246-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] [PATCH v2] README.md: document use of virtio-dev
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

People still seem to be confused which list is for what.
Add a bit more text.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Changes from v1:
=09- wording changes to address Cornelia's comments
=09- move to near virtio-comment description

 README.md | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/README.md b/README.md
index ffafb9b..2bdf485 100644
--- a/README.md
+++ b/README.md
@@ -115,6 +115,17 @@ in <A
 HREF=3D"https://github.com/oasis-tcs/virtio-admin">https://github.com/oasi=
s-tcs/virtio-admin</A>.
=20
 </div>
+<h4>Implementation discussion</h4>
+Implementation discussion should take place on the <strong>virtio-dev</str=
ong> mailing list,
+and be archived in the mailing list archives.
+<p>See <A
+HREF=3D"https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=3Dvirt=
io#feedback">
+https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=3Dvirtio#feedb=
ack</A>
+<p>This is the correct list to copy on Linux virtio UAPI change proposals.
+<p>Note that only the plain text part of the message is archived, and all
+attachments are stripped. Accordingly, messages sent to the
+mailing list should use text/plain encoding and not
+have any attachments.
 <h4>Use of github issues</h4>
 Note: according to the virtio TC rules, all official TC communication
 is taking place on one of the TC mailing lists.
--=20
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that=20
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

