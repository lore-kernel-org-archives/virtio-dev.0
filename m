Return-Path: <virtio-dev-return-11590-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519D2C6FA99
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 06:27:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 86A2126A36
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 06:27:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7DE0F986720
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 06:27:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 66F9098670B; Fri, 10 Mar 2023 06:27:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5282298670E
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Mar 2023 06:27:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1678429628.777000
X-TM-MAIL-UUID: 24967c3c-167f-4274-a6b1-475e6e905550
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVI3uvC+8FdbcFRBpblgXE4b4ROFOmZjaB7+wfvUIKgX0IjlqvHll/cBg5hNXgGteaQTtxOaxE4h09L8XiRmhdOJUt5Jz2CSnmII5+pqkWkZJNf5Gkna0een2T8sjdN2b5cwJIgd6BjdH866vPxorlRAPQT3KC6449CHPDrMpwenD2W58L4lbcVelDXCWXxMhwxyjSyDf3GZ4dubXkfSf7eRcdTpCkzBM9QI0uY3Fz9GRrGkoFNBY4M6pVOksDpEMImEeyJTrpRVRNl5MmJES7+IAEujeMpyWp28akGxTfzseLgEPP34ZPrC3c4s2oEUVdO/1wKaDSrbvfmeSK2NMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZ8SUeq9bgLykSujzMrmH39XBMwDHYCdyA0nI+5zjX0=;
 b=Qsw6VVRfd2WGIyC/gNcgG4GLPGhvpmn3/jYtA1Q3eUa9+qiED2ns6PiDdRKnL941iDkbt8oNwSHKHcDJMR7Hy6MqZF6gCgjO+Dvu0jYoFSRceK5ZZYSThw9juYRAFZCa6oTUIueRsmwmvgpsg5SmVUlNfcMjkWzDOf4fneK9Ie/RtaNhZvV3qUuTA8ivelv2jZ5cX4HcGaylHQ+uavV5p0LHj5SBpDITtOA2sBRNbRVa+QBbyo2DxRYzapNak2TcKf+JzbStgIZhQw7dCbnJU2QppmEN9MzEi3JgLUmzG1VyVzHxN1BHJ0H0l0L4YqQAU5tkXvZ0VHoDeVSgNuukSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=gmail.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=opensynergy.com;
 dkim=none (message not signed); arc=none
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
	Igor Skalkin <Igor.Skalkin@opensynergy.com>
