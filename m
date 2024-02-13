Return-Path: <virtio-dev-return-14306-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC49BC4829A
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Feb 2024 13:54:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BD8AE78BAC
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Feb 2024 13:54:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B44659865E3
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Feb 2024 13:54:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A79A798656E; Tue, 13 Feb 2024 13:54:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 71EC498658F
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Feb 2024 13:54:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1707832441.348000
X-TM-MAIL-UUID: cf0b964b-b42e-4d70-9522-b667015f844d
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmzwLLJvfmRrenrtIuMs/oCdFHftLbXalsH0Lpcg6dH50wDZH4JLlPoD8LpPBTUM5xXCtyISCiQOjgxwsUuv6wnd4kkqVueTVcqiSK4CsXqyfgCn7dWvMZ3wZA2HWXLFd+zuYPw1rMWfN1N/esNZR7bjat8Wfv7ksdOrPtA9wJwYcYDEIdym7gfcLGaVMtGCubk4Ag37djtkYzW7XcWJ8o8zD7reKpt+Bh/G/tACmQc0crGPv5Gl6/R5hZGLJKAmpEXGresGCn/M3bHgs2YWQVk5/cSK+t+qgfKGhSYCtY61YoekS1k+EsoTXzHBkgqDaSWqb7lP8uDAK3x+4TgW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=proSnUgtUD10020MrtctP+WI80/HVxHOU75cYNcKQiI=;
 b=nZSXTvZ3TCCpuqPiKkaJyysxY4mfR+DtBJhsWWEDsjWCqw/8xIxPYpsasd0kAxqOvRR1Z7LJojC1A2yhbxBGJYgHBGOcnf/b9S2c41twEHSl2126LyrWiYsQMAfWy/HUkgi3AZmi7MeY1+LJ4wzLB4nm/t1feUdJGnLLW9hDd3DSis5VBABnDgORQUUEl37UhllCuQRxwQNVDfrFT6vesJUXgGODaqZLbi7EUfpMI4zMwIehRUtNdypTHrg/LBlZ8z2llFE1BfTjgUSJp6Fvcg2/lfreZyjKJQFzaQNCwGhWEmoKxyPdPwBvn1xrkpBq/PLHsVFEG2KwUhMsUQKiKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=kernel.org smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Harald Mommer <Harald.Mommer@opensynergy.com>
To: virtio-dev@lists.oasis-open.org,
	Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Date: Tue, 13 Feb 2024 14:53:47 +0100
