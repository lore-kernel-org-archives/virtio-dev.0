Return-Path: virtio-dev-return-6314-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 17462985DE9
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Nov 2019 17:13:13 +0000 (UTC)
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4fa78a91-751d-a7b5-fadf-b0ae8a5d5903@siemens.com>
Date: Mon, 11 Nov 2019 18:13:10 +0100
MIME-Version: 1.0
Content-Language: en-US
Subject: [virtio-dev] [PATCH] split-ring: Demand that a device must not change descriptor
 entries
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

So far the spec only indirectly says that a descriptor table entry is
not modified by a device when processing it. Make this explicit by
adding it as normative requirement. Existing drivers already depend on
this.

See also https://lists.oasis-open.org/archives/virtio-dev/201910/msg00057.h=
tml.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 split-ring.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/split-ring.tex b/split-ring.tex
index 123ac9f..bfef62d 100644
--- a/split-ring.tex
+++ b/split-ring.tex
@@ -217,7 +217,7 @@ \subsection{The Virtqueue Descriptor Table}\label{sec:B=
asic Facilities of a Virt
 \devicenormative{\subsubsection}{The Virtqueue Descriptor Table}{Basic Fac=
ilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table}
 A device MUST NOT write to a device-readable buffer, and a device SHOULD N=
OT
 read a device-writable buffer (it MAY do so for debugging or diagnostic
-purposes).
+purposes). A device MUST NOT write to any descriptor table entry.
=20
 \drivernormative{\subsubsection}{The Virtqueue Descriptor Table}{Basic Fac=
ilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table}
 Drivers MUST NOT add a descriptor chain longer than $2^{32}$ bytes in tota=
l;
--=20
2.16.4

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