Date: Fri, 10 Mar 2023 07:26:12 +0100
Message-Id: <20230310062613.109867-1-Igor.Skalkin@opensynergy.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6EUR05FT031:EE_|BEZP281MB2641:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7824766c-2851-45fb-88b1-08db213078cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c0u76VJE9WHeaGBWiJtDSpo1Y8k2ltE6d0mCUe6mKHCWLpNg+OatOAD5GQtw4Cpi0zLfWc+iRYDcBs7E/Ph2FQBP1xXYm0OURmP8KY5xpVxrLK1zMyqNTa6SMpYBg0Ckeb1IDbtOhCh/9Vi6pEa1HtOexwpoJeuPtV1mtso+AxRm4+LpjobjBphjrwqX+8yAaJ6nz+kmxIDG+E/DB4MWYOLtb+KSLpWOe2ghZGhCgy2qGnvA9PBr8C1+t3wFPQBaQIgAWih8M7awhb/6xa7lV3A2VaB/qCesbvh6/f4qtkakxYHd0bWRScl4zuD1Y2Hio0Kn8uqwi7z+VpmROmtbgMsunLM/Ns5yaR4UrOIwnJhgW0bQ9Dc4rT0wsQ/whe17Sk+BwNV0LcykW7EtmtA5wHr/y2+Bb4/n0USFKBYRlIBXX8SMb94yYtukpEW4Ooln6cmFCjkhMnjy794K1EwT4YpYdgpZIDca/uYKIbVGUnBGSKkzdZUxX9Mnibq1aUgIciSUlpOQ1PmT5bUqd5Ozh6Y5RNXcoondQNMO90zuop5MXfZveZGpTZ3hI5TyPehCKb7ZDMxPXtSCq53JJaRZbZY+/jB9YLw3higDhuNfKEymQkhn9TBlvyyjSm9Dsmc4B5rg+8a6fyAoTsCiKc7bOFCfNKQP/1xyRewzHcjOJuKxu+WHyyFAuuXABz1aWar3sugxF9UZX94iAoJ5WaVGjw==
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(39840400004)(376002)(346002)(396003)(136003)(451199018)(36840700001)(46966006)(36756003)(42186006)(5660300002)(316002)(8936002)(2906002)(4744005)(70206006)(70586007)(8676002)(41300700001)(4326008)(40480700001)(1076003)(26005)(36860700001)(186003)(86362001)(81166007)(2616005)(107886003)(478600001)(83380400001)(47076005)(336012)(82310400005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 06:27:07.0871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7824766c-2851-45fb-88b1-08db213078cb
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT031.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2641
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1006-27494.006
X-TMASE-Result: 10--6.653300-4.000000
X-TMASE-MatchedRID: PrWv+NeUIb7lWiNI/3lADxqkhv3OdF4DF4r8H5YrEqyeEPi9wVyFrt/O
	0TkwpBlDezEj+0i6bhi8HO1hAUuG+1lo9n2RjHT/fsrJIMK37At9LQinZ4QefBTJFL84IP3FlR1
	cT9YafQVDkilByGL6Fg1fA1QHegDv3QfwsVk0UbtuRXh7bFKB7sBPfnS+huuj40V8QQK86SnQK3
	j9JSN/NN33BVc+xnsjaAZk0sEcY14=
X-TMASE-XGENCLOUD: bec624c9-07f7-49e8-ad25-22d28396d2f5-0-0-200-0
X-TM-Deliver-Signature: D9AF7CE8ACAEDD60B5F019799A02CA48
X-TM-Addin-Auth: W7HhHqfd/dulWlfJLGHxXW7E1p2Y8EzOT7UnhcRYL+Mu21Lbcx5TTyDnTQK
	bKXG+uBm8ifWTOdVc1t/nsX59nJotSW+nyPWeDW0WBZLlPn2bcifmQNvvnJrEwrgINQPOjto+0c
	fQ+eOVpJ/I81GRTZP7Dwm0gNKfrWuzXYweHLyFZB+TRks866mcH02JmifwEnKI7NlKZnIO3QbEV
	Md4hjCevQsE3AsFyiLNcaxA68PM5wGhOHcw+Mnzaq3O1RBWw7GZNxRN8ujdEHQCryJSVjiICalm
	5JjDaT49/uFiWxU=.MqILZ1XG/4uo0+TiUX8Gul0wdE0ZBaWcP8su5mpQQ/JfT990gtBQ+tZYB6
	ErOwWRmED3oUlJEt+96msx+Z86QisuxWTxxiepqOMRX/neFeTHrKBKy1l4mPW7DjEPUMWKTQoEc
	OPj68AL+3rPC1OkYLFPsEVJGTKFV+730LrZ5IfArvmKdpFtME8X8EMJLgqShnQ5B8NeY+uiT10x
	oHFIVclq25U4HEYF2sCv5gxXPGTfAdEsmAiJOrHmLULM1753lMobv7Bea5PHPduPJcvJS3fY/6K
	kfSsrSF+QRXLGtSzSVvU7LbcBE+kcU/x05lLatV0Yte21cSksSo+eEQX84g==
X-TM-Addin-ProductCode: EMS
Subject: [virtio-dev] [PATCH 0/1] Virtio-bt specification draft

We have been using virtio bluetooth linux kernel driver and virtio bluetooth
devices for some time now, but it still has no spec.
This is the first attempt to start developing this specification.

Igor Skalkin (1):
  RFC: virtio-bt: add virtio BT device specification

 conformance.tex                        |  12 ++-
 content.tex                            |   1 +
 device-types/bt/description.tex        | 112 +++++++++++++++++++++++++
 device-types/bt/device-conformance.tex |   8 ++
 device-types/bt/driver-conformance.tex |   8 ++
 5 files changed, 137 insertions(+), 4 deletions(-)
 create mode 100644 device-types/bt/description.tex
 create mode 100644 device-types/bt/device-conformance.tex
 create mode 100644 device-types/bt/driver-conformance.tex

-- 
2.37.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

