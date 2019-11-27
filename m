Return-Path: virtio-return-3416-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 27 Nov 2019 16:28:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191127212728.33826-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] [PATCH] virtio_pci_cap64: bar/BAR cleanups
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org, Christophe de Dinechin <cdupontd@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

When we mean PCI register we should say BAR.
When we mean a virtio config register we should say \field{cap.bar}.

Finally, offset_hi/length_hi are not within the cap structure.

Reported-by: Christophe de Dinechin <cdupontd@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/content.tex b/content.tex
index d68cfaf..75cab0a 100644
--- a/content.tex
+++ b/content.tex
@@ -763,7 +763,7 @@ \subsection{Virtio Structure PCI Capabilities}\label{se=
c:Virtio Transport Option
 Given that the \field{cap.length} and \field{cap.offset} fields
 are only 32 bit, the additional \field{offset_hi} and \field {length_hi}
 fields provide the most significant 32 bits of a total 64 bit offset and
-length within the bar specified by \field{cap.bar}.
+length within the BAR specified by \field{cap.bar}.
=20
 \drivernormative{\subsubsection}{Virtio Structure PCI Capabilities}{Virtio=
 Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilitie=
s}
=20
@@ -1093,9 +1093,9 @@ \subsubsection{Shared memory capability}\label{sec:Vi=
rtio Transport Options / Vi
=20
 \devicenormative{\paragraph}{Device-specific configuration}{Virtio Transpo=
rt Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capabi=
lity}
=20
-The region defined by the combination of the \field {cap.offset},
-\field {cap.offset_hi}, and \field {cap.length}, \field
-{cap.length_hi} fields MUST be contained within the declared bar.
+The region defined by the combination of the \field{cap.offset},
+\field{offset_hi}, and \field {cap.length}, \field{length_hi} fields
+MUST be contained within the BAR specified by \field{cap.bar}.
=20
 The \field{cap.id} MUST be unique for any one device instance.
=20
--=20
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that=20
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

