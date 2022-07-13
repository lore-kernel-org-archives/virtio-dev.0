Return-Path: <virtio-return-3804-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 13 Jul 2022 16:51:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220713205126.406514-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] [PATCH] editorial: introduction: fix IBM link
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org, Paul Knight <paul.knight@oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

OLD

[S390    z/Architecture Principles of Operation, IBM Publication SA22-7832,
PoP]     http://publibfi.boulder.ibm.com/epubs/pdf/dz9zr009.pdf, and any fu=
ture
         revisions=C2=A0=C2=A0

NEW (should be)

[S390 PoP] z/Architecture Principles of Operation, IBM Publication SA22-783=
2,
https://www.ibm.com/docs/en/SSQ2R2_15.0.0/com.ibm.tpf.toolkit.hlasm.doc/
dz9zr006.pdf, and any future revisions

[only changes the hyperlink]

Reported-by: Paul Knight <paul.knight@oasis-open.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 introduction.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/introduction.tex b/introduction.tex
index aa9ec1b..a9491cf 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -44,7 +44,7 @@ \section{Normative References}\label{sec:Normative Refere=
nces}
 Leach, P., Mealling, M., and R. Salz, ``A Universally Unique
 IDentifier (UUID) URN Namespace'', RFC 4122, DOI 10.17487/RFC4122,
 July 2005. \newline\url{http://www.ietf.org/rfc/rfc4122.txt}\\
-=09\phantomsection\label{intro:S390 PoP}\textbf{[S390 PoP]} & z/Architectu=
re Principles of Operation, IBM Publication SA22-7832, \newline\url{http://=
publibfi.boulder.ibm.com/epubs/pdf/dz9zr009.pdf}, and any future revisions\=
\
+=09\phantomsection\label{intro:S390 PoP}\textbf{[S390 PoP]} & z/Architectu=
re Principles of Operation, IBM Publication SA22-7832, \newline\url{https:/=
/www.ibm.com/docs/en/SSQ2R2_15.0.0/com.ibm.tpf.toolkit.hlasm.doc/dz9zr006.p=
df}, and any future revisions\\
 =09\phantomsection\label{intro:S390 Common I/O}\textbf{[S390
 Common I/O]} & ESA/390 Common I/O-Device and Self-Description, IBM Publica=
tion SA22-7204, \newline\url{https://www.ibm.com/resources/publications/Out=
putPubsDetails?PubID=3DSA22720401}, and any future revisions\\
 =09\phantomsection\label{intro:PCI}\textbf{[PCI]} &
--=20
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that=20
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

