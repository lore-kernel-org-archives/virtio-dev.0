Return-Path: <virtio-dev-return-12862-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD11C7EE24
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 09:24:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 92165F3F59
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 09:24:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85BEE98648C
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 09:24:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 799A49863AD; Mon,  5 Jun 2023 09:24:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6490898638A;
	Mon,  5 Jun 2023 09:24:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <virtio-comment@lists.oasis-open.org>, <virtio-dev@lists.oasis-open.org>,
        <cohuck@redhat.com>
CC: <quic_ztu@quicinc.com>, Haixu Cui <quic_haixcui@quicinc.com>
Date: Mon, 5 Jun 2023 17:24:02 +0800
Message-ID: <20230605092403.17406-2-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230605092403.17406-1-quic_haixcui@quicinc.com>
References: <20230605092403.17406-1-quic_haixcui@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X8pUEXRZ24Ec5p9p8rj1vyrB3sHisbgt
X-Proofpoint-GUID: X8pUEXRZ24Ec5p9p8rj1vyrB3sHisbgt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=737 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050085
Subject: [virtio-dev][PATCH 1/2] virtio-spi: define the DEVICE ID for virtio SPI master

Define the DEVICE ID of virtio SPI master device as 45.
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index d2ab9eb..0a62dce 100644
--- a/content.tex
+++ b/content.tex
@@ -737,6 +737,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 44         &   ISM device \\
 \hline
+45         &   SPI master \\
+\hline
 \end{tabular}
 
 Some of the devices above are unspecified by this document,
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

