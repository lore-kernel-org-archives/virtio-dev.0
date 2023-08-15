Return-Path: <virtio-dev-return-13553-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D87C001DB
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 13:35:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CF2691922E8
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 13:35:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4C019863D8
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 13:35:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B714C986371; Tue, 15 Aug 2023 13:35:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 28E5598636E
	for <virtio-dev@lists.oasis-open.org>; Tue, 15 Aug 2023 13:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: mlFCyb3mMU6UDVqhTLPXgg-1
From: Cornelia Huck <cohuck@redhat.com>
To: virtio@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org,
	Cornelia Huck <cohuck@redhat.com>
Date: Tue, 15 Aug 2023 15:34:49 +0200
Message-ID: <20230815133451.62224-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH virtio-1.3] update acknowledgements for 1.3

Move some names to the section for previous versions, add names of new
contributors, etc.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 acknowledgements.tex | 124 ++++++++++++++++++++++++++-----------------
 1 file changed, 75 insertions(+), 49 deletions(-)

diff --git a/acknowledgements.tex b/acknowledgements.tex
index 1c0a155143bf..39e80d4391d7 100644
--- a/acknowledgements.tex
+++ b/acknowledgements.tex
@@ -6,82 +6,65 @@ \chapter{Acknowledgements}\label{chap:Acknowledgements}
 The following individuals have participated in the creation of this specification and are gratefully acknowledged:
 
 \subsection*{Participants}
-Alexander Duyck, Intel \newline
-Alex Bennée, Linaro \newline
+Alvaro Karsz, SolidRun \newline
 Anton Yakovlev, OpenSynergy \newline
-Arseny Krasnov, Kaspersky Lab \newline
 Cornelia Huck, Red Hat \newline
+David Edmondson, Oracle \newline
 David Hildenbrand, Red Hat \newline
-David Stevens, Chromium \newline
-Dr. David Alan Gilbert, Red Hat \newline
+Dmitry Fomichev, Western Digital \newline
+Dust Li, Alibaba \newline
 Enrico Granata, Google \newline
-Eugenio Pérez, Red Hat \newline
-Felipe Franciosi, Nutanix \newline
-Gaetan Harter, OpenSynergy \newline
-Gerd Hoffmann, Red Hat \newline
-Gurchetan Singh, Chromium \newline
+Haixu Cui, Quic Inc \newline
 Halil Pasic, IBM \newline
-Hao Chen, Google \newline
-Huang Yang, Intel \newline
+Heng Qi, Alibaba \newline
+Hrishivarya Bhageeradhan, OpenSynergy \newline
 Jan Kiszka, Siemens \newline
-Jean-Philippe Brucker, Linaro \newline
-Jiang Wang, Bytedance \newline
-Jie Deng, Intel \newline
-Joel Nider, Individual \newline
-Johannes Berg, Intel \newline
-Junji Wei, Bytedance \newline
-Keiichi Watanabe, Chromium \newline
-Marcel Holtmann, Individual \newline
-Max Gurtovoy, Nvidia \newline
+Jiri Pirko, Nvidia \newline
+Laura Loghin, Amazon \newline
+Lei He, Bytedance \newline
+Lingshan Zhu, Intel \newline
+Matti Moell, OpenSynergy \newline
 Michael S. Tsirkin, Red Hat \newline
-Nikos Dragazis, Arrikto \newline
-Pankaj Gupta, Red Hat \newline
-Paolo Bonzini, Red Hat \newline
+Mihai Carabas, Oracle \newline
 Parav Pandit, Nvidia \newline
-Peter Hilber, OpenSynergy \newline
-Petre Eftime, Amazon \newline
-Philipp Hahn, Univention \newline
-Rob Bradford, Intel \newline
-Stefan Fritsch, Individual \newline
+Ran Koren, Nvidia \newline
+Satananda Burla, Marvell \newline
+Shahaf Shuler, Nvidia \newline
+Si-Wei Liu, Oracle \newline
 Stefan Hajnoczi, Red Hat \newline
 Stefano Garzarella, Red Hat \newline
-Taylor Stark, Microsoft \newline
-Tiwei Bie, Intel \newline
-Viresh Kumar, Linaro \newline
-Vitaly Mireyno, Marvell \newline
 Xuan Zhuo, Alibaba \newline
-Yadong Qi, Intel \newline
-Yoni Bettan, Red Hat \newline
 Yuri Benditovich, Red Hat / Daynix \newline
+Zhenwei Pi, Bytedance \newline
 
 The following non-members have provided valuable feedback on this
 specification and are gratefully acknowledged:
 
 \subsection*{Reviewers}
