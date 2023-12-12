Return-Path: <virtio-dev-return-14139-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7349AC4332F
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Dec 2023 03:35:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A531626A35
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Dec 2023 03:35:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 29AC09869A8
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Dec 2023 03:35:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6D9A19866B1; Tue, 12 Dec 2023 03:35:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2508D9865C8;
	Tue, 12 Dec 2023 03:34:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <virtio-dev@lists.oasis-open.org>, <virtio-comment@lists.oasis-open.org>,
        <cohuck@redhat.com>, <harald.mommer@opensynergy.com>,
        <broonie@kernel.org>, <qiang4.zhang@linux.intel.com>,
        <viresh.kumar@linaro.org>
CC: <quic_ztu@quicinc.com>, Haixu Cui <quic_haixcui@quicinc.com>
Date: Tue, 12 Dec 2023 11:33:16 +0800
Message-ID: <20231212033317.22198-2-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231212033317.22198-1-quic_haixcui@quicinc.com>
References: <20231212033317.22198-1-quic_haixcui@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mPUZJXsAv4lSFTiQt6vSHGugDD8yzrFs
X-Proofpoint-GUID: mPUZJXsAv4lSFTiQt6vSHGugDD8yzrFs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=791 suspectscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120027
Subject: [virtio-dev][PATCH V9 1/2] content: Rename SPI master to SPI controller

SPI master is an outdated term and should use SPI controller.

Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 content.tex | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 0a62dce..84bc68f 100644
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
 
@@ -767,6 +767,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/scmi/description.tex}
 \input{device-types/gpio/description.tex}
 \input{device-types/pmem/description.tex}
+\input{device-types/spi/description.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

