Return-Path: <virtio-dev-return-14202-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A7AC46CD3
	for <virtio-dev@archiver.kernel.org>; Fri, 29 Dec 2023 08:09:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 00CAF2A821
	for <virtio-dev@archiver.kernel.org>; Fri, 29 Dec 2023 08:09:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DE899986474
	for <virtio-dev@archiver.kernel.org>; Fri, 29 Dec 2023 08:09:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CF2BC98640E; Fri, 29 Dec 2023 08:09:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B8D7B9863DD;
	Fri, 29 Dec 2023 08:09:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <virtio-dev@lists.oasis-open.org>, <virtio-comment@lists.oasis-open.org>,
        <cohuck@redhat.com>, <harald.mommer@opensynergy.com>,
        <broonie@kernel.org>, <viresh.kumar@linaro.org>
CC: <quic_ztu@quicinc.com>, Haixu Cui <quic_haixcui@quicinc.com>
Date: Fri, 29 Dec 2023 16:08:54 +0800
Message-ID: <20231229080855.16519-2-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231229080855.16519-1-quic_haixcui@quicinc.com>
References: <20231229080855.16519-1-quic_haixcui@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LGsbaKQugpI0d5taeWw33aWH_3BYKXnW
X-Proofpoint-GUID: LGsbaKQugpI0d5taeWw33aWH_3BYKXnW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=656 priorityscore=1501 phishscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312290063
Subject: [virtio-dev][PATCH V10 1/2] content: Rename SPI master to SPI controller

SPI master is an outdated term and should use SPI controller.

Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 0a62dce..1c608eb 100644
--- a/content.tex
+++ b/content.tex
@@ -737,7 +737,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 44         &   ISM device \\
 \hline
-45         &   SPI master \\
+45         &   SPI controller \\
 \hline
 \end{tabular}
 
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

