Return-Path: <virtio-dev-return-14203-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537F2C46CD4
	for <virtio-dev@archiver.kernel.org>; Fri, 29 Dec 2023 08:09:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F1A5F2239F
	for <virtio-dev@archiver.kernel.org>; Fri, 29 Dec 2023 08:09:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DED33986419
	for <virtio-dev@archiver.kernel.org>; Fri, 29 Dec 2023 08:09:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CD17F9863DD; Fri, 29 Dec 2023 08:09:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B93319863FA;
	Fri, 29 Dec 2023 08:09:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <virtio-dev@lists.oasis-open.org>, <virtio-comment@lists.oasis-open.org>,
        <cohuck@redhat.com>, <harald.mommer@opensynergy.com>,
        <broonie@kernel.org>, <viresh.kumar@linaro.org>
CC: <quic_ztu@quicinc.com>, Haixu Cui <quic_haixcui@quicinc.com>
Date: Fri, 29 Dec 2023 16:08:53 +0800
Message-ID: <20231229080855.16519-1-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FEseW78mdIlbx10VcPctH4qcOoem7Jdw
X-Proofpoint-ORIG-GUID: FEseW78mdIlbx10VcPctH4qcOoem7Jdw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312290063
Subject: [virtio-dev][PATCH V10 0/2] virtio-spi: add virtual SPI controller

The Virtio SPI (Serial Peripheral Interface) device is a virtual SPI controller that
allows the driver to operate and use the SPI controller under the control of the host,
either a physical SPI controller, or an emulated one.

changelog:
=========
v9->v10:
- add explanation of CPHA and CPOL
- update the statement of bits_per_word_mask when it is set as 0

v8->v9:
- add explanation of bits_per_word_mask in config space

v7->v8:
- change device to host

v6->v7:
- fix the format problems and syntax problems

v5->v6:
- use driver/device instead guest/host
- add the definition of some terminologies
- use controller instead of master throughout the spec
- add buffer length validation for full-duplex transfer

v4->v5:
- use controller instead of master
- fix indentation issue
- extend the config space to expose the backend supported features
- add another result value to indicate parameter error
- add device and driver requirement about parameter checking

v3->v4:
- fix the spell errors
- bus_num is not SOC-specific, remove it
- add driver requirement to deal with the situation that the cs delay
parameters are not 0 but the backend doesn't support cs timing setting

v2->v3
- remove unnecessary statements and driver implementation details
- add the parameters about cs timing delay and transfer delay
- use "le32" instead of "u32"
- swap the rx_buf and tx_buf in the request format
- add the parameters about transfer bit width

v1->v2:
- explain SPI when it is firstly used
- update the ambiguous expression of virtqueue

v0->v1:
- add definition of abbreviation SPI
- remove the ID

Haixu Cui (2):
  content: Rename SPI master to SPI controller
  virtio-spi: add the device specification

 conformance.tex                         |  12 +-
 content.tex                             |   3 +-
 device-types/spi/description.tex        | 286 ++++++++++++++++++++++++
 device-types/spi/device-conformance.tex |   7 +
 device-types/spi/driver-conformance.tex |   7 +
 5 files changed, 310 insertions(+), 5 deletions(-)
 create mode 100644 device-types/spi/description.tex
 create mode 100644 device-types/spi/device-conformance.tex
 create mode 100644 device-types/spi/driver-conformance.tex

-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

