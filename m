Return-Path: <virtio-dev-return-14134-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37137C4167B
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Dec 2023 16:37:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6693F2ACAD
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Dec 2023 16:37:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48BBF986910
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Dec 2023 16:37:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2BDE69868FF; Thu,  7 Dec 2023 16:37:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1993D986907
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Dec 2023 16:37:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1701967052.532000
X-TM-MAIL-UUID: 8c36629c-bcc4-490e-9d0d-0c8db06f80d2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htLUGnrqHGtcP3iZePVrCdMuGt9p6mhk/mio8B60p4KpdlhqmyP3iAXHnyev5FQdCNNH+nLKwZyqrhSqA5b0RczsoKN+aHqpdxc4YyUqKzyTscerKIbxztlpyl35t6HxC6bnr2JBRktOWCyPEoUbVZw1Az1XikD6+Zlywz9cSaUiCgciG/sDeOa1s18n6yZMdn381cyetMnnSOjxovU4GDtVKMN/M0D7SvD7WP6pr1N0XEDuKPxPXbtsw/4p1j7teIXEk+Wtw1T0x2QMK+s4R5wn9gA6+/kqAUXUnIh4riGKD+HLLTuJXHCOHLeDjCCAYZtpK22HHhQYUQL3OSI3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9uQmWrQtwhiDdHbVjurskbDJWCSkKL22ibJc6HDnmo=;
 b=Xp4ReBeDi6HY5KHtA2UbzrK81AyNSEJfY46v/uUzo5we+ra6gxxtHSOr0ANydKRTdoW4rznbAgpgVdIbdoH1gWALcA6B7h4vI5BgflJ+MUjzSfTbPumWpI6XHYJYhDgQG1tlCMGa11rBXuSa5+qPzBZrVeg7aBkIGRwvsaLKKQhV/ADj/ZvOZ03v4na4rMBnA1tMTZ19YetY+GNxXJ3ESdRFRYn+QEc9lwobpXMt4wr80BYOVQWVavuXgEL0n13Gb/lb2qQOixp4QguGk1lPm4CRi4Bhaw33uCqyVvKcJT4JaUQ0mGDyWPeYTmffHWonGuh0GHzYw6k5OetulD6O5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=gmail.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Igor Skalkin <Igor.Skalkin@opensynergy.com>
To: virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	luiz.dentz@gmail.com,
	mst@redhat.com
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	jasowang@redhat.com,
	boris.le.labousse@opensynergy.com,
	Igor Skalkin <Igor.Skalkin@opensynergy.com>
