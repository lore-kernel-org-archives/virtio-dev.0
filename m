Return-Path: <virtio-dev-return-11281-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2FAC64EC7
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:06:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 09EE61EAEB
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:06:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AF03E9867BD
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:06:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8986598679B; Sat, 25 Feb 2023 22:06:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5996D9866A9;
	Sat, 25 Feb 2023 22:06:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXegspOymL6tCVgsA6WxDJJdyr0cnIQ+DNY7abCcMttzI2zmKpEsEvSoxr0Xpk+EDbNFBF+V/HNdpQ4WFspaJfRIjPnNbnSaQqEr3NI8EJOeFUrzzczv2/3dsOqKEnvJAYPOPYOyt59nCNgVgg/OFrXsn/P5ucF80/lbfiTrdmUz+SoS53Zfn8e4xAPyVqxGk+4EnZStZDRQxYmdBb2P1x6MYfrZeGRMHsyJDYWot/UjVM0c1POhkO1WHW9ZaOD4lmGEnidnC6WmGH41lkAyp7nIT865KCvXPoIlKqNi0NEgeY3R286nnd6T3DRQ6TvnoTrBlbTlkRVq97NKZlJnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSu6iseqxO+nYqORXk15qcNzlOA9x3WVd85bnVKw5dA=;
 b=AvQ66wc6Y+5io4Gt7q0EGFBdj6HS5HGS3nUrpSOL6dSeJHMlgfExS7MT19CKgsysJkZK8fIvmBZ1IfNvL5v0k6qOKcaQKhPTx5xxWP7MKZoh3ARLt+XkKhUHI5zqlV7dvHF8UPhE6ot0G307aL12NkR5HLGZ4MYxWd7JnoRXbM95RNb39LD51gw0DlJi1gPJackqlf12S4cxVW5AwEuAiXyUTpr+AZ3ZQHBGnNiDC8EFrLSqiOpxQazlY4Yn1KRctnn6oCFuWyBbOY0fYAbUwrNwr4qegfdO4DDBGwXv9nG3NBgBll29S/Z+W69rbQGuQVKFnyqcvC/cZaF3vvlaeQ==
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
Date: Sun, 26 Feb 2023 00:06:34 +0200
Message-ID: <20230225220636.429990-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb68c47-f1af-4d53-683e-08db177c97b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HAO5k1uXyjlxIG67biQc1gbtuiWXZxKazYKJnwLB+oMK6YcCwjnD1yriqcaCWJqTHR+rZOxVqv/BBCgTL+o1Kcku+U/309/WqbcKvyFUcOovBHgkC5BqczKHR6JJhP9JP4f+cyswL8AFR+ntnQjvtWfmBNmCAuIqgtTlKZodfIriYapIRhk4ZjrFhi3+SsJWz4spUa4IIuqf0qzXI6PwjeUkgbj/340PfeQNo2bKJ6vmANi+rxoIZIwMKssyhtxMHXM8vG8Lwp57ef6Iuue2qvEGXwj9ZQN78B0jslp/5SsuqSh/8aI1puAxWRSPlQpkIEG/Vs2nYkW4NBz5TdK7nhorTp6/y2t7ENoHW+cps3XgxoTXLpl2NMDVZm0ws3uh7MFGhlYbHik9Glaxsnjz3LNKcG3qiwoPN9tby+uhXHSmSN8FdXWIZrNafivoeTQWzZjxQ6rM08EE6+hC4OB/c4FoqjiMR1WNEwjw6mazb+GdIgsq+XtPJfeDQfQWN8G9tG1R6SXQQxKN5OyAxUNh+8B8hTaRu2vqNPmOrxN0WQYnu/bJXAjSxcMDJuyEO5pQPVyEEntQgmccNA5FNotnR3DB+JpMj2zgfQvS9iE61yKFbPruSCDe1/4Ct5z4eHn5bkhKXJvm26Fdm2pwssSDcyb1NeMuYV9iWv8TLtoq4WTiZACtyzWkqL8EXJTK0qKQi8L4ATIsuYAK7eq7ST0a1BFCkYp4ohSPpnbVHXI05LI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(46966006)(40470700004)(36840700001)(82740400003)(6666004)(107886003)(34020700004)(40460700003)(7636003)(2906002)(1076003)(36860700001)(83380400001)(8676002)(47076005)(41300700001)(16526019)(26005)(356005)(426003)(186003)(36756003)(5660300002)(478600001)(8936002)(110136005)(316002)(4744005)(82310400005)(54906003)(40480700001)(336012)(2616005)(70206006)(86362001)(4326008)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 22:06:48.9955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb68c47-f1af-4d53-683e-08db177c97b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
Subject: [virtio-dev] [PATCH v1 0/2] Move transitional dev req to legacy interface
Message-ID: <20230225220634.sw_tO1Ho1veMRT_DRWLf63rxOoBf5jno8KZO2V9f3mM@z>

Currently the PCI transitional device discovery requirements
are located in two sections. One it located in regular device
section mixed with non transitional device normative statements.
Some of them are already located in the second legacy interface
section.

Legacy interfaces is the section to describe transitional device
requirements as mentioned in the first legacy interface section
2.2.3.

Hence move these normative statements and requirements to the
Legacy interface section.

This is only an editorial change.

patch summary:
patch-1 use capital alphabets to define device id
patch-2 move pci device id normative statements adjacent to other
requirements

changelog:
1. use lowercase letters
2. add missing '.'

Parav Pandit (2):
  transport-pci: Use lowecase alphabets
  transport-pci: Move transitional device id to legacy section

 transport-pci.tex | 82 ++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

