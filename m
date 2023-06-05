Return-Path: <virtio-dev-return-12860-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A818AC77B73
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 09:24:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DD1084290D
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 09:24:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D26B7986466
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 09:24:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C5AF698638A; Mon,  5 Jun 2023 09:24:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B14269863AC;
	Mon,  5 Jun 2023 09:24:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <virtio-comment@lists.oasis-open.org>, <virtio-dev@lists.oasis-open.org>,
        <cohuck@redhat.com>
CC: <quic_ztu@quicinc.com>, Haixu Cui <quic_haixcui@quicinc.com>
Date: Mon, 5 Jun 2023 17:24:01 +0800
Message-ID: <20230605092403.17406-1-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E9ZhTHE2aKTO-V-BT3rQI4_gbktVXeJy
X-Proofpoint-GUID: E9ZhTHE2aKTO-V-BT3rQI4_gbktVXeJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=424 mlxscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050084
Subject: [virtio-dev][PATCH 0/2] virtio-spi: add virtual SPI master

virtio-spi is a virtual SPI(Serial Peripheral Interface) master and
it allows a guset to operate and use the physical SPI master controlled
by the host.

Patch summary:
patch 1 define the DEVICE ID for virtio-spi
patch 2 add the specification for virtio-spi

Haixu Cui (2):
  virtio-spi: define the DEVICE ID for virtio SPI master
  virtio-spi: add the device specification

 content.tex                             |   2 +
 device-types/spi/description.tex        | 152 ++++++++++++++++++++++++
 device-types/spi/device-conformance.tex |   7 ++
 device-types/spi/driver-conformance.tex |   7 ++
 4 files changed, 168 insertions(+)
 create mode 100644 device-types/spi/description.tex
 create mode 100644 device-types/spi/device-conformance.tex
 create mode 100644 device-types/spi/driver-conformance.tex

-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