Date: Thu,  7 Dec 2023 17:37:20 +0100
Message-Id: <20231207163721.26737-1-Igor.Skalkin@opensynergy.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT004:EE_|FR2P281MB2348:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2c14789c-21d6-419c-8da6-08dbf742cebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PR1pxpRbX4cjQ6kDQ3j/4+LyhHA5quLSRKU8hOJizz+8Tz/I9dlqWEjYqwek6Sx5CV7GFlND8Q2/NdSduCLdmKVKv26RFnKjlSZ527gTBnw+8V43RHEm6eOYICrJ8KJvlDUykUxoM4Zd1si1+dBn3o22k4yC9S+vxGYOStWw90qSv35XCNcLM2++mpYvY12qPb/tbrN2n1r1++VnE501V9P1JGVeAJEPx+jbIWfo+TPUNqFgswRXSZociuXTrU4fBTlf10u5UCXGg1qkJ62a972hNC07ESs1xlbVqU889Q1V6vJrgEg01TRkUwOPjpk5bTPn2UkvBl6RfcG6zFCb4IJ7zuxUj4ocWrNABb5xUk8CwkFh0o4r1TBtq9NPzMHusUHHnSNbqPtIPrwUnJFxoNf4JILLhnngtuEScs4rcCVeq+gm91HPodvTfJ+gOciwbNXyAILjTCdWAzbDVUrD0Epy+LQ8ud4tBRXDyvIoLgoB5Q8bCeTuaDYJ7izSS2UELXHf++fG+zqMjOImsB4X2sSaA8SS8ds01ofqT3NcfdzBYS4FKQmiCJdvD42pkp54VDOOAl/XCXQQg1oQfsedsZZ8oPYolIn036HGwYtddAQ8ADbcpShXIpExwowKd2JDt3Jgmi+3hNhcPfCqAvNwzIBrqQo9Wkgu2Oncx2JYKaFtI3sg+UGYdmglUGbXn+z5paU0uNcPqKhpW6nRsEdUGH7TWpNCSHw5mce79E6qyL5ECIIAgLpeunqLUaky+UENW7Qy2wvKFGY/lpNQl1FmyRej2w7LxVH67gFkp2XToBQ=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39830400003)(230922051799003)(186009)(1800799012)(82310400011)(451199024)(64100799003)(36840700001)(46966006)(4326008)(8676002)(8936002)(478600001)(86362001)(36860700001)(2616005)(107886003)(26005)(336012)(40480700001)(316002)(70586007)(70206006)(42186006)(1076003)(83380400001)(2906002)(5660300002)(81166007)(47076005)(41300700001)(36756003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 16:37:31.0369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c14789c-21d6-419c-8da6-08dbf742cebf
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB8EUR05FT004.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2348
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28044.000
X-TMASE-Result: 10--3.059100-4.000000
X-TMASE-MatchedRID: 3JONONKdPRIAsgl6PZgqJEu+LBodhvWx6BFG8XEpG3qiMrI1WZc6u30L
	sTLQdfV43uJSxwvFA3VKbULxlN2pgsjGK0ljEFZOE0bUNvPQomsVJPUqXnrQdfCKSoCoSADa14b
	3/Wemcih3evePDuojGaUkHH7dGZNgIrHT8Wer/KeeKdOylUhP2ZmIL0rjgc972rBuSmnUvYWF1X
	gM1szx650L1Z8+NdA82kG2v1GHnmDLULYDu+Fb7MVNAYApHGPk2j7jyCKpnCcSCDdzAMeX/RLdY
	zv1bejiZrfFxrTdHoz+61oPYZ99aiVNJxt7aXvgmwjor1Nh6wucA6dTiL984/ZIIkeG6Ke/Ozg3
	gsyqhuyqvD2pQEhSu553pi65LpW/gyPuz05qJv4=
X-TMASE-XGENCLOUD: d769454a-3a96-404a-a647-61fc49233bbc-0-0-200-0
X-TM-Deliver-Signature: 2A1CF33BCFC3C30B224BEBF3E0F28A75
X-TM-Addin-Auth: Z1DnTEYFbXsbU5MyqRSrRycb964eoMY7M/V/R9XluHHqV3KTjCnoxllkBd9
	4hUDHZ4EMp6TUfeXFh4cNgLLM+K4r/saQ8OOI3ahzBqMeODwW6TExFFhXYUUk5pH42ZE32P0lDM
	IrhI6v81UADgHgQsch0lzseRZowv03NHZmRtKKaqh8LycTmwQYnl1DvqyCFi/g7i9gu/Y/GkkWj
	mld280hCk98TwPftiKrp20m8ZlyuhEhg+zLhiCIbTwZSfxTVQXHtmnJkOB/ForeV48pLR5Dvfbc
	OtvhtbAfK1n7Nao=.Y1qfkimoG2odoJrjnBoTSsiIieVV7PGni2noqz+n8Oi7Wvhr7Qydj8mn8O
	GqGVTJV9PYo/uoGuuGqT6Eckv55xXWVNEYDlQcS80OV9lqUmkH5Il+yQNGoTBcI2kXDVcQmxCxW
	XsalbNxUtzAnmsUwf8bstkwL9qf77AhId+X+9rW0SX2c1j74VzyhbqvuSfNR/CNpOxcQy6+DLpE
	i5prmreLpdA7hAJwBgvkOEPl2b949Gk9sk4flJCvb9Vq/7rvQLYNYHXfIwwSCbcc0uKxehiijWw
	/pfY91w16Qh0uyUbxsBVyXME6KCHZpha8UPAUbgwjg+8O/hxGHEM8w3KQGw==
X-TM-Addin-ProductCode: EMS
Subject: [virtio-dev] [PATCH v2 0/1] Virtio-bt specification draft

We have been using virtio bluetooth linux kernel driver and virtio bluetooth
devices for some time now, but it still has no spec.
This is the first attempt to start developing this specification.

v2->v1:
 - Few minor fixes.
 - Necessary reference links added to the "Normative References".

 - Changes in the configuration V2:
 - Field "type" had been removed, because Alternate MAC/PHYs (AMP) secondary
   controllers had been removed from the Bluetooth Core Specification since
   version 5.3. And this field is not used in the current virtio-bt Linux
   implementation.
 - Approach of the "vendor" field has been completely changed, now it uses
   documented manufacturer identifiers and does not force the driver to use
   the hard-coded dependencies between non-documented index value and
   vendor-specific parameters.

todo:
   - The main question - "Do we have devices based on original (version 1)
   configuration, or we can simple purge this version 1 configuration?" - still
   has no answer(.
   - SCO over HCI test still in process, it is not clear do we need to add
   separate queue for the out of band data.

Igor Skalkin (1):
  RFC: virtio-bt: add virtio BT device specification

 conformance.tex                        |  12 +-
 content.tex                            |   1 +
 device-types/bt/description.tex        | 158 +++++++++++++++++++++++++
 device-types/bt/device-conformance.tex |   7 ++
 device-types/bt/driver-conformance.tex |   7 ++
 introduction.tex                       |  15 +++
 6 files changed, 196 insertions(+), 4 deletions(-)
 create mode 100644 device-types/bt/description.tex
 create mode 100644 device-types/bt/device-conformance.tex
 create mode 100644 device-types/bt/driver-conformance.tex

-- 
2.40.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

