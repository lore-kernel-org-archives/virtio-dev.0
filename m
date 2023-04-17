Return-Path: <virtio-dev-return-12255-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115CBC77B76
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 14:05:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ADA3A866A9
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 14:05:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81A5098679B
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 14:05:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CEE549863A3; Mon, 17 Apr 2023 14:05:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 808E3986386
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Apr 2023 14:04:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <quic_ztu@quicinc.com>, Haixu Cui <quic_haixcui@quicinc.com>
Date: Mon, 17 Apr 2023 22:03:51 +0800
Message-ID: <20230417140353.870-1-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ggMKzWWbi9qpcVVujkS4pMmkIxD82y1h
X-Proofpoint-GUID: ggMKzWWbi9qpcVVujkS4pMmkIxD82y1h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_08,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=418 clxscore=1011 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170126
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
 device-types/spi/description.tex        | 155 ++++++++++++++++++++++++
 device-types/spi/device-conformance.tex |   7 ++
 device-types/spi/driver-conformance.tex |   7 ++
 4 files changed, 171 insertions(+)
 create mode 100644 device-types/spi/description.tex
 create mode 100644 device-types/spi/device-conformance.tex
 create mode 100644 device-types/spi/driver-conformance.tex

-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