Message-Id: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9B:EE_|BEZP281MB3063:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9861efdb-492e-44a4-b8c8-08dc2c9b3a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d2Lxy4lbP3FD8X0sq8NZeOZTeuzqEskkgf2zbPlgghtvOls084L4Evu6q3ezRjmlW0KW2Z4tpKYGsDe4Iq2qXMSrkyv19cT5eqRNN5hk2Seznc++HgltVuv/jJSwoSSCS/FBliLz20NfeONUfxNriAMibzGC+4dc9LDDcr5c05aiaE9+QpDqKsKlc3hM4EQnKSo3Y++vLU3eVP6yWoC8kifovXhOI8c3YErJYNrLKFTTM/8mImDka9GVVQ/9dECKoPP7Lu8CBkTgbk1xuTDkAFIETwc3ukphbmeyjbYv7rOZMfK1Lqibu6e8P+ASwOcNPuL5sbNMfgV/UB8d3PNgeLVBBL6nxLIkrqgAyWhnRKsfBZ4ZB9BQ7r4ClPHSm2vDuvoWkSi54m97Xl4hi/bItwBugaKXcD64tnsZU0pl4ZQieSpofqV1S4RYKIgWS5AHqzqipSB9JkwdEhGTUMtmqsFFyOYLW4Ej2Tg/WNLxsfYvkfN1Q1T9KPgSmzzLbYS2hblIXivUUC4mQb9PQh2moNxFu6ugMVkOJ8WorhcMOPBMNiKpPwGlSrPsT2ll0gPVbns4sGZmoYPvEeoM6VjELPKIJAV12FmRBcfSfSue3tc=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(46966006)(36840700001)(41300700001)(478600001)(2906002)(42186006)(5660300002)(54906003)(70206006)(110136005)(2616005)(107886003)(83380400001)(336012)(70586007)(26005)(1076003)(36756003)(4326008)(8676002)(316002)(8936002)(86362001)(81166007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 13:53:59.2145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9861efdb-492e-44a4-b8c8-08dc2c9b3a9e
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3063
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28190.000
X-TMASE-Result: 10--5.807400-4.000000
X-TMASE-MatchedRID: UdxqiKKFAzhFXrD9KUuNErIyl8KAIcW/3B1hSgpgA3P7Bamin45J3DM+
	jPWs1TwyCRyXfdSvdmw8BVvUwtAJs+Lm8FY5k1yNOPwPJT+A+aJCKdqcEPNeC5GeN+9dVIq31/6
	WTCeqY2shPCzXmn9t9DHH90MCQqpzbsT0kBZNrmUhPK2mn+OsTMOr2HNR+yxjt1CSfPp/+EWDCS
	dOycy8kxcgNH4AIUmJYReXSC3dfpnsocQd7WY5yEI9AEPfED/dqvJX/aNGr9cSCDdzAMeX/RLdY
	zv1bejiZrfFxrTdHozfY76xzK50wKg7Zo5UOBRpoli4ZoiOHT9+ICquNi0WJN1LCC9OQK7stqzv
	3rgvk8i2lmxaf3h8xnut0zlWRjtHftwZ3X11IV0=
X-TMASE-XGENCLOUD: bdd947d4-acd2-4538-b8de-d770f9c568cb-0-0-200-0
X-TM-Deliver-Signature: F30FAC9FBD3025F9E66A07FBABF5CACE
X-TM-Addin-Auth: ioXJIzpebPhoei7p2a6mK7aAvKIf+Diyc4q/syAJMB0QOJCnmzn+ct7ZhvV
	DegpBrODSu4XuKGhJYWZPsYZ7oNfyvBKiSz8LPUY576W4Eo+uUp0ilAqyikLlP/9RjIPAt5ZO5g
	g/t6IwjEzyGeCHIqW0WHQPHlIEV3mCGXwhTTY+xItCOWLYVJJ33NSNV7I/HTEMKkNqlxPYILN4o
	C2ZnhHVnqupzAbfd+NJqdGuuenpsoyYyUWJ3zoigpO33D+V+1jGvvaw0fPXxrYiW4nhrTA0Op0C
	G6JUBU8chUGKxrc=.htgGgIQhvmhLb3UL5g6Pc+D+rxgN4y7M+x4HYQpngQSzJfPEO6h5aMuedo
	qf8JNrjo3D0x9UmtuJW/JxgBsgEQgaExqnFKoPDsWNLeyyNwVpljPR2dSFQZPJO6ezJZ6W33rDe
	ytqYeOYA62meizKRPZmBGybbIx4TPQ8vfuVAJsFW5x3cUF32IADoRlDwT2UFxJuou5pDqbpxaoC
	4k9yCGUWspd/Z/F8SzMOWNAXhQDoJ3xMS0wl2wdPi6fGmWRdEF3AzCV+2dIBHmGRyD/nORaIApP
	4VmAJxZUMANGvaDsUwfovjmVbvmDJJcAl70MMxAAqx4BGa3KxhqaYEfLWEA==
X-TM-Addin-ProductCode: EMS
Subject: [virtio-dev] [RFC PATCH v3 0/3] Virtio SPI Linux driver compliant to draft spec V10

This is the 3rd RFC version of a virtio SPI Linux driver which is
intended to be compliant with the proposed virtio SPI draft
specification V10.

Changes between 1st and 2nd virtio SPI driver RFC:

- Update from virtio SPI draft specification V4 to V10.

- Incorporate review comments gotten from the community.

A proposal for a performance enhancement having more than only one SPI
message in flight had to be kept out. The more complicated code would
have caused an unacceptable project risk now.

Changes between 2nd and 3rd virtio SPI driver RFC:

- Order header inclusion alphabetically

- Add Viresh Kumar's "signed-off" to the header files

- Rework virtio_spi_one_transfer()
  - Rework the delays according to Haixu Cui's advise. Delays are now
    handled in a new sub-function virtio_spi_set_delays()
  - Minor change: Re-formulate arguments of sg_init_one()

- Rework virtio_spi_probe()
  - Replace some goto in error paths by return
  - Add spi_unregister_controller() to an error path. Abstained from
    using devm_spi_register_controller() to keep order of
    de-initialization in virtio_spi_remove().
  - Add deletion of vqueue to all error paths taken after the virtqueues
    have been initialized

The virtio SPI driver was smoke tested on qemu using OpenSynergy's
proprietary virtio SPI device doing a SPI backend simulation on top of
next-20240213 and an adapted version on Linux 6.5 with target hardware
providing a physical SPI backend device.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

