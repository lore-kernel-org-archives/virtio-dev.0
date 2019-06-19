Return-Path: virtio-return-3377-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 18 Jun 2019 20:38:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190619003657.9637-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH] README.md: describe preferred flow for comments
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: aadam@redhat.com, ybettan@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

We prefer receiving comments as patches.
Describe how to generate them.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Ariel, Yoni, does the following seem helpful to you?
Any comments?

 README.md | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index d40f095..3de0c1e 100644
--- a/README.md
+++ b/README.md
@@ -30,11 +30,40 @@
 
 <h3>Further Description of this Repository</h3>
 <h4>Providing Feedback</h4>
+Feedback must be provided the <strong>virtio-comment</strong> mailing list,
+and archived in the mailing list archives.
 <p>See <A
 HREF="https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback">
 https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback</A>
-<h4>Note for Contributors</h4>
-<p>Contributors should review TC specific
+<p>Note that only plain text part of the message is archived, and all
+attachments are stripped. Accordingly, messages sent to the
+mailing list should use text/plain encoding and not
+have any attachments.
+<p>The preferred form of providing feedback is in form of a patch.
+A patch can be generated and sent by cloning the spec repository,
+creating a commit, formatting it as a patch and then sending it.
+For example:
+<code>
+<p>
+git clone https://github.com/oasis-tcs/virtio-spec.git<br>
+... edit spec text, and save ...<br>
+<p>
+git commit -a<br>
+... describe the proposed change, in the following format:<br>
+single line summary<br>
+<br>
+detailed description, including motivation for the change<br>
+<br>
+Signed-off-by: Name &lt;email&gt;<br>
+... then save and close the editor ... <br>
+<p>
+git format-patch -o proposal1/ HEAD~1..<br>
+... generates a new directory proposal1/ and a file starting with 0001- ...<br>
+<p>
+git send-email --to=virtio-comment@lists.oasis-open.org proposal1/0001-*
+</code>
+<h4>Note for TC Members</h4>
+<p>TC Members should review TC specific
 process rules under "Further Description of this Repository"
 in <A
 HREF="https://github.com/oasis-tcs/virtio-admin">https://github.com/oasis-tcs/virtio-admin</A>.
-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

