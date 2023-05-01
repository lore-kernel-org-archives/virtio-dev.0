Return-Path: <virtio-dev-return-12486-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9F6C77B73
	for <virtio-dev@archiver.kernel.org>; Mon,  1 May 2023 22:45:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AAA7A94EE7
	for <virtio-dev@archiver.kernel.org>; Mon,  1 May 2023 22:45:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E1B49866C7
	for <virtio-dev@archiver.kernel.org>; Mon,  1 May 2023 22:45:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 923FB986495; Mon,  1 May 2023 22:45:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64AE79867B8;
	Mon,  1 May 2023 22:45:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOTqwmurWQQ28NY9yRhoP6di+FXZrRokFauDGURmAFIrq2rSKrgrwQyJIiRGdEYpgiSG/RFpENspqWVJ5LqspqyEao3svpRolmH6g7PlCQQed7w0gpS885xM4j+U8gm0bqRMz0I6xq5ti/gb2oyLhpy6SsAnEyygalK48UntKHoeTWeE8um3E4hl4VjogJnpxClFfTrjBReoSaEgLVaq++DpPEnh9dWz1Et+u789Pa+9De0IKx3HADQLxciGKZjvYC2EdGk6oW2A1zPa+s1ss7aBJgjdFZG4UrF+AjW8sWdG5FWsgr9U0Bdc4eSef4tczsVToNy6NFHYaoj01KiHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87eLUxSwDv06i/ImYeO3UBIFArISB3Xqy7i63WOLBU4=;
 b=mi106LNNo+o+LdXvOAtOc1JGFHremTbUxmScHVHefKDbz9cucJJF63hvOQ8D6XMH7Zw/rJyDwU8SYLDQsm9vJnC8KSxwGQhcis51tePvrGKTKMWawUOxQHm9FAndGlUyEnHh22XvXEDVLI2T8ZMdoNxTykcs+hn3/nNflSuMGvOCIsJ39WNeuC5Hzl8QXp0D4fR/F+Y1hUzgZnFnygrmQjLzWQGhtg9sVYRI+difTcyfqZ0ri+/BznJf3Xm3RW6+4JtlWSH6kTDhxqtzsATdfJEh1wxZRKeuwrZmXsMBsaTI2VXJt5vUsrqz9EbcP0k5njjtRNNnguFFnNSX61TjMQ==
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
Date: Tue, 2 May 2023 01:44:30 +0300
Message-ID: <20230501224430.485139-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230501224430.485139-1-parav@nvidia.com>
References: <20230501224430.485139-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: 1270c9e4-64d1-4a0d-9f06-08db4a95ad7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EpNehnjhOcIqYLhgjiaaMvCk7u2oqTyNa3hEv9lHbELfEnl2O0iNIZRfxsaOA/7tnA+d9STY7DQThwCbPu1nbEQST9u5lAHRtzgEFmWORlm9Iq6kj/iCoOxuf0S78e3WPAlPkS9s/Gg9WcN5pJShfOisPYwXP+XmxtrN52/+DRDePAsqApJXAL5KBkeMJwZvF2g5BwpGf2yrkd+xgP5I2LTVMI24/eLy59eZ8O83uoS2VZfvDXHJJ06huw5rjrXcTunm8/jNWy0ycTg2+d8dtdcyusBRttW85ImPk76/HJjDO3wr1UsBFyyV1zONqrObrAYWfr8tpm0PMN8lLwXyfa388v3ZtmWWoh6/668an3khvP3mO7awp0ngRnwqWj2y0AAQVWI7Oh+pJtI8Wymau5/YCx70DF1KuyiGXDqGRO6xgzN9TJPYzMFslLTqC8vgt10JBA9oqR0RhFa8OKIo8ISfvE1JAHKj1LORbyj46cW167v+HTI6dKOpY28HiWc+JuLsZpN+ePMwceAHq6fh7NPFp4pwu4Mt6Ru++SUV9Lfnx7ArtpEEDT/nr7GGpiZZUfaRttfFnbxowpwusFDcilMBDkppoX5lx3Y52B4J8KFU4J0athqcgQlL7oyC370M1FedTvWRa1UCfdKeUxw2lHBWnc+LMdzmTUs9K6IYuHCGaLynTVOS+mJ2qBWRNpAV8sPlyFqO9pYgWLOx9SqVxJbTodS4tR7Z5iZi/7Q29fo8ssBfmod19H5yaysPrjN2
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(36860700001)(54906003)(16526019)(1076003)(4326008)(186003)(966005)(70586007)(70206006)(478600001)(6666004)(107886003)(110136005)(26005)(40460700003)(86362001)(41300700001)(36756003)(8936002)(2616005)(8676002)(5660300002)(316002)(83380400001)(426003)(336012)(47076005)(2906002)(4744005)(82740400003)(356005)(7636003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 22:44:52.2859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1270c9e4-64d1-4a0d-9f06-08db4a95ad7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235
Subject: [virtio-dev] [PATCH 2/2] admin: Make optional command data type to u8

Command data content is specific to command opcode.
This is similar to command result field
command_specific_result.

Hence, make it u8.

This patch is on top of [1].

[1] https://lore.kernel.org/virtio-comment/cover.1682354275.git.mst@redhat.com/T/#t

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 admin.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/admin.tex b/admin.tex
index 037e2e6..648253c 100644
--- a/admin.tex
+++ b/admin.tex
@@ -85,7 +85,7 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
         /* unused, reserved for future extensions */
         u8 reserved1[12];
         le64 group_member_id;
-        le64 command_specific_data[];
+        u8 command_specific_data[];
 
         /* Device-writable part */
         le16 status;
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