-Christophe de Dinechin, Red Hat \newline
-Gil Savir, Intel \newline
-Ruchika Gupta, Linaro \newline
-Arnd Bergmann, Individual \newline
-Bing Zhu, Intel \newline
-Eduardo Habkost, Red Hat \newline
-Eric Auger, Red Hat \newline
-Jason Wang, Red Hat \newline
-Jens Freimann, Red Hat \newline
-Kevin Tian, Intel \newline
-Linus Walleij, Linaro \newline
-Matti Möll, OpenSynergy \newline
-Tomas Winkler, Intel \newline
-Yang Huang, Intel \newline
+Damien Le Moal, Western Digital \newline
+Hans Holmberg, Western Digital \newline
+Hans Zhang, Alibaba \newline
+He Rongguang, Alibaba \newline
+Helin Guo, Alibaba \newline
+Jiang Liu, Alibaba \newline
+Matias Bjørling, Western Digital \newline
+Max Gurtovoy, Nvidia \newline
+Niklas Cassel, Western Digital \newline
+Tony Lu, Alibaba \newline
 
 
 The following individuals have participated in the creation of
 previous versions of this specification and are gratefully acknowledged:
 
 \subsection*{Participants}
+Alexander Duyck, Intel \newline
+Alex Bennée, Linaro \newline
 Allen Chia, Oracle	\newline
 Amit Shah,	Red Hat	\newline
 Amos Kong,	Red Hat	\newline
 Anthony Liguori,	IBM	\newline
+Anton Yakovlev, OpenSynergy \newline
+Arseny Krasnov, Kaspersky Lab \newline
 Bruce Rogers, SUSE	\newline
 Bryan Venteicher,	NetApp	\newline
 Chandra Thyamagondlu, Xilinx	\newline
@@ -90,46 +73,78 @@ \subsection*{Participants}
 Cunming, Liang, Intel	\newline
 Damjan, Marion, Cisco	\newline
 Daniel Kiper,	Oracle	\newline
+David Hildenbrand, Red Hat \newline
+David Stevens, Chromium \newline
+Dr. David Alan Gilbert, Red Hat \newline
+Enrico Granata, Google \newline
+Eugenio Pérez, Red Hat \newline
 Fang Chen, Huawei	\newline
 Fang You, Huawei	\newline
+Felipe Franciosi, Nutanix \newline
+Gaetan Harter, OpenSynergy \newline
 Geoff Brown,	M2Mi	\newline
 Gerd Hoffmann, Red Hat	\newline
 Gershon Janssen,	Individual Member	\newline
 Grant Likely, ARM	\newline
+Gurchetan Singh, Chromium \newline
 Haggai Eran,	Mellanox	\newline
 Halil Pasic,	IBM	\newline
+Hao Chen, Google \newline
+Huang Yang, Intel \newline
 James Bottomley,	Parallels IP Holdings GmbH	\newline
 Jani Kokkonen, Huawei	\newline
 Jan Kiszka,	Siemens AG	\newline
+Jean-Philippe Brucker, Linaro \newline
 Jens Freimann, Red Hat	\newline
 Jian Zhou,	Huawei	\newline
+Jiang Wang, Bytedance \newline
+Jie Deng, Intel \newline
+Joel Nider, Individual \newline
+Johannes Berg, Intel \newline
+Junji Wei, Bytedance \newline
 Karen Xie, Xilinx	\newline
+Keiichi Watanabe, Chromium \newline
 Kumar Sanghvi, Xilinx	\newline
 Lei Gong,	Huawei	\newline
 Lior Narkis,	Mellanox	\newline
 Luiz Capitulino,	Red Hat	\newline
 Marc-André Lureau, Red Hat	\newline
+Marcel Holtmann, Individual \newline
 Mark Gray, Intel	\newline
 Michael S. Tsirkin,	Red Hat	\newline
 Mihai Carabas,	Oracle	\newline
+Nikos Dragazis, Arrikto \newline
 Nishank Trivedi, NetApp	\newline
+Pankaj Gupta, Red Hat \newline
 Paolo Bonzini,	Red Hat	\newline
 Paul Mundt, Huawei	\newline
 Pawel Moll,	ARM	\newline
 Peng Long,	Huawei	\newline
+Peter Hilber, OpenSynergy \newline
+Petre Eftime, Amazon \newline
+Philipp Hahn, Univention \newline
 Piotr Uminski, Intel	\newline
 Qian Xum, Intel	\newline
 Richard Sohn,	Alcatel-Lucent	\newline
+Rob Bradford, Intel \newline
 Rusty Russell,	IBM	\newline
 Sasha Levin,	Oracle	\newline
 Sergey Tverdyshev,	Thales e-Security	\newline
+Stefan Fritsch, Individual \newline
 Stefan Hajnoczi,	Red Hat	\newline
 Sundar Mohan, Xilinx	\newline
