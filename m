Return-Path: <virtio-dev-return-12324-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC781C77B76
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 12:47:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 10C1142A76
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 12:46:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0CF0C98662E
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 12:46:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 00AE698661E; Thu, 20 Apr 2023 12:46:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DBA39986626;
	Thu, 20 Apr 2023 12:46:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: David Edmondson <david.edmondson@oracle.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Date: Thu, 20 Apr 2023 13:46:46 +0100
Message-Id: <20230420124647.58488-2-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230420124647.58488-1-david.edmondson@oracle.com>
References: <20230420124647.58488-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_08,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200104
X-Proofpoint-GUID: MaM_XKQ7lGW1zXpetjC5-DYWpR5yHYey
X-Proofpoint-ORIG-GUID: MaM_XKQ7lGW1zXpetjC5-DYWpR5yHYey
Subject: [virtio-dev] [PATCH 1/2] virtio-net: Minor wording improvement

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 device-types/net/description.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 875c4e6..8aa7953 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -815,7 +815,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 
 If \field{gso_type} differs from VIRTIO_NET_HDR_GSO_NONE, then
 the device MUST also set the VIRTIO_NET_HDR_F_NEEDS_CSUM bit in
-\field{flags} MUST set \field{gso_size} to indicate the desired MSS.
+\field{flags} and MUST set \field{gso_size} to indicate the desired MSS.
 If VIRTIO_NET_F_RSC_EXT was negotiated, the device MUST also
 set VIRTIO_NET_HDR_F_RSC_INFO bit in \field{flags},
 set \field{csum_start} to number of coalesced TCP segments and
-- 
2.39.2 (Apple Git-143)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

