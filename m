Return-Path: <virtio-dev-return-12154-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C80C76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 21:08:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A985E42BCB
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 21:08:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9ABBB9865F8
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 21:08:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8CBE6986193; Tue, 11 Apr 2023 21:08:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7755F9864B3;
	Tue, 11 Apr 2023 21:08:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiLhmyioiHO//ZKK40YxYGi0Dc4M/odQfPKvYUVEhYBLu3+x8xQEvePqLCtpAulNP7x0MaKSVmte33tAJ73bFpD+nUPSeQOlf/X3jyOz5KA1QZpDgLxhYbZ73u66uiUk4PhGg+k3rHAOhwWd4/Dts7yUbHq7uVplQrTG5OPX4yllbTUs73IVXiYYC6QpNAxhMkBOziBmX76K5Ho7mci5Ssgs4RGZvuEl1NHAplrhDdQ1NQbjNwGoAHNWdibt58mmHQgdUlJN51tDWLu0gL8mlt7J78Sr1KvxHuqz0gqc1J0qm8cTf4hMQKIHO4Y3qIGgnWQG6x0Z+uGIMhajeN41ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iConkTZ4G+44BamSRdB/DTXm2NVjaNeSpb+MXtmt4aw=;
 b=dILY7qqrlPT5QijGE2++RKssOKhuzB4JL8CQVqTbrGcJ6ghjrYPpkt4sd4Q/WGP3QLJFnMv+IWRk7z1Lat5RNLiY014u+4kz4NcDgxS2zYMIqAYyKeoTm0ggDv5uJQ5hGGB2wMDC4mB3OZHVBKlBy4AOP/290r2b8LSQdNVVGnCYC8gVERbCkA3BEH3LdmUcOMgWrepf8bjz3A3seNZKWJ7EaDEGIvLd6rnWLgCRvYTenj49W7IzF1fahF8Gg40JSoAD8cdGqIp2Lu7vSd5CJmcQDAU7E/Xo03obFVW0tBrqrseV796UwF/RLaxZC0auZ/hL06R4ZUyrSsCk/2Q8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Wed, 12 Apr 2023 00:08:04 +0300
Message-ID: <20230411210804.753924-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|DM4PR12MB5101:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca44ce4-1c3f-40ea-df38-08db3ad0e61a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hC91WuHTE/v8LFyRW9gblIijWGvTkss8dsq7eXhnaUdya1qhUPqBHI9+/c5BUt3mS54f78jc8y+J+uWCkJyxkJY24i5z7qAHDzFJzMFo2Uq0ks4lW5BgllsVjCRsLwR3GeZgqMraT7gpfeyk25w9ic3eGj3Oeh51VhVTCEpZ6HfzhSwJnAzapXZ/DcfnHU4ml8xSn2C6qu/3gmNUAp1bCNxgTHXFcLa58TP0LFv6BTnEMRLEsPGsPkkNweFR2/0VSKUy+gznGSVb6vn1liPS8rqSGrlkqpeJbIBbo6D4K3QgvtcIYNwgRkTafXW+vD1Dgcv40HduFuZQySyT5KYG2ONRk0fiHogrT7l5KhGOaPn/KCuv1IlRtWMZIkvK4xyoQ4UqBFDVw4uPVbN+8ltWCLz9FIELE5aRPxhHj1zve8U2CQHz8vK0br/CYUR1mRhvy0iOg3DpVxfox5+suVXQArO5E1Q+bXNCfOaye8se6KjyrWJZ7bv/A8mXh+RghL5lniRUv1teIpfenui0DMBJxQ9QUv/px1V6Kh4JytrilAJuiY98dRiDl4Nv9+8uVpBGMDm133Y1IDm3f8sGR97Abt//cAUWkKC9H1sqY4kp3dMPv/VASuDkObfN7+1HISjoDxtB+sxC51gkFAFAyRJoR3+FbFCFEiSntHZC5sBEg0p+DghX1wrG4FDYP6g/k4jpIimij1TYI0pK+B5LWG3kfgV/1Rpl6oE85/8VYI8/QeZ6l8GMxrapD5RDHB62ebOfZ6SQfWsWNUEKlYcSGOlAmTwVsvZcb1ot9nN+yIgxqro=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(36756003)(54906003)(478600001)(26005)(8936002)(2616005)(4744005)(47076005)(7636003)(356005)(82740400003)(16526019)(1076003)(83380400001)(5660300002)(186003)(426003)(40480700001)(86362001)(336012)(36860700001)(70206006)(34070700002)(70586007)(4326008)(8676002)(82310400005)(110136005)(316002)(107886003)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 21:08:28.9780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca44ce4-1c3f-40ea-df38-08db3ad0e61a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
Subject: [virtio-dev] [PATCH] vimrc: Increase number of characters per line to 80

Increase number of characters per line to 80 to avoid aggressive short
lines.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 _vimrc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/_vimrc b/_vimrc
index 045b3c5..375a043 100644
--- a/_vimrc
+++ b/_vimrc
@@ -2,4 +2,4 @@
 "following settings (without the " symbol) as last two lines in $HOME/.vimrc:
 "set secure
 "set exrc
-set textwidth=65
+set textwidth=80
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