+Taylor Stark, Microsoft \newline
+Tiwei Bie, Intel \newline
 Tom Lyon,	Samya Systems, Inc.	\newline
 Victor Kaplansky, Red Hat	\newline
 Vijay Balakrishna,	Oracle	\newline
+Viresh Kumar, Linaro \newline
+Vitaly Mireyno, Marvell \newline
 Wei Wang, Intel	\newline
 Xin Zeng, Intel	\newline
+Yadong Qi, Intel \newline
+Yoni Bettan, Red Hat \newline
+Yuri Benditovich, Red Hat / Daynix \newline
 
 The following non-members have provided valuable feedback on
 previous versions of this
@@ -141,15 +156,18 @@ \subsection*{Reviewers}
 Alexander Duyck,	Intel	\newline
 Andreas Pape,	ADITG/ESB	\newline
 Andrew Thornton,  Google \newline
+Arnd Bergmann, Individual \newline
 Arun Subbarao,	LynuxWorks	\newline
 Baptiste Reynal,	Virtual Open Systems	\newline
 Bharat Bhushan,	NXP Semiconductors	\newline
+Bing Zhu, Intel \newline
 Brian Foley,  ARM \newline
 Chandra Thyamagondlu,	Xilinx	\newline
 Changpeng Liu,	Intel	\newline
 Christian Pinto,	Virtual Open Systems	\newline
 Christoffer Dall,	ARM	\newline
 Christoph Hellwig,	Individual \newline
+Christophe de Dinechin, Red Hat \newline
 Christian Borntraeger,	IBM	\newline
 Daniel Marcovitch,	Mellanox	\newline
 David Alan Gilbert, Red Hat \newline
@@ -158,6 +176,7 @@ \subsection*{Reviewers}
 Denis V. Lunev,	OpenVZ	\newline
 Dmitry Fleytman,	Red Hat	\newline
 Don Wallwork,	Broadcom	\newline
+Eduardo Habkost, Red Hat \newline
 Emily Drea,	ARM	\newline
 Eric Auger,	Red Hat	\newline
 Fam Zheng, Red Hat	\newline
@@ -175,6 +194,7 @@ \subsection*{Reviewers}
 Jason Baron,	Akamai	\newline
 Jason Wang, Red Hat \newline
 Jean-Philippe Brucker,	ARM	\newline
+Jens Freimann, Red Hat \newline
 Jianfeng Tan,	intel	\newline
 Jonathan Helman,	Oracle	\newline
 Karandeep Chahal,	DDN	\newline
@@ -184,13 +204,16 @@ \subsection*{Reviewers}
 Laura Novich, Red Hat	\newline
 Ladi Prosek,	Red Hat	\newline
 Lars Ganrot,	Napatech	\newline
+Linus Walleij, Linaro \newline
 Longpeng (Mike),	Huawei	\newline
 Mario Torrecillas Rodriguez,	ARM	\newline
 Mark Rustad,	Intel	\newline
+Matti Möll, OpenSynergy \newline
 Maxime Coquelin,	Red Hat	\newline
 Namhyung Kim,	LG	\newline
 Ola Liljedahl,	ARM	\newline
 Pankaj Gupta,	Red Hat	\newline
+Paolo Bonzini, Red Hat \newline
 Patrick Durusau,	OASIS	\newline
 Pierre Pfister,	Cisco	\newline
 Pranavkumar Sawargaonkar,	Linaro	\newline
@@ -199,6 +222,7 @@ \subsection*{Reviewers}
 Roman Kiryanov,	Google	\newline
 Robin Cover,	OASIS	\newline
 Roger S Chien,	Intel	\newline
+Ruchika Gupta, Linaro \newline
 Sameeh Jubran,	Red Hat / Daynix	\newline
 Si-Wei Liu,	Oracle	\newline
 Sridhar Samudrala,	Intel	\newline
@@ -208,6 +232,7 @@ \subsection*{Reviewers}
 Thomas Huth,	Red Hat	\newline
 Tiwei Bie,	Intel	\newline
 Tomáš Golembiovský,	Red Hat	\newline
+Tomas Winkler, Intel \newline
 Venu Busireddy,	Oracle	\newline
 Victor Kaplansky,	Red Hat	\newline
 Vijayabhaskar Balakrishna,	Oracle	\newline
@@ -216,6 +241,7 @@ \subsection*{Reviewers}
 Wei Xu,	Red Hat	\newline
 Will Deacon,	ARM	\newline
 Willem de Bruijn,	Google	\newline
+Yang Huang, Intel \newline
 Yuanhan Liu,	Intel	\newline
 Yuri Benditovich,	Red Hat / Daynix	\newline
 Zhi Yong Wu,	IBM	\newline
-- 
2.41.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

