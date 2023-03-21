Return-Path: <virtio-dev-return-11692-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED514C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D95FD2CAD9
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE0F0986463
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C36E698644C; Tue, 21 Mar 2023 21:59:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 96E1C986533;
	Tue, 21 Mar 2023 21:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XySKv9gnHLD0HyNiWSoOuRaXYh/cQ415cjI5ou6VB8fvKGN2+nXDqPC1OlynAdocseZVVfuTD/NEYtcy0GmUsxEpUU7TgMqESo2bzZ+n+qbOaqQlMCxy8hD5W6HPiBa6yqpssh3ermAfZ3BJYg4MPCuC+LneUuHQsw2uW6TmHm6ZjopjNG37J/iQDGLmWof2p18xMBVgh9uRzpHUO3GVWYS4KPAquqFJuYFz36NV0Eg/frNNDLGI7jYogkDwlwjIfqDPRTvUX9FCqkYcX36IvC8esOYT9Bx8kh99f1gYk+CbB8ft32bpAzv1tWmtkgdkpDzdhUkEW9dG27TaPRbinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zScwm1MtdLjw4GnXL0eryLQ3iiS/+EeFqnSFtrsCQjM=;
 b=LGsTN7dR8nBvixO4v0uViuFKpJ4Vq5nwFIpHIImOhac59VPOeZybMqBIUg83DJLT9OgVxrHh4RRObc2vXE4SMqtQUOctZ69uHcOfQplffqvFRgxJBrXSHLfgNzkQMj2ixBWaaddpdW9O4T981HCAKRhj/7VVr27ZWi+PhRxA1zLadNDTaBH3CW4RytVB97J+ui+VEAjfnEZksSB1qFa1oWXoGqZg3EutTOWRi4+nDg9rvHU+GUrL5ewA6eKtfNcsidb9HSLHMF6k6tOve8b2myl2t8CjliBzhIbm92JsMGcFjLSrLRZQtO9IBMiRGHtdc0o0boc41Sqcq+98k837JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 21 Mar 2023 23:58:27 +0200
Message-ID: <20230321215834.225856-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230321215834.225856-1-parav@nvidia.com>
References: <20230321215834.225856-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|SN7PR12MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: a80ba4d3-a13b-47ff-88e0-08db2a577f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yemEPkqJ2HmTZqG3loGrLk+kAU8lgCadcqPJySaOUoRdQdDebfooC234HcXM0657T1I1jN8O6ekthnBS/BIxzb35mqJEmqT9ATd2Xkq4jqMX/NIcDkxwZms7SOiB2xV94dTfokn1g1OqYbHizj+oxTBBTrADkFDGhAdWPeGKoNNi3zJTlGKzq5ePs9Pe/BFsK8Ol5idRIo7xZBmrvIh1hCBxgcnfYXocmxDs3Ov3h2dhBOCVDG7Pr4RZrSmLAtQtUd1WJmiDBRy7btcMMoKbT1+LtpWeBYDlRATPsDeOLas7uKCzSnO6AGkMezI0NY84ohMWGSwh6Pc22+pPJsTnuvUN3xSgf5dYfz+xLkD35rDB8PzJEjdRDw60WI0QT1AYPn23dJK++CsEwCNmUIQTtCukVKJQ+4SBloNk23pY6P05NWf8FM5iXsSwQpHGVYR9hJEG6VQwN0+GcTvrfUlosegbQKorgw3G1mzfsBZ+ehuLKrNqQz6AETNRKwoFV06oAOXtnivlRqtUe5HMVGwh6JYWUUWxyDHFrs5/iAd1U/7cnIZj8MyKKGHa0vdFnlAmO8s/W1tVVDxZR0+N0npNDA7dHvikpjYbllub+rozTFBjSGVGA52dJx5MUs+hGbxx5fxr58zoeQm0LXCn+9UT2MVhdHGifLvUtl1pU0sWt8wZLbA5caoTaaYj48nNZv2rZw+ce0KsJxc9LZ0FjuQsAIJNfHCHhOUZ1V6lR+qjOSoEH4vb9OmSHQns5OZkqJ/NXKgYLRWJ2aYqqZQ0vN2aOExWispDp/6bcGsmeBnsfY4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199018)(46966006)(36840700001)(40470700004)(41300700001)(36860700001)(70586007)(8936002)(4326008)(8676002)(70206006)(356005)(86362001)(2906002)(7636003)(40480700001)(82310400005)(36756003)(5660300002)(40460700003)(82740400003)(47076005)(966005)(426003)(4744005)(186003)(1076003)(26005)(107886003)(6666004)(336012)(478600001)(110136005)(316002)(54906003)(16526019)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 21:59:08.8065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a80ba4d3-a13b-47ff-88e0-08db2a577f51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154
Subject: [virtio-dev] [PATCH v3 1/8] content: Add vq number text

Introduce vq number and its range so that subsequent patches can refer
to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
- new patch
---
 content.tex | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/content.tex b/content.tex
index cff548a..1ab7794 100644
--- a/content.tex
+++ b/content.tex
@@ -321,6 +321,9 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge
 might allow optimizations or simplify driver and/or device code.
 
+Each virtqueue is identified as vq number or also referred
+to as a virtqueue number; vq number range is from 0 to 65535.
+
 Each virtqueue can consist of up to 3 parts:
 \begin{itemize}
 \item Descriptor Area - used for describing buffers
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

