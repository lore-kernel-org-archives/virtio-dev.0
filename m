Return-Path: <virtio-dev-return-11262-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF90C64ED8
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:23:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E4389330A4
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:23:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF9CB986871
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:23:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B29C89867CA; Fri, 24 Feb 2023 22:23:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 145BF9867DB;
	Fri, 24 Feb 2023 22:22:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDNLuEt3cPpV5C2L45T9iPZCUzgQU+eDfHaWIpwhfM+yor4+AlhUplZE3gp9D4ms8d6MxfbWgXmHwMOZE1cqZx4j31KlPChwdRpCyGgZ0XkjXqIydmuAIww51rawBok6BV0hHyJVxssUCrhdMEWY9s20puTk7Tjhz0SUhYUvxwrgQeiL8LbPPW7bIanGm1p3vnZWInb9ESqbBv3pIXzsckU1UjlGbDBXIVdACacWsbTsbOwU9P1oxBzzOPztlcj2cpS0KPHO/WWcDJTFIsgXJGEQWVb3VFNC2gu8M/S8e3gTA78TnoHaFmn3oRBev5/lzTkz9y+Db1me8jxcpZb9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlQTfAjgaOPbYSPWBHKpzvNZnQMY94R1c2YECyWF2N4=;
 b=lrb8BR32qIXVhUAQc/URT/j4zIh6jevVn9yzrUo6h/Hel2GI57SX7ZB3W7MW3vhZrB+s29kcriPVJlCsSF5YdCEmJKHazXo0eiAeNqHNk9zZ1h0qlFYoWBjd6qc3zh3jQbLd7FLH8GgxYwCTYSgCH6/rB9ULh+2X6zpNHC7d1mBMigmPNdej7MrUIhIbPnRuTd7/Wb4lHnUY6kX78UsYnnfFPYEGFQy1EexR9BsRwAXq+LG7pJScsohs0Z/ALJzTEXa2dKiq2sxwLuC58hVGyDIGLdvn24GrORR+kkBWGsi62opGV9RO7aluF0TsDtgj8kadaJzYWdWlHDaZQUenxg==
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
Date: Sat, 25 Feb 2023 00:22:09 +0200
Message-ID: <20230224222215.339715-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|BN9PR12MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e80700f-47fd-4d0c-dd2d-08db16b5a3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MDhEYy77nd8ic7a15ddTPT1fRLLJOEhqxZgydmGeOMf/pQwOmsXkMaNB7Vdw0wC85ztvmnefqIUtJ0aGd2h2AeunOpESbDDZEWRKyvA0V9wi9JPlaB9Cua5lZfvjxv7q3BhnZvC52CB+OzFtRfvYlU3vyfOHXVsU4fLgVDb0rfu86o4giOu/oN64sKsa01u8yYMD17CwoDyROsyrkGor9ynAx3fEZb27DD70XPKLJGm/CMCIprmI/hTl8iVVoqd3eVcshD+PF9jrdoQCRMhxyLwhnqtOj/7xqL/PyY0cKXeeLtqr06M8pWZuI/h+pZsttYf5uX5Pwi9/drAHzqGSTH5NFIrU8g98reVOXzCTMbM3mK5h9JoCpUMVhU2B8oJ4AwQkPMuRl54QVIJNdX2Ig+XIRnCEqUaiTxr6W+12hiPQliRspTP+J67JAi1OZfYwKf5r1KOXYRhI5rCTF2b0JJYMyCTYMvds68Yw1dYuPQbhUiUyXaVVgZODtArfDwny1IIA7JF7HPSlxZbyw66RJ2rQWdRmhp26BBAt9sCRJxwcoSaeQIl8+xprwIYAXuzA8pgmWxa8vPuC9oxM+6KbDRbrrnUKZFdFT/uGwUnBXjfYtBkgHhF0f0LKyzPCH1xqqqL/VF3zX+RjQUTsin1waOScSUREzycahUJHjwmtAwxqO143cb+X3ZYSLNWeJ1idWMRKmCgyjt9D3d+BQWszFSZKnLqfx2nDpilNPCoe+xOqh1SGfIs+vHHEvA9ENmoD+bDLQG64fMoqvQtwxeDApg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199018)(36840700001)(40470700004)(46966006)(478600001)(16526019)(356005)(1076003)(8936002)(6666004)(186003)(36756003)(26005)(8676002)(107886003)(41300700001)(5660300002)(34020700004)(40480700001)(2616005)(82310400005)(47076005)(966005)(2906002)(336012)(70586007)(36860700001)(110136005)(82740400003)(86362001)(4326008)(54906003)(426003)(70206006)(7636003)(316002)(83380400001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 22:22:39.4765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e80700f-47fd-4d0c-dd2d-08db16b5a3dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
Subject: [virtio-dev] [PATCH v5 0/6] Split transport specific files
Message-ID: <20230224222209.HgEfT8dYA8OcYOP6lSQQNxpoGOcaXGtgzw5BC7nN-Uc@z>

Problem statement:
Currently several tens of pages worth of transport specification
is situated in single file. Many parts of the specification
are already maintained in separate files.

Such separate files enables better maintenance of the specification overall.

Solution:
Follow the approach similar to rest of the spec, and keep
transport specific spec in their individual files.

This series is for fixing issue [1].

[1] Fixes: https://github.com/oasis-tcs/virtio-spec/issues/157

Please review.

Patch summary:
patch 1 moves pci transport to its own file
patch 2 moves mmio transport to its own file
patch 3 moves channel io transport to its own file
patch 4 to 6 fixes spelling errors existed in the spec which are
discovered during splitting the files

changelog:
v4->v5:
- fix mmio few lines hunk was in wrong pci file
v3->v4:
- added github issue number fixes tag to patches 4 to 6
v2->v3:
- updated subject for patches 4 to 6
v1->v2:
- renamed transport-channelio.tex to transport-ccw.tex
- removed trailing white spaces in transport-ccw.tex


Parav Pandit (6):
  transport-pci: Split PCI transport to its own file
  transport-mmio: Split MMIO transport to its own file
  transport-ccw: Split Channel IO transport to its own file
  transport-pci: Fix spellings and white spaces
  transport-mmio: Fix spellings and white spaces
  transport-ccw: Fix spellings and white spaces

 content.tex        | 2318 +-------------------------------------------
 transport-ccw.tex  |  601 ++++++++++++
 transport-mmio.tex |  564 +++++++++++
 transport-pci.tex  | 1149 ++++++++++++++++++++++
 4 files changed, 2317 insertions(+), 2315 deletions(-)
 create mode 100644 transport-ccw.tex
 create mode 100644 transport-mmio.tex
 create mode 100644 transport-pci.tex

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

