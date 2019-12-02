Return-Path: virtio-return-3420-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 2 Dec 2019 12:08:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191202170827.256143-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] [PATCH] README.md: document use of virtio-dev
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
 README.md | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/README.md b/README.md
index ffafb9b..1b72dc3 100644
--- a/README.md
+++ b/README.md
@@ -157,6 +157,17 @@ issue is resolved under the minor cleanups standing ru=
le.
 and asking for a commit. </li>
 </ol>
=20
+<h4>Implementation discussion</h4>
+Implementations should be discussed on the <strong>virtio-dev</strong> mai=
ling list,
+and are archived in the mailing list archives.
+<p>See <A
+HREF=3D"https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=3Dvirt=
io#feedback">
+https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=3Dvirtio#feedb=
ack</A>
+<p>This is the correct list to copy on Linux virtio UAPI change proposals.
+<p>Note that only plain text part of the message is archived, and all
+attachments are stripped. Accordingly, messages sent to the
+mailing list should use text/plain encoding and not
+have any attachments.
 <h3>Contact</h3>
 <p>Please send questions or comments about <a href=3D"https://www.oasis-op=
en.org/resources/tcadmin/github-repositories-for-oasis-tc-members-chartered=
-work">OASIS TC GitHub repositories</a> to <a href=3D"mailto:robin@oasis-op=
en.org">Robin Cover</a> and <a href=3D"mailto:chet.ensign@oasis-open.org">C=
het Ensign</a>.  For questions about content in this repository, please con=
tact the TC Chair or Co-Chairs as listed on the the virtio TC's <a href=3D"=
https://www.oasis-open.org/committees/virtio/">home page</a>.</p>
 </div>
--=20
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that=20
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

