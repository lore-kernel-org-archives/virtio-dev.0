Return-Path: virtio-return-3326-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 27 Mar 2019 18:20:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190327221958.10457-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio] [PATCH] acknowledgements: add members and non-members
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Add all current members as participants.
Add all participant names collected from list, jira and github.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 acknowledgements.tex | 70 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 9 deletions(-)

diff --git a/acknowledgements.tex b/acknowledgements.tex
index 233e4a1..84b17b8 100644
--- a/acknowledgements.tex
+++ b/acknowledgements.tex
@@ -6,47 +6,99 @@ \chapter{Acknowledgements}\label{chap:Acknowledgements}
 The following individuals have participated in the creation of this specification and are gratefully acknowledged:
 
 \begin{oasistitlesection}{Participants}
+Allen Chia, Oracle	\newline
 Amit Shah,	Red Hat	\newline
 Amos Kong,	Red Hat	\newline
 Anthony Liguori,	IBM	\newline
-Bruce Rogers,	Novell	\newline
+Bruce Rogers, SUSE	\newline
 Bryan Venteicher,	NetApp	\newline
+Chandra Thyamagondlu, Xilinx	\newline
+Chet Ensign, OASIS	\newline
 Cornelia Huck,	Red Hat	\newline
+Cunming, Liang, Intel	\newline
+Damjan, Marion, Cisco	\newline
 Daniel Kiper,	Oracle	\newline
+Fang Chen, Huawei	\newline
+Fang You, Huawei	\newline
 Geoff Brown,	Machine-to-Machine Intelligence (M2MI) Corporation	\newline
+Gerd Hoffmann, Red Hat	\newline
 Gershon Janssen,	Individual Member	\newline
+Grant Likely, ARM	\newline
 Halil Pasic,	IBM	\newline
 James Bottomley,	Parallels IP Holdings GmbH	\newline
+Jani Kokkonen, Huawei	\newline
+Jan Kiszka,	Siemens AG	\newline
+Jens Freimann, Red Hat	\newline
 Jian Zhou,	Huawei	\newline
+Karen Xie, Xilinx	\newline
+Kumar Sanghvi, Xilinx	\newline
 Lei Gong,	Huawei	\newline
 Luiz Capitulino,	Red Hat	\newline
+Marc-André Lureau, Red Hat	\newline
+Mark Gray, Intel	\newline
 Michael S. Tsirkin,	Red Hat	\newline
+Mihai Carabas,	Oracle	\newline
+Nishank Trivedi, NetApp	\newline
 Paolo Bonzini,	Red Hat	\newline
-Pawel Moll,	ARM \newline
+Paul Mundt, Huawei	\newline
+Pawel Moll,	ARM	\newline
 Peng Long,	Huawei	\newline
-Richard Sohn,	Alcatel-Lucent \newline
+Piotr Uminski, Intel	\newline
+Qian Xum, Intel	\newline
+Richard Sohn,	Alcatel-Lucent	\newline
 Rusty Russell,	IBM	\newline
 Sasha Levin,	Oracle	\newline
 Sergey Tverdyshev,	Thales e-Security	\newline
 Stefan Hajnoczi,	Red Hat	\newline
+Sundar Mohan, Xilinx	\newline
 Tom Lyon,	Samya Systems, Inc.	\newline
+Victor Kaplansky, Red Hat	\newline
+Vijay Balakrishna,	Oracle	\newline
+Wei Wang, Intel	\newline
+Xin Zeng, Intel	\newline
 \end{oasistitlesection}
 
 The following non-members have provided valuable feedback on this
 specification and are gratefully acknowledged:
 
 \begin{oasistitlesection}{Reviewers}
+Aaron Conole,	Red Hat	\newline
 Andrew Thornton,  Google \newline
 Arun Subbarao,	LynuxWorks	\newline
+Baptiste Reynal,	Virtual Open Systems	\newline
 Brian Foley,  ARM \newline
+Changpeng Liu,	Intel	\newline
+Christian Pinto,	Virtual Open Systems	\newline
+Christoffer Dall,	ARM	\newline
+Christian Borntraeger,	IBM	\newline
+Daniel Marcovitch,	Mellanox	\newline
 David Alan Gilbert, Red Hat \newline
+David Hildenbrand,	Red Hat	\newline
 Fam Zheng, Red Hat	\newline
-Gerd Hoffmann, Red Hat	\newline
-Halil Pasic,	IBM	\newline
+Gil Savir,	Intel	\newline
+Gonglei (Arei),	Huawei	\newline
+Hannes Reiencke, SUSE	\newline
+Jacques Durand,	Fujutsu	\newline
 Jason Wang, Red Hat \newline
-Laura Novich, Red Hat	\newline
-Patrick Durusau,	Technical Advisory Board, OASIS	\newline
-Thomas Huth,	Red Hat	\newline
-Yan Vugenfirer, Red Hat / Daynix	\newline
+Jean-Philippe Brucker,	ARM	\newline
+Jonathan Helman,	Oracle	\newline
 Kevin Lo,	MSI	\newline
+Laura Novich, Red Hat	\newline
+Ladi Prosek,	Red Hat	\newline
+Longpeng (Mike),	Huawei	\newline
+Maxime Coquelin,	Red Hat	\newline
+Namhyung Kim,	LG	\newline
+Patrick Durusau,	Technical Advisory Board, OASIS	\newline
+Robin Cover,	Technical Advisory Board, OASIS	\newline
+Sameeh Jubran,	Red Hat / Daynix	\newline
+Sridhar Samudrala,	Intel	\newline
+Stefano Garzarella,	Red Hat	\newline
+Thomas Huth,	Red Hat	\newline
+Tiwei Bie,	Intel	\newline
+Tomáš Golembiovský,	Red Hat	\newline
+Victor Kaplansky,	Red Hat	\newline
+Yan Vugenfirer, Red Hat / Daynix	\newline
+Will Deacon,	ARM	\newline
+Yuri Benditovich,	Red Hat / Daynix	\newline
+Zhoujian,	Huawei	\newline
 \end{oasistitlesection}
-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

