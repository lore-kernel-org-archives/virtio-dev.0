Return-Path: <virtio-dev-return-9521-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83C4C9864E1
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 May 2022 05:29:39 +0000 (UTC)
Date: Tue, 10 May 2022 01:29:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220510052929.69133-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] changelog editorial fixes
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org, Paul Knight <paul.knight@oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Paul Knight reports:

Minor broken links in the "Revision History" - Appendix D
- https://lists.oasis-open.org/archives/virtio-dev/201910/msg00057.html. (b=
ad
link due to inclusion of the terminating period - second item dated 01 Sep =
2020
in Appendix D Revision history) - not a blocking issue
- =C2=A0https://lkml.org/lkml/2020/4/21/1020) (bad link due to including th=
e final
right parenthesis in the hyperlink - item dated 01 Sep 2020 by Petre Eftime=
) -
not a blocking issue
- https://github.org/oasis-tcs/virtio-spec/issues/97 =C2=A0(bad link due to=
 using
github.org instead of github.com - first item dated 30 Mar 2021 in Appendix=
 D
Revision history) - not a blocking issue

Reported-by: Paul Knight <paul.knight@oasis-open.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 cl-os.tex | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cl-os.tex b/cl-os.tex
index fa980b2..5ae8a7b 100644
--- a/cl-os.tex
+++ b/cl-os.tex
@@ -688,7 +688,7 @@
 adding it as normative requirement. Existing drivers already depend on
 this.
=20
-See also \url{https://lists.oasis-open.org/archives/virtio-dev/201910/msg0=
0057.html.}
+See also \url{https://lists.oasis-open.org/archives/virtio-dev/201910/msg0=
0057.html}.
=20
 Fixes: \url{https://github.com/oasis-tcs/virtio-spec/issues/56}
=20
@@ -807,7 +807,7 @@
=20
 The NitroSecureModule is a device with a very stripped down
 Trusted Platform Module functionality, which is used in the
-context of a Nitro Enclave (see \url{https://lkml.org/lkml/2020/4/21/1020)=
}
+context of a Nitro Enclave (see \url{https://lkml.org/lkml/2020/4/21/1020}=
)
 to provide boot time measurement and attestation.
=20
 Since this device provides some critical cryptographic operations,
@@ -1326,7 +1326,7 @@
=20
 Signed-off-by: Enrico Granata <egranata@google.com>
=20
-Fixes: \url{https://github.org/oasis-tcs/virtio-spec/issues/97}
+Fixes: \url{https://github.com/oasis-tcs/virtio-spec/issues/97}
=20
 Signed-off-by: Cornelia Huck <cohuck@redhat.com>
=20
--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

