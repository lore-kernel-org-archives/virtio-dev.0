Return-Path: <virtio-dev-return-12485-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC913C77B7C
	for <virtio-dev@archiver.kernel.org>; Mon,  1 May 2023 22:45:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 83A7142A6F
	for <virtio-dev@archiver.kernel.org>; Mon,  1 May 2023 22:44:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78F09986495
	for <virtio-dev@archiver.kernel.org>; Mon,  1 May 2023 22:44:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6BF9D986461; Mon,  1 May 2023 22:44:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 450ED986488;
	Mon,  1 May 2023 22:44:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WI9WuZkXEOegd2LDnx6Y4RYhgH7D0ySYudazAX6y9I5nR92C/8I1ZDl1/MOAwdRFUdukHhtA8fVbw7KQj6lnXR0AMrqeO4JlIpTVxqEjaTqVQO8rC1zpgD71XMcyUwKr8OHleJCaoqzFGi5FijQR20mHT4g7pPFI3z2Ypxq5yDNU1JEi+1GSzQFDJw13EDAPqv0hP7pT3SuQujv2dyR8cGPy51MVvtBF7gSLAJyh9uO1U52BAvP2WpqAF4SIScb73FH3kFLgbDds9YSOS7/gLIQVupfgvStCKCPPDyUuFpKfKXKcmzdppApPs6719HWGlz764R04ZbN4hLVuSHBjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PeBenuFvYXsXbS7VGyIx0Hy5zCrwxfVy2S4QDIB4zM=;
 b=YGoNAA521Kot3dV/q8Mpg2zy1h3wdfQZlqZzFdlzJ4VIiuBSWZDjsmuxbqaGvTwpFSjZUDdocWm3WSMDdCU51iDvcZEFnfa98SJKMahHKeHBarFhosvRvMtAOGT1JPaWPB6Ih/L4oz/yYbx0oXNdDvCHO2jPHJkrLjS2DFH7NuZqAbOMWsG/1kRlBZkka4sRk9e+yepm3ZbIiMtW6jyUQdjFb7vo0iiCa8c+lwuRCPuMm7DscLlxd/wgR2tUo7rUJU2ltTiCYbzqf/wPNyQC2+xHl/JBWfLOUpJpAlVVSIxd06PA3g3CwkVNcXDfnbpgna2R6cNXJhjD1AZAv3a+Bg==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 2 May 2023 01:44:28 +0300
Message-ID: <20230501224430.485139-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63E:EE_|CY8PR12MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 934c95e3-d5ef-4184-2b97-08db4a95a9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4jWex+aRbn7FjL1cgv5b5Vgdx1QTG4Nv2KkNDpeun2Ooyy+ftGlr0xK/Lng49mddOLMyGrr4JEHbdoZ07pFwJowz6mzYl2Go3IoOVFEpVWMKF1cTLiDtD7PeF0T7NwDqCzN7yrtwGNDXfmM0MHW2jnLPJwawXSaaK74wcpd/wWteoz1R3b+kYXuX0inBhQzbRXomtqwIV6sBBD8xwyQDlqPmP8yAdxWmpvDIYXhAFV9dnV+V837gLaY2zeJXkGsiFCP/s/kkDfoGOrYaCKp12MZV5j+nF7C1spD+Wo59qphI5uOkxVi9iaMzLX9dIArP2joh3aHVQd+T0QUoDOXad+retSSxzZUsknEWDj+/osItq6Y0uPd4JNYJI9kQYEFMHUUIdyEQeKE5PHaoKU15F0PSxNV9BNrWuDFn9mDV3/Q26UHHT5co2xbE3x5tpeZgfW/gc4DDkTgN9i9B5S6J+N6eH5Zr6x86WJcQ5nICluCF2UXEOJreqo7tsIE/u1c9+fn86uclLY9okLUwRfXjTxiM40VWN1WZ8OJqEZxp5ASf7VVozs6RYBT5Qum0Q7ZR2ALAwJ2uUf0RrsOm4drAGZxNYDnasd/lUf268LlWyytH1SRSuy6Gtcd/2StvJII/nK1ZiEl7BWD2iweJmrsqE6PpLOEaRZb1eexL4D2nhSxYOlAxSM6AESaHuilIMPYODCvLYSITbDDsY67PFvWwqO2eenUuxTABZf8lfoeZDCJ5ZA+JUXpjCcOCSVSysDaf
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(41300700001)(82740400003)(356005)(107886003)(7636003)(4744005)(2906002)(40460700003)(86362001)(36756003)(8936002)(8676002)(54906003)(4326008)(316002)(5660300002)(70586007)(70206006)(110136005)(478600001)(2616005)(966005)(47076005)(426003)(336012)(83380400001)(1076003)(26005)(6666004)(36860700001)(82310400005)(186003)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 22:44:46.1160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 934c95e3-d5ef-4184-2b97-08db4a95a9cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0000E63E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7124
Subject: [virtio-dev] [PATCH 0/2] admin virtqueue fixes


Hi Michael,

Please review these two small fixes for the admin virtqueue patches.
They are on top of your work of v12 at [1].

Patch summary:
patch-1 removes PCI transport dependency on deprecated migration bit
patch-2 fixes admin command command data type to be u8 similar to result

[1] https://lore.kernel.org/virtio-comment/cover.1682354275.git.mst@redhat.com/T/#t

Parav Pandit (2):
  admin: Remove dependency on the deprecated register
  admin: Make optional command data type to u8

 admin.tex | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

