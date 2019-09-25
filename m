Return-Path: virtio-return-3383-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 25 Sep 2019 07:50:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190925115047.8278-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [virtio] [PATCH] README.md: clean up build instructions
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Switch to <DL> from manual formatting with <BR> and <P>.
Clarify wording a bit.
Add hints on what to do in case of missing fonts.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 README.md | 56 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/README.md b/README.md
index 5ac84f9..96d41c0 100644
--- a/README.md
+++ b/README.md
@@ -30,33 +30,51 @@
=20
 <h3>Further Description of this Repository</h3>
 <h4>Building Instructions</h4>
-<p>In order to build the spec you will need <a href=3D"https://www.tug.org=
/texlive/">Tex-Live</a>.
-Installing it can be done via:<br>
-Fedora:
+Authoritative version of the specification is maintained in the
+TeX document format. PDF and HTML versions are made available for
+ease of use and review.
+In order to build the HTML and PDF versions of the spec you will need the
+<a href=3D"https://www.tug.org/"> TeX document production system</a>.
+The easiest way to get it up and running is probably by installing
+<a href=3D"https://www.tug.org/texlive/">Tex-Live</a>.
+
+<dl>Installation cheat sheet:
+<dt>Fedora:</dt>
+<dd>
 <code>
 sudo dnf install texlive-scheme-full
-</code><br>
-Ubuntu:
+</code></dd>
+<dt>
+Ubuntu and other Debian derivatives:
+</dt>
+<dd>
 <code>
 sudo apt-get install texlive-full
-</code><br></p>
-<p>OSX users don't need to install Tex-Live because they already have
+</code></dd>
+<dt>OSX:<dt>
+<dd>OSX users don't need to install Tex-Live because they already have
 <a href=3D"http://www.tug.org/mactex/">MacTex</a> installed.
-
-<p>The building proccess is done with
+</dd>
+</dl>
+<dl>The build process generates a ZIP package file including the
+original TeX sources, as well as HTML and PDF formatted
+versions of the specification.
+<dt>To generate the ZIP package, run:<dt>
+<dd>
 <code>
 ./makeall.sh
 </code>
-and it contains 3 main parts:
-<code>
-makezip.sh
-</code>,
-<code>
-makehtml.sh
-</code>,
-<code>
-makepdf.sh
-</code>.
+</dd>
+<dt>Troubleshooting notes:</dt>
+<dd> PDFs of the specification can be generated with
+either MicroSoft's Core fonts for the Web: Arial and Courier New,
+or Liberation fonts: Liberation Sans and Liberation Mono.
+Most systems come with one of these two variants included:
+should you get an error message about missing fonts,
+you will need to downloads and install one of the above
+font packages.
+<dd>
+</dl>
 <h4>Providing Feedback</h4>
 Feedback must be provided the <strong>virtio-comment</strong> mailing list=
,
 and archived in the mailing list archives.
--=20
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

